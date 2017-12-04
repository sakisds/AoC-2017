using Combinatorics

function is_anagram(w1, w2)
  return length(findin(w1, w2)) == length(w1) == length(w2)
end

valid_count = 0
for passphrase in eachline(STDIN)
  words = split(passphrase, " ")
  anagram_found = false

  for (w1, w2) in combinations(words, 2)
    if is_anagram(w1, w2)
      anagram_found = true
      break
    end
  end

  if !anagram_found
    valid_count += 1
  end
end

println("Valid passphrases for part 2: $valid_count")