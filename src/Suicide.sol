//@author: gacwr.org
pragma solidity ^0.8.13;

contract Suicide {
    uint256 private initialized = 0;
    uint256 public count = 1;

    function init() public {
        initialized = 1;
    }

    function run() external {
        if (initialized == 0) {
            return;
        }
        selfdestruct(payable(msg.sender));
    }
}