input = 347991

# Part 1
function side_length(number:: Int)
  root = ceil(sqrt(number))
  if root % 2 == 0
    return root + 1
  else
    return root
  end
end

function get_position(number:: Int)
  slength = side_length(number)
  x = floor(slength / 2)
  
  side_centers = slength^2 - ((slength - 1) * collect(1:4)) - floor(slength / 2)
  y = minimum(abs.(side_centers - number))

  return x, y
end

(x, y) = abs.(get_position(input))
println("Part 1: $(x + y) steps from ($x, $y)")

# Part 2
mutable struct NegativeIndexSquareArray
  size::Int
  content::Array{Int, 3}

  NegativeIndexSquareArray(size) = new(size, zeros(size, size, 4))
end

function Base.getindex(array::NegativeIndexSquareArray, x, y)
  sx = sign(x) == 0? 1 : sign(x)
  sy = sign(y) == 0? 1 : sign(y)
  (x, y) = abs.([x, y])

  if sx == 1 && sy == 1
    array.content[x + 1, y + 1, 1]
  elseif sx == 1 && sy == -1
    array.content[x + 1, y, 2]
  elseif sx == -1 && sy == 1
    array.content[x, y + 1, 3]
  else # Both negative
    array.content[x, y, 4]
  end
end

function Base.setindex!(array::NegativeIndexSquareArray, value, x, y)
  sx = sign(x) == 0? 1 : sign(x)
  sy = sign(y) == 0? 1 : sign(y)
  (x, y) = abs.([x, y])

  if sx == 1 && sy == 1
    array.content[x + 1, y + 1, 1] = value
  elseif sx == 1 && sy == -1
    array.content[x + 1, y, 2] = value
  elseif sx == -1 && sy == 1
    array.content[x, y + 1, 3] = value
  else # Both negative
    array.content[x, y, 4] = value
  end
end

spiral = NegativeIndexSquareArray(10)
spiral[0, 0] = 1
(x, y) = [1, 0]
direction = im

while true
  spiral[x, y] = spiral[x - 1, y] + spiral[x - 1, y - 1] +
    spiral[x, y - 1] + spiral[x + 1, y - 1] + spiral[x + 1, y] +
    spiral[x + 1, y + 1] + spiral[x, y + 1] + spiral[x - 1, y + 1]

  if spiral[x, y] > input
    println("Part 2: $(spiral[x, y]) at ($x, $y)")
    break
  end

  left = direction * im
  if spiral[x + real(left), y + imag(left)] == 0
    direction = left
  end
  x += real(direction)
  y += imag(direction)
end