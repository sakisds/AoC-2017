instructions = []
for line in eachline(STDIN, chomp = true)
  push!(instructions, parse(Int, line))
end
len = length(instructions)

index = 1
steps = 0
while index > 0 && index <= len
  jump = instructions[index]
  instructions[index] += (jump >= 3) ? -1 : 1
  index += jump
  steps += 1
end

println("Step count for part 2: $steps")