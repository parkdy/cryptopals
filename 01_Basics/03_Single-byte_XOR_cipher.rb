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

def hex_to_bytes(hex)
  num_bytes = hex.length / 2
  bytes = Array.new(num_bytes)

  for i in 0...num_bytes
    bytes[i] = hex.slice(i*2, 2).to_i(16)
  end

  bytes
end

def single_byte_xor_cipher(hex)
  hex_bytes = hex_to_bytes(hex)

  # Brute force ascii characters
  (0...128).each do |code|
    decrypted_string = hex_bytes.map{ |byte| (byte ^ code).chr }.join

    puts "="*10
    puts "KEY: #{code.chr}"
    puts decrypted_string
    puts
  end
end

# Key: 'X'
# Decrypted Message: "Cooking MC's like a pound of bacon"