pragma solidity ^0.8.0;

contract Bank{

    struct Account{
        address addr;
        uint amount;
    }


    Account public acc = Account({
        addr: 0x6634jsgbdjfsdfbjksdfjdssfnd,
        amount: 50
    });


    function addAmount(uint _addMoney) public{
        acc.amount += _addMoney;
    }
}