=begin 

Single-byte XOR cipher
The hex encoded string:

1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736
... has been XOR'd against a single character. Find the key, decrypt the message.

You can do this by hand. But don't: write code to do it for you.

How? Devise some method for "scoring" a piece of English plaintext. Character frequency is a good metric. Evaluate each output and choose the one with the best score.

Achievement Unlocked
You now have our permission to make "ETAOIN SHRDLU" jokes on Twitter.

=end

require_relative "01_Convert_hex_to_base64"

module Challenge3
  extend self

  def single_byte_xor_cipher(hex)
    hex_bytes = Challenge1.hex_to_bytes(hex)

    # Brute force ascii characters
    candidates = []
    (0...128).each do |code|
      key = code.chr
      decrypted_message = hex_bytes.map{ |byte| (byte ^ code).chr }.join

      analyzer = EnglishAnalyzer.new(decrypted_message)
      analyzer.analyze
      error = analyzer.error

      candidates << { encrypted_message: hex, key: key, decrypted_message: decrypted_message, error: error }
    end

    sorted_candidates = candidates.sort_by{ |try| try[:error] }
    best_candidate = sorted_candidates.first
  end



  class EnglishAnalyzer
    ALLOWABLE_NON_LETTER_PERCENTAGE = 30 # Maximum allowable percentage of non-alphabetic characters in the string

    # http://www.wolframalpha.com/input/?i=average+english+word+length
    AVERAGE_WORD_LENGTH = 5.1
    WHITESPACE_FREQUENCY = 100.0 / AVERAGE_WORD_LENGTH

    # http://en.algoritmy.net/article/40379/Letter-frequency-English
    LETTER_PERCENT_FREQUENCIES = {
      'a' => 8.167,
      'b' => 1.492,
      'c' => 2.782,
      'd' => 4.253,
      'e' => 12.702,
      'f' => 2.228,
      'g' => 2.015,
      'h' => 6.094,
      'i' => 6.966,
      'j' => 0.153,
      'k' => 0.772,
      'l' => 4.025,
      'm' => 2.406,
      'n' => 6.749,
      'o' => 7.507,
      'p' => 1.929,
      'q' => 0.095,
      'r' => 5.987,
      's' => 6.327,
      't' => 9.056,
      'u' => 2.758,
      'v' => 0.978,
      'w' => 2.360,
      'x' => 0.150,
      'y' => 1.974,
      'z' => 0.074
    }

    attr_accessor :string, :error

    def initialize(string)
      @string = string
      @error = 0
    end

    def analyze
      total_count = 0
      letter_count = 0
      whitespace_count = 0

      letter_counts = Hash.new(0)

      # Get character counts
      @string.downcase.chars.each do |char|
        total_count += 1

        if char.match(/[a-z]/)
          letter_count += 1
          letter_counts[char] += 1
        elsif char.match(/\s/)
          whitespace_count += 1
        end
      end

      # Limit the number of non-alphabetic characters
      non_letter_percentage = 100.0 * (total_count - letter_count) / total_count
      if non_letter_percentage > ALLOWABLE_NON_LETTER_PERCENTAGE
        @error += 100
        return
      end

      # Get the average word length
      words = @string.split("\\s+")
      average_word_length = words.inject(0.0){ |total, word| total + word.length } / words.count

      # Get the frequency of whitespace characters
      whitespace_frequency = 100.0 * whitespace_count / total_count

      # Get the most and least common letters in the string
      sorted_letters = letter_counts.sort_by{ |letter, count| count }.map(&:first)
      top_letters = sorted_letters.last(6)
      bottom_letters = sorted_letters.first(6)

      # Get the most and least common letters in the English language
      sorted_letters_english = LETTER_PERCENT_FREQUENCIES.sort_by{ |letter, freq| freq }.map(&:first)
      top_letters_english = sorted_letters_english.last(6)
      bottom_letters_english = sorted_letters_english.first(6)

      # Error ranges from 0-10
      @error = (top_letters_english - top_letters).count
      @error += 0.5 * (bottom_letters_english - bottom_letters).count
      @error += 0.5 * (average_word_length - AVERAGE_WORD_LENGTH).abs.to_f / AVERAGE_WORD_LENGTH
      @error += 0.5 * (whitespace_frequency - WHITESPACE_FREQUENCY).abs.to_f / WHITESPACE_FREQUENCY
    end
  end
end

