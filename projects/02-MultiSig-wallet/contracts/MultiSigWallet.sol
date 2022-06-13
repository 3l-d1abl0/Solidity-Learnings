// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Wallet {
    address[] public approvers;
    uint256 public quorum;

    //Transfer is a eth transfer request from one account to another
    struct Transfer {
        uint256 id;
        uint256 amount;
        address payable to;
        uint256 approvals;
        bool transferStatus;
    }

    Transfer[] public transfers;

    mapping(address => mapping(uint256 => bool)) public transferApprovals;

    //modifer to check if the calling address is an approver
    modifier onlyApprover() {
        bool allowed = false;
        for (uint256 i = 0; i < approvers.length; i++) {
            if (approvers[i] == msg.sender) {
                allowed = true;
            }
        }

        require(allowed == true, "only approver allowed");
        _;
    }

    constructor(address[] memory _approvers, uint256 _quorum) {
        approvers = _approvers;
        quorum = _quorum;
    }

    function getApprovers() external view returns (address[] memory) {
        return approvers;
    }

    function createTransfer(uint256 amount, address payable to)
        external
        onlyApprover
    {
        transfers.push(Transfer(transfers.length, amount, to, 0, false));
    }

    function getTransfer() external view returns (Transfer[] memory) {
        return transfers;
    }

    function approveTransfer(uint256 id) external onlyApprover {
        //Check if this transfer has already been made
        require(
            transfers[id].transferStatus == false,
            "Transfer has already been made"
        );
        //check if approver has already approved the request
        require(
            transferApprovals[msg.sender][id] == false,
            "Transfer already Approved !"
        );

        transferApprovals[msg.sender][id] = true;
        transfers[id].approvals++; //Transation approved

        //check if number of approvals reached quorum
        if (transfers[id].approvals >= quorum) {
            transfers[id].transferStatus = true;
            address payable to = transfers[id].to;
            to.transfer(transfers[id].amount);
        }
    }

    //smart contract to receive ethers
    receive() external payable {}
}
