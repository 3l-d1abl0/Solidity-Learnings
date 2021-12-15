// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/**

Variables are declared as either storage, memory or calldata to explicitly specify the location of the data.

storage - variable is a state variable (store on blockchain)
memory - variable is in memory and it exists while a function is being called
         lifetime is limited to a function call
calldata - special data location that contains function arguments, only available for external functions



So currently, reference types comprise structs, arrays and mappings.
If you use a reference type, you always have to explicitly provide the data area where the type is stored.

 
 */

contract ChangeArrayValue {
    //storage by default
    uint256[20] public arr;

    function startfirstChange() public {
        firstChange(arr);
        test(arr);
    }

    function startsecondChange() public view {
        secondChange(arr);
        test(arr);
    }

    //Can be transformed to storage
    function firstChange(uint256[20] storage x) internal {
        x[5] = 4;
    }

    //memory
    function secondChange(uint256[20] memory x) internal pure {
        x[5] = 3;
    }

    function test(uint256[20] memory x) public pure returns (uint256) {
        return x[0];
    }
}
