// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

library Base32 {
    bytes32 internal constant BASE32_ALPHABET =
        "abcdefghijklmnopqrstuvwxyz234567";

    function encode(bytes memory data) public pure returns (bytes memory) {
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

        encoded = slice(encoded, 0, encodedIndex - 6);
        return abi.encodePacked("b", encoded);
    }

    /**
     * @notice encodeToString is used to encode the given byte in base58 standard.
     * @param data_ raw data, passed in as bytes.
     * @return base58 encoded data_, returned as a string.
     */
    function encodeToString(
        bytes memory data_
    ) public pure returns (string memory) {
        return string(encode(data_));
    }

    /**
     * @notice slice is used to slice the given byte, returns the bytes in the range of [start_, end_)
     * @param data_ raw data, passed in as bytes.
     * @param start_ start index.
     * @param end_ end index.
     * @return slice data
     */
    function slice(
        bytes memory data_,
        uint256 start_,
        uint256 end_
    ) public pure returns (bytes memory) {
        unchecked {
            bytes memory ret = new bytes(end_ - start_);
            for (uint256 i = 0; i < end_ - start_; i++) {
                ret[i] = data_[i + start_];
            }
            return ret;
        }
    }
}
