// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract C {
    uint256 private data;

    function f(uint256 a) private returns (uint256 b) {
        return a + 1;
    }

    function setData(uint256 a) public {
        data = a;
    }

    function getData() public returns (uint256) {
        return data;
    }

    function compute(uint256 a, uint256 b) internal returns (uint256) {
        return a + b;
    }
}

contract D {
    function readData() public {
        C c = new C();

        //cant private function
        uint256 local = c.f(7);

        //public
        c.setData(3);

        local = c.getData();

        //cant internal
        local = c.compute(3, 5);
    }
}

contract E is C {
    function g() public {
        C c = new C();

        //access because derived class
        uint256 val = compute(3, 5);
    }
}
