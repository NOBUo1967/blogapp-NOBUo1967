module TabsHelper
  # module ≒ classに組み込むためのもの。ここではhelperにはmoduleとかくものとだけ説明。
  def add_active_class(path)
    'active' if current_page?(path)
    # pathがcurrent_pageであればactiveを返す
  end
end
