module NewsHelper
  def news_column_class(index)
    index.odd? ? "odd" : "even"
  end
end
