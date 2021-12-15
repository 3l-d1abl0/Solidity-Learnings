// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VariableExamples {
    //boolean
    bool public switchedOn = true;

    //address  //default 0x0000000000000000000000000000000000000000
    address public addr = 0xCA35E2c915458EF540aDe6068dFe2F38E8fa333a;
    address public owner = msg.sender;

    //unsigned integer //positive values
    //uint8 | uint16 | uint32 | uint64 | uint128 | uint256(uint)
    uint8 public u8 = 2**8 - 1; // 0 to 2^8-1

    uint256 public u = 2**256 - 1;
    uint256 public u256 = 2**256 - 1;

    //Signed integers
    //int8 | int16 | int32 | int64 | int128 | int256(int)
    int8 public i8 = -2**7; //-2 ** 7 to 2 ** 7 - 1

    int256 public i = -2**255; //-2 ** 255 to 2 ** 255 - 1
    int256 public i256 = 2**255 - 1; //-2 ** 255 to 2 ** 255 - 1

    //Min and Max int
    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    bytes32 public awesome1 = "Solidity is awesome !";

    //Strings are non-indexable, string manipulation are costly
    string public awesome2 = "Solidity is awesome !";

    //Contract Types
    NewContract a;
}

contract NewContract {
    function otherFunction() {
        int8 num = 2;
    }
}
