// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "../contracts/Base32.sol";
import "forge-std/Test.sol";

bytes constant DATA1 = "6E6FF7950A36187A801613426E858DCE686CD7D7E3C0FC42EE0330072D245C95";
bytes constant DATA2 = "0x6E6FF7950A36187A801613426E858DCE686CD7D7E3C0FC42EE0330072D245C95";
bytes constant ENCODED1 = "GZCTMRSGG44TKMCBGM3DCOBXIE4DAMJWGEZTIMRWIU4DKOCEINCTMOBWINCDORBXIUZUGMCGIM2DERKFGAZTGMBQG4ZEIMRUGVBTSNI=";

contract Base32_test is Test {
    function test_encode() public pure {
        string memory encoded = Base32.encodeToString(DATA1);
        assertEq(encoded, string(ENCODED1));

        encoded = Base32.encodeToString(DATA2);
        assertNotEq(encoded, string(ENCODED1));
    }
}
