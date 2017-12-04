using Combinatorics

# Part 2
checksum = 0;
for line in eachline(STDIN)
  input = parse.(Int, split(line, ' '))

  for (x, y) in combinations(input, 2)
    if x % y == 0
      checksum += Int(x / y)
      break
    end

    if y % x == 0
      checksum += Int(y / x)
      break
    end
  end
end

println("Part 2: $checksum")