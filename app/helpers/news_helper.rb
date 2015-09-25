module NewsHelper
  #奇数列と偶数列であてるクラスを変更する
  def news_column_class(index)
    index.odd? ? "odd" : "even"
  end
end
