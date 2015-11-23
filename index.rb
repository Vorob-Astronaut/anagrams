class AnagramService
  MAX_WORD_LENGTH = 25

  @@factorials_cache = []

  attr_reader :word

  def initialize(word:)
    raise_an_error_if_does_not_match_rules!(word)

    @word = word
  end

  def index_in_anagrams
    postfixes = word_chars = word.chars

    word_chars.reduce(1) do |sum, current_char|
      postfixes.uniq.each do |char|
        if char < current_char
          frequencies = letters_frequency(postfixes)
          frequencies[char] -= 1
          sum += permutations_with_repetition_count(frequencies.values)
        end
      end

      postfixes = postfixes[1..-1]
      sum
    end
  end

  private

    def letters_frequency(letters)
      letters.group_by(&:chr).reduce({}) do |acc, value|
        acc[value.first] = value.last.count

        acc
      end
    end

    def permutations_with_repetition_count(values)
      fact(values.reduce(:+)) / multiplication_of_factorials(values)
    end

    def multiplication_of_factorials(values)
      values.inject(1) { |acc, value| acc * fact(value) }
    end

    def fact(number)
      return @@factorials_cache[number] if @@factorials_cache[number]

      @@factorials_cache[number] = (1..number).reduce(1, :*)
    end

    def raise_an_error_if_does_not_match_rules!(word)
      fail "Length of the word should be #{MAX_WORD_LENGTH} chars or less" if word.length > MAX_WORD_LENGTH
    end
end
