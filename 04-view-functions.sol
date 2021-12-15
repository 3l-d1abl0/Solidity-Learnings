// SPDX-License-Identifier: UNLICENSED

//Functions can be declared view or constant in which case they promise not to modify the state, but can read from them.

pragma solidity ^0.8.0;

contract C {
    uint8 multiplier = 4;

    function f(uint256 a, uint256 b) public view returns (uint256) {
        return multiplier * a * (b + 42) + block.timestamp;
    }
}
