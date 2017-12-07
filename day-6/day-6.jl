function is_known_state(memory, history, max_index)  
  for i = 1:max_index
    if history[i, :] == memory
      return true
    end
  end

  return false
end

function reallocate!(memory)
  # Find where the most blocks are hiding and remove them
  max_blocks = maximum(memory)
  index = minimum(findin(memory, max_blocks));
  memory[index] = 0

  # Redistribute the blocks on the rest
  for i = 1:max_blocks
    len = length(memory)
    memory[mod(index + i - 1, len) + 1] += 1
  end  
end

function solve_part_1!(memory)
  len = length(memory)
  history = zeros(10000, len);

  step_count = 0
  while !is_known_state(memory, history, step_count)
    # Store current state in memory
    history[step_count + 1, :] = memory
    step_count += 1

    # Reallocate memory
    reallocate!(memory)
  end

  return step_count
end

function solve_part_2(memory)
  # Copy the original state of the memory
  original = copy(memory)

  # Reallocate the memory
  step_count = 0
  while true
    reallocate!(memory)
    step_count += 1

    # Until it becomes the same as the original
    memory == original && break
  end

  return step_count
end

input = [4, 1, 15, 12, 0, 9, 9, 5, 5, 8, 7, 3, 14, 5, 12, 3];
input_test_1 = [0, 2, 7, 0]
input_test_2 = [2, 4, 1, 2]

@printf("Steps for part 1 test: %d\n", solve_part_1!(input_test_1))
@printf("Steps for part 1: %d\n", solve_part_1!(input))

@printf("Steps for part 2 test: %d\n", solve_part_2(input_test_2))
@printf("Steps for part 2: %d\n", solve_part_2(input))