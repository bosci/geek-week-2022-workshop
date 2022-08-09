// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/Suicide.sol";
import "forge-std/Vm.sol";

contract SuicideTest is Test {

    Suicide c;

    function setUp() public {
        c = new Suicide();
    }

    function testInit() public {
        c.init();
    }

    function testRun(uint256 i) public {
        c.run(i);
    }

}
