function get_score(stream::IO)
  score = 0
  depth = 0
  is_garbage = false
  garbage_count = 0

  while !eof(stream)
    char = read(stream, Char)

    while char == '!'
      char = read(stream, Char)
      char = read(stream, Char)
    end

    if is_garbage && char != '>'
      garbage_count += 1
    elseif char == '<'
      is_garbage = true
    elseif char == '>'
      is_garbage = false
    elseif char == '{'
      depth += 1
      score += depth
    elseif char == '}'
      depth -= 1
    end
  end

  return score, garbage_count
end

(score, garbage_count) = get_score(STDIN)
println("Score: $score, Garbage count: $garbage_count")