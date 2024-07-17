// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Base32Encoder {
    bytes32 internal constant BASE32_ALPHABET =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";

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
