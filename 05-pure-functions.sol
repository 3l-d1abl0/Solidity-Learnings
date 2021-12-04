pragma solidity ^0.8.0;

contract SampleContract {

    function func1(uint x, uint y) private pure returns (uint){
        return x* (y+42);
    }

    function func2(uint a) private pure returns (uint b){
        return (a+1);
    }

    function func2() public pure returns (string){
        return "public pure return ";
    };
}