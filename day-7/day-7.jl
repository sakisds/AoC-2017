# Part 2 gets really messy

struct Program
  weight::Int
  children::Array{String, 1}
end

function get_total_weight(name, programs)
  program = programs[name]
  weight = program.weight
  for child_name in program.children
    weight += get_total_weight(child_name, programs)
  end

  return weight
end

function find_unbalanced_child(name, programs)
  program = programs[name]

  children_weight = map(child -> get_total_weight(child, programs), program.children)
  uneven_children = findin(map(w -> w == children_weight[1], children_weight), false)

  len = length(uneven_children)
  if len == 0
    return -1
  elseif len == 1
    return uneven_children[1]
  else
    return 1
  end
end

function find_unbalance(name, previous, programs)
  unbalance_index = find_unbalanced_child(name, programs)
  if unbalance_index != -1
    program = programs[name]
    return find_unbalance(program.children[unbalance_index], name, programs)
  else
    previous_program = programs[previous]
    unbalance_index = find_unbalanced_child(previous, programs)

    wrong_total_weight = get_total_weight(previous_program.children[unbalance_index], programs)
    correct_total_weight = get_total_weight(previous_program.children[unbalance_index + 1], programs)

    delta = min(wrong_total_weight, correct_total_weight) - max(wrong_total_weight, correct_total_weight)

    corrected_weight = programs[previous_program.children[unbalance_index]].weight + delta

    println("Correct weight: $corrected_weight")
    return previous
  end
end

# Add eveything to the array
programs = Dict{String, Program}()
for line in eachline(STDIN)
  # Get name
  name_end = search(line, ' ') - 1
  name = line[1:name_end]

  # Get weight
  weight_start = search(line, '(') + 1
  weight_end = search(line, ')') - 1
  weight = parse(Int, line[weight_start:weight_end])

  # Get children
  children = Array{SubString}(0)
  if contains(line, "->")
    children_start = search(line, '>') + 2
    children = split(line[children_start:end], ", ")
  end

  # Add to program list
  programs[name] = Program(weight, children)
end

# Find bottom program
is_child_list = Array{String, 1}(0)
for (name, program) in programs
  for child in program.children
    push!(is_child_list, String(child))
  end
end

bottom_program = ""
for (name, program) in programs
  if !in(name, is_child_list)
    bottom_program = name
    println("Bottom program is $name")
    break
  end
end

find_unbalance(bottom_program, "", programs)