// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./IPFS.sol";

string constant IPFS_URI = "ipfs://";

contract NFT is IPFS, ERC721 {
    mapping(uint256 tokenId => string) private _tokenURIs;

    constructor(
        string memory token_,
        string memory name_
    ) ERC721(name_, token_) {}

    /**
     * @notice mint() function EXAMPLE uses OpenZeppelin ERC721 _mint()
     * @param receiver - address of the wallet to receive new token
     * @param tokenId - token ID to mint (optional, if minting is sequential)
     */
    function mint(address receiver, uint256 tokenId) public {
        _mint(receiver, tokenId);
    }

    /**
     * @notice setTokenURI() accepts pre-calculated content's sha256 hash
     * @notice and converts it to CIDv0
     * @param tokenId - token ID to set metadata for
     * @param sha256Hash - sha256 hash of the content
     */
    function setTokenURI_CIDv0(uint256 tokenId, bytes32 sha256Hash) external {
        string memory uri = string(
            abi.encodePacked(IPFS_URI, cidv0(sha256Hash))
        );
        _tokenURIs[tokenId] = uri;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return _tokenURIs[tokenId];
    }
}
