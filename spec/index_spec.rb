require './spec/spec_helper.rb'
require 'benchmark'

describe AnagramService, anagram_helpers: true do
  it 'should raise an exeption if word length greater than allowed' do
    long_word = random_word_with_length(AnagramService::MAX_WORD_LENGTH + 1)
    regexp_to_math_an_error = /#{AnagramService::MAX_WORD_LENGTH}/

    expect { AnagramService.new(word: long_word) }.
      to raise_error.with_message(regexp_to_math_an_error)
  end

  context 'index_in_anagrams' do
    it 'should perform a method in the specified time' do
      anagram_service = AnagramService.new(word: word_in_worse_case)

      expect(Benchmark.realtime{anagram_service.index_in_anagrams}).
        to be < 0.05
    end

    {aaab: 1, abab: 2, baaa: 4, coolword: 406, beekeeper: 63, zoologist: 57649}.each do |word, right_position|
      it_should_return_a_right_position(word: word.to_s, right_position: right_position)
    end
  end

  def word_in_worse_case
    [*('a'..'z')].last(AnagramService::MAX_WORD_LENGTH).reverse.join
  end
end
