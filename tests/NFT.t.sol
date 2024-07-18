// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "../contracts/NFT.sol";
import "forge-std/Test.sol";

bytes constant LABEL = "label";
bytes32 constant SHA256HASH = 0x1b036544434cea9770a413fd03e0fb240e1ccbd10a452f7dba85c8eca9ca3eda;

contract NFT_test is Test {
    NFT nft;

    function setUp() public {
        nft = new NFT("NFT", "NFT token");
        nft.mint(address(this), 0);
        assertEq(nft.balanceOf(address(this)), 1);
        assertEq(nft.ownerOf(0), address(this));

        assertEq(keccak256(LABEL), SHA256HASH);
    }

    function test_setTokenURI_CIDv0() external {
        vm.skip(false);

        nft.setTokenURI_CIDv0(0, SHA256HASH);

        // see https://cid.ipfs.tech/#QmQA6ijozCtRSXCkgDoE749SuY29KPVLQ7BAPMBEebhK7w
        // check the `DIGEST (HEX):` value
        assertEq(
            nft.tokenURI(0),
            "ipfs://QmQA6ijozCtRSXCkgDoE749SuY29KPVLQ7BAPMBEebhK7w"
        );
    }

    function test_setTokenURI_CIDv1() external {
        vm.skip(false);

        nft.setTokenURI_CIDv1(0, SHA256HASH);

        // see https://cid.ipfs.tech/bafybeia3ansuiq2m5klxbjat7ub6b6zebyomxuikiuxx3oufzdwktsr63i
        // check the `DIGEST (HEX):` value
        assertEq(
            nft.tokenURI(0),
            "ipfs://bafybeia3ansuiq2m5klxbjat7ub6b6zebyomxuikiuxx3oufzdwktsr63i"
        );
    }
}
