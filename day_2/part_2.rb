lines = File.open(ARGV[0]).readlines
pos = { h: 0, d: 0, a: 0 }

result = lines.each_with_object(pos) do |instruction, position|
  dir, units = instruction.split(/\s+/)
  num_units = units.to_i

  case dir
  when "forward"
    position[:h] += num_units
    position[:d] += position[:a] * num_units
  when "up"
    position[:a] -= num_units
  when "down"
    position[:a] += num_units
  end

  position
end

print <<~RESULT
  Horizontal: #{result[:h]}
  Depth: #{result[:d]}
  Aim: #{result[:a]}
  Product: #{result[:h] * result[:d]}
RESULT
