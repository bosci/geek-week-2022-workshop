//@author: gacwr.org
pragma solidity ^0.8.13;

contract ModifierEntrancy {

  mapping (address => uint) public tokenBalance;
  string constant name = "Nu Token";

  Bank bank;
  
  constructor() {
      bank = new Bank();
  }

  //If a contract has a zero balance and supports the token give them some token
  function airDrop() hasNoBalance supportsToken public {
    tokenBalance[msg.sender] += 20;
  }
  
  //Checks that the contract responds the way we want
  modifier supportsToken() {
    require(keccak256(abi.encodePacked("Nu Token")) == Bank(msg.sender).supportsToken(), "supports token must be valid");
    _;
  }
  
  //Checks that the caller has a zero balance
  modifier hasNoBalance {
      require(tokenBalance[msg.sender] == 0, "must have no balance");
      _;
  }

  function getBalance() external view returns(uint){
      return tokenBalance[msg.sender];
  }
}

contract Bank{

    function supportsToken() external returns(bytes32) {
        return keccak256(abi.encodePacked("Nu Token"));
    }

}