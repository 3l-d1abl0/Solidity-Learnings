pragma solidity^0.4.0;

contract C {

    uint private data;

    function f(uint a) private returns(uint b) {return a+1};

    function setData(uint a) public {data =a;}

    function getData() public returns(uint) {return data;}

    function compute(uint a, uint b) internal returns(uint) {return a+b};

}


contract D{

    function readData() public{

        C c = new C();

        //cant private function
        uint local = c.f(7);

        //public
        c.setData(3);

        local = c.getData();

        //cant internal
        local = c.compute(3,5);
    }
}

contract E is C{


    function g() public{

        C c= new C();

        //access because derived class
        uint val = compute(3,5);
    }
}