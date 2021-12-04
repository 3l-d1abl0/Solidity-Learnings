pragma solidity ^0.8.0;


contract Sample {

    uint public amount = 0;
    function payme() public payable {
        amount +=msg.value;
    }
}