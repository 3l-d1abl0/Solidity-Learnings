pragma solidity ^0.8.0;

contract MessageContract {
    string private message = "Hello World";

    function getMessage() public view returns (string memory) {
        return message;
    }

    function setMessage(string memory newMessage) public {
        message = newMessage;
    }
}
