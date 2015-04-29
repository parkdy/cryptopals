=begin
  
Fixed XOR
Write a function that takes two equal-length buffers and produces their XOR combination.

If your function works properly, then when you feed it the string:

1c0111001f010100061a024b53535009181c
... after hex decoding, and when XOR'd against:

686974207468652062756c6c277320657965
... should produce:

746865206b696420646f6e277420706c6179
  
=end

require_relative '01_Convert_hex_to_base64'

module Challenge2
  extend self

  def fixed_xor(hex1, hex2)
    bytes1 = Challenge1.hex_to_bytes(hex1)
    bytes2 = Challenge1.hex_to_bytes(hex2)
    
    xor = ""
    bytes1.each_with_index do |byte, index|
      xor << (byte ^ bytes2[index]).to_s(16)
    end

    return xor
  end
end