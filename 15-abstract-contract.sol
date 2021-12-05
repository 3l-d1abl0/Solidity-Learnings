pragma solidity ^0.8.0;

/* Abstract Class
Contracts are marked as abstract when atleast one of the 
function lacks an implementation.
 */

abstract contract Animal{

    string public breed;
    uint public age;
    uint public weight;

    constructor(){
        age = 1;
        weight =1;
    }

    function sleep() pure public returns (string memory){
        return "Sleeping !";
    }


    function eat() pure public returns (string memory){
        return "Nom Nom !";
    }

    //No implementation
    function talk() virtual pure public returns (string memory);

}

contract Cat is Animal{

    constructor(){
        breed ="Persian";
        age =3;
        weight = 5;
    }

    function talk() pure public override returns(string memory){
        return "miaow";
    }

}


contract Dog is Animal{

    constructor() public{
        breed = "Labrador";
        age = 5;
        weight = 3;
    }

    function talk() pure public override returns(string memory){
        return "bark bark";
    }
}