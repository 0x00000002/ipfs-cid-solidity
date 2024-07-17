# Create IPFS CID v0 and v1 in Solidity

## v0

CIDv0 looks like `QmX9qyMvfYRfho16oYNDZbwHyrGRJPgZWxHX2PcqMkbs9M`.

Base58 encoding was implemented by [@storyicon](https://github.com/storyicon/base58-solidity), and used here as a library when creating CIDv0.

## v1

CIDv1 looks like `bafkreidon73zkcrwdb5iafqtijxildoonbwnpv7dyd6ef3qdgads2jc4sy` and uses Base32 encoding.

The AI-drafted [Base32 encoder](Base32Encoding.md) implementation was used to create CIDv1.
