module ArrayUtils
  class << Array
    def split3(a)
      if (a.size % 3 == 1)
        array = a.each_slice(a.size / 3).to_a
        [array[0]+array[3], array[1], array[2]]
      elsif (a.size % 3 == 2)
        a.each_slice(a.size / 3 + 1).to_a
      else
        a.each_slice(a.size / 3).to_a
      end
    end
  end
end
