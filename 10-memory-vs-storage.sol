// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/**
So currently, reference types comprise structs, arrays and mappings. If you use a reference type, you always have to explicitly provide the data area where the type is stored:

memory (whose lifetime is limited to a function call)
storage (the location where the state variables are stored)

calldata (special data location that contains the function arguments, only available for external function call parameters).
 */

contract ChangeArrayValue{

    //storage by default
    uint[20] public arr;


    function startChange() public {

        firstChange(arr);
        secondChange(arr);

    }

    //Can be transformed to storage
    function firstChange(uint[20] storage x) internal{
        x[0] = 4;
    }

    //memory 
    function secondChange(uint[20] memory x) internal pure{
        x[0] = 3;
    }

}