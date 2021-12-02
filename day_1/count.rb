lines = File.open(ARGV[0]).readlines.map { |l| l.strip; l.to_i }

result = lines.each_cons(2).reduce(0) do |num_increases, (first, second)|
  num_increases += 1 if second > first
  num_increases
end

print "#{result} increases"
