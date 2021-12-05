pragma solidity ^0.8.0;

/* Modifiers can be used to easily change the behaviour of functions.
Can be used to check conditions before execution the function

Inheritable properties of contracts and may be overridden
by derived contracts.
 */

contract Purchase{

    address public seller;

    modifier onlySeller{
        require(msg.sender == seller);
        _;
    }

    //modifier will be executed before function
    function abort() public onlySeller {
        // /
    }

}

contract owned{

    address owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
}


contract mortal is owned{

    function close() public onlyOwner{
        selfdestruct(owner);
    }
}