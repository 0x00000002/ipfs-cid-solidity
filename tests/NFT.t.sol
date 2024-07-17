// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "../contracts/NFT.sol";
import "forge-std/Test.sol";

bytes32 constant LABEL = 0x6E6FF7950A36187A801613426E858DCE686CD7D7E3C0FC42EE0330072D245C95;

contract NFT_test is Test {
    NFT nft;

    function setUp() public {
        nft = new NFT("NFT", "NFT token");
        nft.mint(address(this), 0);
        assertEq(nft.balanceOf(address(this)), 1);
        assertEq(nft.ownerOf(0), address(this));
    }

    function test_setTokenURI_CIDv0() external {
        vm.skip(false);

        nft.setTokenURI_CIDv0(0, LABEL);

        // see https://cid.ipfs.tech/#QmVmkadKS2uvxyD6YJJzd3Umem6SWV7QxYnL7kbpdWAsPS
        // check the `DIGEST (HEX):` value
        assertEq(
            nft.tokenURI(0),
            "ipfs://QmVmkadKS2uvxyD6YJJzd3Umem6SWV7QxYnL7kbpdWAsPS"
        );
    }
}
