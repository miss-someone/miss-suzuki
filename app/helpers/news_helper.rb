module NewsHelper
  
  def news_column_class(index)
    if index.odd? then "odd" else "even" end
  end

end
