module Services
  module AnagramHelper
    def self.included(base_class)
      base_class.extend(ClassMethods)
    end

    def random_word_with_length(length)
      [*('A'..'z')].sample(length).join
    end

    module ClassMethods
      def it_should_return_a_right_position(word:, right_position:)
        it 'should return a right position' do
          position = AnagramService.new(word: word).index_in_anagrams

          expect(position).to eq(right_position)
        end
      end
    end
  end
end
