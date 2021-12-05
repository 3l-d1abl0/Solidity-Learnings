pragma solidity ^0.8.0;


/*
Require - Reverts if the condition is not met:
    - validate response from an external contract
    - validate state condition prior to executing state changing operation
    - used towars teh beginning of the function
 */
contract Bank{

    mapping(address => uint) public accounts;

    function deposit() public payable{

        //reverts with an error message if condition not met
        require(accounts[msg.sender] + msg.value >= accounts[msg.sender], "Overflow error");
        accounts[msg.sender] +=msg.value;
    }


    function withdraw(uint money) public{

        require(money <= accounts[msg.sender]);
        accounts[msg.sender] -= money;
    }
}

/*Revert :
undo all changes made
if-else logic Flow
will refund the remaing gas */

contract BnakRevert{

    mapping(address => uint) public accounts;


    function deposit(uint money)public payable{

        if(accounts[msg.sender] + msg.value >= accounts[msg.sender]){
            revert("Overflow error");
        }

        accounts[msg.sender] += money;
    }


    function withdraw(uint money) public{

        if(money <= accounts[msg.sender]){
            revert();
        }

        accounts[msg.sender] -= money;

    }
}



/*Assert
    - uses all of the remaining Gas
    - to be used for internal errors !
    - check for underflow/overflow
    - validates states after making changes
*/
contract MathAssert{

    function add(uint256 a, uint256 b) internal pure returns(uint){

        uint c = a+b;
        assert(c >= a);
        return c;
    }

    function multiply(uint256 a, uint256 b) internal pure returns (uint){
        
        if(a==0){
            return 0;
        }

        uint c = a*b;

        assert(c/a ==b);
        return c;
    }
}