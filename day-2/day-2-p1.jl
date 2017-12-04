# Part 1
checksum = 0;
for line in eachline(STDIN)
  input = parse.(Int, split(line, ' '))
  checksum = checksum + (maximum(input) - minimum(input))
end

println("Part 1: $checksum")