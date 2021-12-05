pragma solidity ^0.8.0;

/*
1. Cannot inherit other contracts or interfaces.
2. Cannot have functions with implementation
3. Cannot define constructor
4. Cannot define variables
5. Cannot define structs
6. Cannot define enums.
 */


interface Token{


    function transfer(address recipient, uint amount) public;


    function balanceOf(address _owner) constant returns(uint256 balance);

}