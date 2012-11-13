# brute force
def search_string_brute_force(text, word)
  return 0 if word.nil?
  return -1 if text.nil? || word.size == 0
  return -1 if word.length > text.length

  word = word.split("")
  text_len = text.length
  word_len = word.length
  i = 0
  index = 0

  while i < text_len do
    index = 0
    while index < word_len
      if text[i+index] == word[index]
        index += 1
      else 
        break
      end
    end
    return i if index == word_len 
    i += 1
  end

  return -1
end

# Knuth–Morris–Pratt (DB) 
# returns the begining of a match or -1 if there is none
def search_string(text, word)
  return 0 if word.nil?
  return -1 if text.nil? || word.size == 0
  return -1 if word.length > text.length

  m = 0 # beggning of the current match in text, the current match could be nothign for m = x
  i = 0 # position of the current character in word

  table = build_partial_match_table(word)

  text = text.split("")
  word = word.split("")


  while m+1 < text.size do

    if word[i] == text[i+m]
      return m if i == word.size - 1
      i += 1
    else
      # if nothing matches so far (i = 0), table[0] is -1 so it increments by one
      # if it has matched bunch of characters but not anymore (i = 6), table[i] = 5, 
      # m + 6 - 5 = m + 1: so it incrememnts again
      m = m + i - table[i] 

      if table[i] > -1 
        i = table[i]
      else
        i = 0
      end
    end

  end
  return -1
end

# The matching table:
# value at index i ( table[i] ) shows if the index i-1 was a match  
def build_partial_match_table(word)
  return [] if word.length == 0

  table = []*word.length
  table[0] = -1 # if failed at first letter, jump to next letter
  table[1] = 0  # if the first character matches, and the next one doesn't match we just jump to the next letter there is no where else to go 

  i_w = 0 # goes through the word, resets if the word doesn't repeats itself
  i_t = 2 # goes through the match table which is as long as the word, but it keeps going
  w = word.split("")
  
  while i_t < w.length do
    if w[i_w] == w[i_t - 1]
      # find the next repeated character starting from first letter of word
      i_w += 1
      table[i_t] = i_w
      i_t += 1
    elsif i_w > 0
      # this is for when the words initial patern keep repeating itself more or less, 
      # for example we have string = [x substring]...[y substring]
      # abcabd...abcabc, the last c in x doesn't match the d in y substring
      # so then it wants to see if there was some initial patern that the abd had matched
      # against, so then it sees that the b in x at 4 matches the b at x at 2 according to table
      # so then it checks the next character c in x against next character c in y, and sees they match
      # if we skip this step then we would have start from the begginign of string word
      i_w = table[i_w]
    elsif i_w == 0
      # the i_w is 0, means nothing has mapped to the word characters in order so far for this substring
      # for the current i_w it does not match match to word at i_t - 1, means the current character we are looking at (i_t -1)
      # is not the same as index we're looking at in the word (for start is 0)
      table[i_t] = 0
      i_t += 1
    end
  end
  table
end
