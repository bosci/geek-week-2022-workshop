//@author: gacwr.org
pragma solidity ^0.8.13;

contract ReentrancyDao {
  mapping (address => uint) public credit;
    
  function donate(address to) payable public{
    credit[to] += msg.value;
  }
    
  function withdraw(uint amount) public{
    if (credit[msg.sender]>= amount) {
      (bool success, ) = msg.sender.call{value: amount}("");
      require(success, "not successfull withdraw");
      credit[msg.sender]-=amount;
    }
  }  

  function queryCredit(address to) view public returns(uint){
    return credit[to];
  }
}