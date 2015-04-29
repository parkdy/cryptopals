=begin

Detect single-character XOR

http://cryptopals.com/static/challenge-data/4.txt

One of the 60-character strings in this file has been encrypted by single-character XOR.

Find it.

(Your code from #3 should help.)

=end

require_relative '03_Single-byte_XOR_cipher'

module Challenge4
  extend self

  def detect_single_character_xor(hex_strings)
    candidates = []
    hex_strings.each do |hex|
      candidates << Challenge3.single_byte_xor_cipher(hex)
    end

    sorted_candidates = candidates.sort_by{ |try| try[:error] }
    best_candidate = sorted_candidates.first
  end
end