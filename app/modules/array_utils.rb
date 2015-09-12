module ArrayUtils
  class << Array
    def split3(a)
      split_size = calc_split3_size(a)
      array = a.each_slice(split_size).to_a
      case array.size
      when 0 then Array.new(3, [])
      when 1, 2 then array + Array.new(3 - array.size, [])
      when 3 then array
      when 4 then [array[0] + array[3], array[1], array[2]]
      end
    end

    private

    # 3分割する際の, each_sliceの引数を計算する
    def calc_split3_size(a)
      size =  case a.size % 3
              when 0, 1 then a.size / 3
              when 2 then a.size / 3 + 1 # (3 + 1)
              end
      if size != 0
        size
      else
        1
      end
    end
  end
end
