// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {FuzzExample} from "src/FuzzExample.sol";

contract FuzzExampleScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new FuzzExample();
    }
}
