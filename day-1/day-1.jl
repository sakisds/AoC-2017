function circ_get(str::String, index::Integer)
  while index > length(str)
    index = index - length(str)
  end
  return str[index]
end

# Read input
input = readline(STDIN)

## Part 1
# Sum
sum = 0

# Find pairs
for (i, c) in enumerate(input)
  if c == circ_get(input, i + 1)
    sum = sum + parse(Int64, c)
  end
end

println("Part 1: $sum");

## Part 2
sum = 0
for (i, c) in enumerate(input)
  if c == circ_get(input, i + convert(Integer, length(input) / 2))
    sum = sum + parse(Int64, c)
  end
end

println("Part 2: $sum");