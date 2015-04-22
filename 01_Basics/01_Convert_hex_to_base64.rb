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

# http://en.wikipedia.org/wiki/Base64

def hex_to_base64(hex)
  binary = hex_to_binary(hex)
  return binary_to_base64(binary)
end

def hex_to_binary(hex)
  hex.to_i(16).to_s(2).rjust(hex.length * 4, '0')
end

def binary_to_base64(binary)
  base64 = ""
  (0...binary.length).step(24) do |start_index|
    block = binary.slice(start_index, 24)
    base64 += encode_block(block)
  end

  return base64
end

def encode_block(block)
  base64 = ""

  num_bytes = block.length / 8
  padding = '=' * (3 - num_bytes)

  padded_block = block.ljust(24, '0')
  base64_map = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ['+', '/']
  
  (0...padded_block.length - 6 * padding.length).step(6) do |start_index|
    base64_index = padded_block.slice(start_index, 6).to_i(2)
    base64_char = base64_map[base64_index]
    base64 += base64_char
  end

  return base64 + padding
end