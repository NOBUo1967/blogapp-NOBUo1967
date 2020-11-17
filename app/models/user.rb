# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorite_articles, through: :likes, source: :article

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  #:following_relationships = 自分がfollowerになっているものをもってくれば誰をfollowしているかわかる。
  #foreign_key: 'follower_id' = 外部キー。railsはhas_manyすれば勝手に察してくれるが今回はuser_idではないため指定。
  #class_name: 'Relationship'  = :following_relationshipsというtableやmodelは存在しないため、なんのmodelのことか教える。
  has_many :followings, through: :following_relationships, source: :following
  #followしているuserを取ってくるにはRelationship_tableをまたいで取ってこないといけない。
  #followings = folowしているuserのことをfollowingsとしている。
  #through: :following_relationships
  #source: :following = followしている相手をfollowingとしている。following_idを取得。

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  #followされている側から見ると外部キーはfollowing_idになる。
  has_many :followers, through: :follower_relationships, source: :follower

  has_one :profile, dependent: :destroy

  delegate :birthday, :age, :gender, to: :profile, allow_nil: true

  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def has_liked?(article)
    likes.exists?(article_id: article.id)
  end

  def follow!(user)
    #followの!は例外が発生するメソッドであることを明示的にしている。
    user_id = get_user_id(user)
    #user_classのインスタンスが渡ってきたらuserのidを取得して代入する。
    #userのidがそのまま渡ってきたらそのまま代入する。
    following_relationships.create!(following_id: user_id)
  end

  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
    #current_user.has_followed?(User.second)のように使う
    #current_userのfollowing_relationshipsの中にfollowing_idが引数のuserが存在するかを確認する
  end

  def unfollow!(user)
    user_id = get_user_id(user)
    relation = following_relationships.find_by!(following_id: user_id)
    #find_byに!をつけることで値が存在しなければ例外が発生して処理が止まる。
    #followを外すときに自分がfollowしていないuserからfollowを外すことはありえない。
    #following_relationshipsに対象userが存在していないとおかしい。
    relation.destroy!
    #削除されるのが当然なので!をつける
  end

  def prepare_profile
    profile || build_profile
  end

  private
  def get_user_id(user)
    #follow_methodとunfollowの中でしか使わない。
    #private以下のmethodはUserのインスタンスでは呼び出せない
    if user.is_a?(User) #is_a? =引数のクラスのインスタンスであるかどうかをチェックしてくれる
      user.id
    else
      user
    end
  end
end
