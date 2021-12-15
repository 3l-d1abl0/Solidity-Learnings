// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract SampleContract {
    /*Function Structure
    function (<parameter types>) {internal|external|public|private} [pure|constant|view|payable] [returns (<return types>)]
     
     Access/Visibility Modifiers
     
     1. public - Accessible from this contract, inherited contracts and externally
     Public state variables and functions can both be accessed from the outside and the inside.
     The Solidity compiler automatically creates a getter function for them.


     2. private - state variables and functions are accessible only from this contract and not any derived contract.
     Most restrictive visibility.
     Code-level visibility modifier, still visible to observers of the blockchain.


     3. internal - Accessible only from this contract and contracts inheriting from it.
     Internal is the default visibility for state variables.


     4. external - Cannot be accessed internally, only externally and transactions
     Recommended to reduce gas. Access internally with this.func
     Arguments of external functions can be directly read from the calldata.
     They don't need to be copied over to memory like for public functions.
     Can't be used for variables

     */

    //cant use external for variables
    //unint256 external age;

    function test(uint256[20] memory a) public pure returns (uint256) {
        return a[10] * 2;
    }

    function test2(uint256[20] calldata a) external pure returns (uint256) {
        return a[10] * 2;
        //external functions are sometimes more efficient when they receive large arrays of data.
    }

    function test3(uint256[20] memory a) public view {
        this.test2(a);
        //external function can only be called internally using 'this'
    }
}
