class Api::CommentsController < Api::ApplicationController
    def index
      article = Article.find(params[:article_id])
      comments = article.comments
      render json: comments
    end

    def create
      article = Article.find(params[:article_id])
      @comment = article.comments.build(comment_params)
      @comment.save!
        # 必ず保存できることを想定してsave!としている。なにかおかしければJS側で通知してあげる、
      render json: @comment
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
        #{comment: {content: 'aaaaaaa'}}と値がなっていないとNG
    end
end
