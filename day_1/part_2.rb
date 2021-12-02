# For a list of numbers with window annotations
#
# lines = File.open(ARGV[0]).readlines

# depth_sums = lines.each_with_object(Hash.new(0)) do |lines, hash|
#   depth, windows = lines.split(/\s+/, 2)
#
#   windows.split(/\s+/).each do |window|
#     hash[window] += depth.to_i
#   end
# end
#
# result = depth_sums.keys.sort.each_cons(2).reduce(0) do |num_increases, (first, second)|
#   num_increases += 1 if depth_sums[second] > depth_sums[first]
#   num_increases
# end

# For a list of numbers as input
lines = File.open(ARGV[0]).readlines.map { |l| l.strip; l.to_i }

result = lines.each_cons(4).reduce(0) do |num_increases, (a, b, c, d)|
  first = a + b + c
  second = b + c + d
  num_increases += 1 if second > first
  num_increases
end

print "#{result} increases"
