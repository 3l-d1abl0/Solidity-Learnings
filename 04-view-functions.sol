pragma solidity ^0.8.0;

contract C{

    function f(uint a, uint b) public view returns (uint){
        return a * (b+42) + block.timestamp;
    }
}