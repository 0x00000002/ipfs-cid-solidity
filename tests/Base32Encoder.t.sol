// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "../src/utils/Base32Encoder.sol";
import "forge-std/Test.sol";

bytes constant DATA = "6E6FF7950A36187A801613426E858DCE686CD7D7E3C0FC42EE0330072D245C95";
bytes constant ENCODED = "GZCTMRSGG44TKMCBGM3DCOBXIE4DAMJWGEZTIMRWIU4DKOCEINCTMOBWINCDORBXIUZUGMCGIM2DERKFGAZTGMBQG4ZEIMRUGVBTSNI=";

contract Base32Encoder_test is Base32Encoder, Test {
    // The state of the contract gets reset before each
    // test is run, with the `setUp()` function being called
    // each time after deployment. Think of this like a JavaScript
    // `beforeEach` block
    function setUp() public {}

    function test_encode() public view {
        string memory encoded = encode(data);
        assertEq(encoded, ENCODED);
    }
}
