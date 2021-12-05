report = File.open(ARGV[0]).readlines.map do |line|
  line.strip!.split("").map(&:to_i)
end

# transposes the given lines such that:
# - the first element is a list of bits at the first position,
# - the second element is is a list of bits at the second position, etc.
#
# then, using the element positioned at the given index, calculate which bits
# appear the most and the least
def calculate_minmax(lines, index)
  bits = lines.transpose[index]
  bits.minmax_by { |b| bits.count(b) }
end

def calculate_o2(lines)
  current_pos = 0

  until lines.one?
    min, max = calculate_minmax(lines, current_pos)
    criterion = min == max ? 1 : max

    lines.select! { |line| line[current_pos] == criterion }

    current_pos += 1
  end

  lines
end

def calculate_co2(lines)
  current_pos = 0

  until lines.one?
    min, max = calculate_minmax(lines, current_pos)
    criterion = min == max ? 0 : min

    lines.select! { |line| line[current_pos] == criterion }

    current_pos += 1
  end

  lines
end

o2_gen = calculate_o2(report.dup).first.join
co2_scrub = calculate_co2(report.dup).first.join

# parse bitstring as binary and return it as a decimal
o2_gen_d = o2_gen.to_i(2)
co2_scrub_d = co2_scrub.to_i(2)
life_support = o2_gen_d * co2_scrub_d

# print results
print <<~RESULT
  Oxygen generator rating: #{o2_gen} (#{o2_gen_d})
  CO2 scrubber rating: #{co2_scrub} (#{co2_scrub_d})
  -> Life support rating: #{life_support}
RESULT
