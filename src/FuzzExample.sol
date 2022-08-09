// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract FuzzExample {
    address owner;
    constructor(){
        owner = msg.sender;
    }

    modifier checkOwner() { 
        require(msg.sender == owner, "must be owner");
        _;
    }

    modifier exceptOwner() { 
        require(msg.sender != owner, "must NOT be owner");
        _;
    }

    function ifOwnerTest() checkOwner external view returns(bool) {
        return true;
    }

    function exceptOwnerTest() exceptOwner external view returns(bool) {
        return true;
    }

    function changeOwner(address a) checkOwner external returns(bool){
        
        owner = a;
        return true;
    }
    
}
