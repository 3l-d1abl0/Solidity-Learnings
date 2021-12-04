pragma solidity^0.8.0;

contract SampleContract {

    //cant use external for variables
    unint256 external age;

    function test(uint[20] a)public pure returns (uint){
        return a[10]*2;
    }

    function test2(uint[20] a) external pure returns (uint){
        return a[10]*2;
        //external functions are sometimes more efficient when they receive large arrays of data.
    }

    function test3(uint[20] a) public view{
        this.test2(a);
        //external function can only be called internally using 'this'
    }

}