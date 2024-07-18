# Create IPFS CID v0 and v1 in Solidity

This repo includes:

- the first complete implementation of Base32 encode/decode in Solidity
- code to calculate IFPS CID v0 and v1 based on SHA256 hash of the content (e.g. metadata json file)

Github: https://github.com/0x00000002/ifps-cid-solidity

## CIDv0

CIDv0 looks like `QmX9qyMvfYRfho16oYNDZbwHyrGRJPgZWxHX2PcqMkbs9M`.

Base58 encoding was implemented by [@storyicon](https://github.com/storyicon/base58-solidity), and used here as a library when creating CIDv0.

### Implementation:

```solidity
    function cidv0(bytes32 sha256Hash_) public pure returns (string memory) {
        bytes memory hashString = new bytes(34);
        hashString[0] = 0x12;
        hashString[1] = 0x20;
        uint256 hashLength = sha256Hash_.length;
        for (uint256 i = 0; i < hashLength; ++i) {
            hashString[i + 2] = sha256Hash_[i];
        }
        return Base58.encodeToString(hashString);
    }
```

## CIDv1

CIDv1 looks like `bafkreidon73zkcrwdb5iafqtijxildoonbwnpv7dyd6ef3qdgads2jc4sy` and uses Base32 encoding.

The AI-drafted [Base32 encoder](Base32.md) implementation was used to create CIDv1.

### Implementation

```solidity
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
```

## Usage

### Prerequisites

Base32.sol can be imported and used as a library.
Using this CIDv0/v1 will require installing some dependencies.

1.  Foundry should be installed. https://book.getfoundry.sh/getting-started/installation

2.  Install dependencies

    ```sh
    forge install OpenZeppelin/openzeppelin-contracts
    forge install storyicon/base58-solidity
    forge install foundry-rs/forge-std
    ```

### Usage example

```solidity
contract NFT {
   ...
   mapping(uint256 tokenId => string) private _tokenURIs;
   ...
   function setURI_CIDv0(uint256 tokenId, bytes32 sha256Hash) external {
      _tokenURIs[tokenId] =
         string(abi.encodePacked(IPFS_URI, cidv0(sha256Hash)));
   }
   ...
   function setURI_CIDv1(uint256 tokenId, bytes32 sha256Hash) external {
      _tokenURIs[tokenId] =
         string(abi.encodePacked(IPFS_URI, cidv1(sha256Hash)));
   }

}
```

See also tests in [NFT.t.sol](./tests/NFT.t.sol)
