// SPDX-License-Identifier: UNLICENSED

/* Fallback Function
    A contract can have exactly one unnamed function.
   This function cannot have arguments and cannot return anything.
   It is executed on a call to the contract if none of the other functions match the given function identifier (or if no data was supplied at all).

   If it is not marked payable, the contract will throw an exception if it receives plain ether without data.
   Can not return anything.
   It is mandatory to mark it external.
 */

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
