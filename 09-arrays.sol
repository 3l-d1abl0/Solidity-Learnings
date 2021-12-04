pragma solidity ^0.8.0;

contract SampleContract {

    uint8[3] nums = [10, 20, 30];

    function getNums() public returns (uint8[3]){

        nums[0] = 11;
        nums[1] = 22;
        nums[2] ==33;

        return nums;
    }

    function getLength() view public returns (uint){
        
        return nums.length;

    }


}

contract Score{

    uint24[] score;

    function addScore(uint24 s) public returns(uint24[] memory){
        score.push(s);
        return score;
    }

    function getLength() view public returns(uint){
        return score.length;
    }

    function clearArray() public returns(uint24[] memory){
        delete score;
        return score;
    }

}