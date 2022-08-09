//@author: gacwr.org
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/FuzzExample.sol";
import "forge-std/Vm.sol";

contract FuzzExampleTest is Test {

    FuzzExample c;

    function setUp() public {
        c = new FuzzExample();
    }

    function testAddressCheckByThisContract() public {
        c.ifOwnerTest();
    }

    function testFailAddressCheckByZeroAddress() public {
        vm.expectRevert(stdError.assertionError);
        address alice = address(0);
        vm.prank(alice);
        c.ifOwnerTest();
    }
    
    function testFailAddressCheckFuzzed(address fuzzedAddress) public {
        vm.expectRevert(stdError.assertionError);
        vm.prank(fuzzedAddress);
        c.ifOwnerTest();
    }

    function testExceptOwnerAddressFuzzed(address fuzzedAddress) public {
        console2.log("Address used in testExceptOwnerAddressFuzzed: %s", fuzzedAddress);
        vm.prank(fuzzedAddress);
        c.exceptOwnerTest();
    }

    function testChangeOwner(address fuzzedAddress) public {
        c.changeOwner(address(10));
        vm.prank(fuzzedAddress);
        c.exceptOwnerTest();
    }

}
