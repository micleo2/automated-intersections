arr = [413, 321, 654, 23, 11]
(0...arr.length).each do |outer_i|
    (0...arr.length).each do |inner_i|
        next if outer_i == inner_i
        arr[outer_i] + arr[inner_i]
    end
end
