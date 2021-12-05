lines = File.open(ARGV[0]).readlines.map do |line|
  line.strip!.split("").map(&:to_i)
end

rates = { gamma: "", epsilon: "" }
result = lines.transpose.each_with_object(rates) do |list, bits_so_far|
  min, max = list.minmax_by { |bit| list.count(bit) }
  bits_so_far[:gamma] += max.to_s
  bits_so_far[:epsilon] += min.to_s
end

gamma = result[:gamma]
epsilon = result[:epsilon]

# parse bitstring as binary and return it as a decimal
gamma_d = gamma.to_i(2)
epsilon_d = epsilon.to_i(2)
consumption = gamma_d * epsilon_d

print <<~RESULT
  Gamma rate: #{gamma} (#{gamma_d})
  Epsilon rate: #{epsilon} (#{epsilon_d})
  Power consumption is: #{consumption}
RESULT
