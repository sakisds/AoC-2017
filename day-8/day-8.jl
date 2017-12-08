struct Instruction
  register::String
  operation::Function
  condition_register::String
  condition::Function
end

function instruction_from_source(source::String)
  # Split at spaces
  words = split(source, ' ')

  # Instruction parameters
  register = words[1]
  value = parse(Int, words[3])
  words[2] == "inc" && (operation = (x) -> x + value)
  words[2] == "dec" && (operation = (x) -> x - value)

  # Condition
  condition_register = words[5]
  condition_value = parse(Int, words[7])

  words[6] == "==" && (condition = (x) -> x == condition_value)
  words[6] == ">" && (condition = (x) -> x > condition_value)
  words[6] == "<" && (condition = (x) -> x < condition_value)
  words[6] == ">=" && (condition = (x) -> x >= condition_value)
  words[6] == "<=" && (condition = (x) -> x <= condition_value)
  words[6] == "!=" && (condition = (x) -> x != condition_value)

  return Instruction(register, operation, condition_register, condition)
end

function execute(registers, instructions)
  max_value = 0

  for instr in instructions
    # Check if condition is met
    if instr.condition(get(registers, instr.condition_register, 0))
      # Calculate new value
      new_value = instr.operation(get(registers, instr.register, 0))

      # Set to register and compare with old max value
      registers[instr.register] = new_value
      max_value = max(max_value, new_value)
    end
  end

  return max_value
end

# Create an array of all instructions
instructions = map(line -> instruction_from_source(line), eachline(STDIN))

# Execute input
registers = Dict{String, Int}()
max_value = execute(registers, instructions)
println("Max value ever used: $max_value")

# Find max
max_register = reduce((x, y) -> registers[x] >= registers[y] ? x : y, keys(registers))
println("Max value at register $max_register: $(registers[max_register])")