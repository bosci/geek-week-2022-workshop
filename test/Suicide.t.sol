//@author: gacwr.org
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

    function testRun() public {
        c.run();
    }

    // function testDestroy(uint256 i) public {
    //     bytes memory codeBefore = address(c).code;
    //     string memory stringBefore = string(abi.encodePacked(codeBefore));
    //     c.init();
    //     c.run(i);
    //     bytes memory codeAfter = address(c).code;
    //     string memory stringAfter = string(abi.encodePacked(codeAfter));
    //     assertEq(stringBefore, "");
    //     assertEq(stringAfter, "");
    // }

}
