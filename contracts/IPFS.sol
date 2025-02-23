// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "@base58-solidity/Base58.sol";
import "./Base32.sol";

bytes constant ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";

/**
 * Based on https://github.com/storyicon/base58-solidity/blob/master/contracts/Base58.sol
 */
contract IPFS {
    /**
     * @notice cidv0 is used to convert sha256 hash to cid(v0) used by IPFS.
     * @param sha256Hash sha256 hash generated by anything.
     * @return IPFS CIDv0
     */
    function cidv0(bytes32 sha256Hash) public pure returns (string memory) {
        bytes memory hashString = new bytes(34);
        hashString[0] = 0x12;
        hashString[1] = 0x20;
        uint256 hashLength = sha256Hash.length;
        for (uint256 i = 0; i < hashLength; ++i) {
            hashString[i + 2] = sha256Hash[i];
        }
        return Base58.encodeToString(hashString);
    }

    /**
     * @notice for storage optimisation this cidv1 uses
     * @notice dag-pb codec and sha256Hash multihash.
     * @notice
     * @param sha256Hash hash
     * @return IPFS CIDv1
     */
    function cidv1(bytes32 sha3_224Hash) public pure returns (string memory) {
        bytes memory hashString = new bytes(36);
        hashString[0] = 0x01;
        hashString[1] = 0x70;
        hashString[2] = 0x12;
        hashString[3] = 0x20;
        uint256 hashLength = sha3_224Hash.length;
        for (uint256 i = 0; i < hashLength; ++i) {
            hashString[i + 4] = sha3_224Hash[i];
        }
        return Base32.encodeToString(hashString);
    }
}
