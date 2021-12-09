pragma solidity ^0.8.0;

contract SmartExchange{


    event Deposit(address from, bytes32 to, uint indexed value);

    event Transfer(bytes32 from, address to, uint indexed value);

    function deposit(bytes32 to) payable public{
        emit Deposit(msg.sender, to, msg.value);
    }


    function transfer(bytes32 from, address payable to, uint value) payable public{
        to.transfer(value);
        emit Transfer(from, to, value);
    }
}