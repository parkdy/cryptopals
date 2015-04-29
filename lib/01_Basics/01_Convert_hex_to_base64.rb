=begin

Convert hex to base64
The string:

49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d
Should produce:

SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t
So go ahead and make that happen. You'll need to use this code for the rest of the exercises.

Cryptopals Rule
Always operate on raw bytes, never on encoded strings. Only use hex and base64 for pretty-printing.

=end

module Challenge1
  extend self

  def hex_to_base64(hex)
    binary = self.hex_to_bytes(hex)
    return self.bytes_to_base64(binary)
  end

  def hex_to_bytes(hex)
    hex.chars.each_slice(2).map do |hex_block|
      hex_block.join.to_i(16)
    end
  end

  def bytes_to_base64(bytes)
    base64 = ""
    bytes.each_slice(3).each do |byte_block|
      base64 += self.encode_block(byte_block)
    end

    return base64
  end

  def encode_block(byte_block)
    base64 = ""

    num_bytes = byte_block.length
    padding = '=' * (3 - num_bytes)

    padded_block = self.bytes_to_binary(byte_block).rjust(24, '0')
    base64_map = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ['+', '/']
    
    (0...padded_block.length - 6 * padding.length).step(6) do |start_index|
      base64_index = padded_block.slice(start_index, 6).to_i(2)
      base64_char = base64_map[base64_index]
      base64 += base64_char
    end

    return base64 + padding
  end

  def bytes_to_binary(bytes)
    bytes.map{ |byte| byte.to_s(2).rjust(8, '0') }.join
  end
end

