require "01_Basics/01_Convert_hex_to_base64"
require "01_Basics/02_Fixed_XOR"
require "01_Basics/03_Single-byte_XOR_cipher"

describe "Challenge1" do
  describe ".hex_to_base64" do
    it "should convert a hex encoded string to base64" do
      hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
      
      base64 = Challenge1.hex_to_base64(hex)
      expect(base64).to eq("SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t")
    end
  end
end

describe "Challenge2" do
  describe ".fixed_xor" do
    it "should return the XOR combination of 2 equal length hex encoded strings" do
      hex1 = "1c0111001f010100061a024b53535009181c"
      hex2 = "686974207468652062756c6c277320657965"
      
      xor = Challenge2.fixed_xor(hex1, hex2)
      expect(xor).to eq("746865206b696420646f6e277420706c6179")
    end
  end
end

describe "Challenge3" do
  describe ".single_byte_xor_cipher" do
    it "should crack a single character XOR cipher" do
      hex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
      
      best_candidate = Challenge3.single_byte_xor_cipher(hex)
      key = best_candidate[:key]
      decrypted_message = best_candidate[:decrypted_message]

      expect(key).to eq('X')
      expect(decrypted_message).to eq("Cooking MC's like a pound of bacon")
    end
  end
end