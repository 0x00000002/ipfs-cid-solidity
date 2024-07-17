# Base32 encoding

The algorithm for converting a string to a Base32 encoded string involves several steps. Below is a general outline of the process:

1. Convert the String to Binary: Each character in the string is converted to its binary representation.
2. Group Binary Data: The binary data is grouped into 5-bit chunks because Base32 uses 5 bits per character.
3. Pad if Necessary: If the final group of binary data contains fewer than 5 bits, pad it with zeros to make it a full 5-bit chunk.
4. Map to Base32 Alphabet: Each 5-bit chunk is then mapped to a character in the Base32 alphabet.
5. Add Padding Characters: If necessary, add padding characters `=` to make the output length a multiple of 8 characters.

### Base32 Alphabet

The Base32 alphabet typically includes the following characters:

`A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 2, 3, 4, 5, 6, 7`

## Detailed Steps

1. Convert the String to Binary:
   - Convert each character to its ASCII value.
   - Convert the ASCII value to an 8-bit binary number.
2. Group Binary Data into 5-bit Chunks:
   - Concatenate all the 8-bit binary numbers into a single binary string.
   - Split this binary string into 5-bit chunks.
3. Pad the Last Chunk:
   - If the last chunk is less than 5 bits, pad it with zeros on the right to make it 5 bits.
4. Map to Base32 Alphabet:
   - Convert each 5-bit chunk to its corresponding Base32 character using the Base32 alphabet.
5. Add Padding Characters:
   - If the resulting Base32 string length is not a multiple of 8, pad the string with `=` characters to make it so.

### Example

1. Let's encode the string "hello" using Base32. 1. Convert to Binary:

   - "h" -> 104 -> 01101000
   - "e" -> 101 -> 01100101
   - "l" -> 108 -> 01101100
   - "l" -> 108 -> 01101100
   - "o" -> 111 -> 01101111
   - Concatenate: 0110100001100101011011000110110001101111

2. Group into 5-bit Chunks:

   - 01101 00001 10010 10110 11000 11011 00011 01111

3. Pad the last chunk if it is less than 5 bits

   - not in our case

4. Map to Base32 Alphabet:

   - 01101 -> N
   - 00001 -> B
   - 10010 -> S
   - 10110 -> W
   - 11000 -> Y
   - 11011 -> 3
   - 00011 -> D
   - 01111 -> P

5. Add Padding Characters
   - The resulting string "NBWSY3DP" is already a multiple of 8, so no padding is needed.

Thus, the Base32 encoded string for "hello" is "NBWSY3DP".

## Implementation

Below is a Solidity implementation of a Base32 encoding function. Note that this implementation is simplified and may not handle all edge cases or be as optimized as possible.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

string constant BASE32_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";

contract Base32Encoder {
    function encode(bytes memory data) public pure returns (string memory) {
        uint256 dataLength = data.length;
        if (dataLength == 0) {
            return "";
        }

        uint256 encodedLength = ((dataLength + 4) / 5) * 8;
        bytes memory encoded = new bytes(encodedLength);

        uint256 dataIndex;
        uint256 encodedIndex;
        uint256 buffer;
        uint256 bitsLeft;
        uint256 bits;

        for (dataIndex = 0; dataIndex < dataLength; dataIndex++) {
            buffer = (buffer << 8) | uint8(data[dataIndex]);
            bitsLeft += 8;

            while (bitsLeft >= 5) {
                bits = (buffer >> (bitsLeft - 5)) & 0x1F;
                encoded[encodedIndex++] = bytes1(uint8(BASE32_ALPHABET[bits]));
                bitsLeft -= 5;
            }
        }

        if (bitsLeft > 0) {
            bits = (buffer << (5 - bitsLeft)) & 0x1F;
            encoded[encodedIndex++] = bytes1(uint8(BASE32_ALPHABET[bits]));
        }

        while (encodedIndex < encodedLength) {
            encoded[encodedIndex++] = "=";
        }

        return string(encoded);
    }
}
```

### Explanation

1. BASE32_ALPHABET: This string contains the Base32 alphabet characters.
2. encode: This function takes a bytes array as input and returns a Base32 encoded string.
3. Buffer and Bits Management: The function processes the input data byte by byte, managing a buffer to accumulate bits and extract 5-bit chunks to map to Base32 characters.
4. Padding: If the final encoded string is not a multiple of 8 characters, it adds = padding characters to ensure the correct length.

### Usage

To use this contract, you can deploy it on an Ethereum-compatible blockchain and call the encode function with the data you want to encode.

#### Example

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ExampleUsage is Base32Encoder {
    function encoded() public view returns (string memory) {
        return encode("hello world");
    }
}
```

This example contract demonstrates how to use the Base32Encoder contract to encode the string "hello". You can deploy both contracts and call the `encodeHello` function to get the Base32 encoded result.

P.S. Keep in mind that Solidity is not optimized for string manipulation, and this implementation may not be efficient for large inputs. It's best suited for small data sizes typically used in smart contracts.
