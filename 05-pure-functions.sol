// SPDX-License-Identifier: UNLICENSED

//Functions can be declared pure in which case they promise
// not to read from or modify the state.

pragma solidity ^0.8.0;

contract SampleContract {
    function func1(uint256 x, uint256 y) private pure returns (uint256) {
        return x * (y + 42);
    }

    function func2(uint256 a) private pure returns (uint256 b) {
        return (a + 1);
    }

    function func2() public pure returns (string memory) {
        return "public pure return ";
    }
}
