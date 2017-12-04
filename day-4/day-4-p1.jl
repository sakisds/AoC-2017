using Combinatorics

valid_count = 0
for passphrase in eachline(STDIN)
  words = split(passphrase, " ")
  is_valid = true

  for (w1, w2) in combinations(words, 2)
    if w1 == w2
      is_valid = false
      break
    end
  end

  if is_valid
    valid_count += 1
  end
end

println("Valid passphrases for part 1: $valid_count")