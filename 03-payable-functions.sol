// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

//Functions that receive Ether are marked as payable function.

contract Sample {
    uint256 public amount = 0;

    function payme() public payable {
        amount += msg.value;
    }
}
