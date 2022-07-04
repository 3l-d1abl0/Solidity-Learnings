// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract FundRaising {
    address public admin; //The Address who creates the Fundraser
    uint256 public goalAmount; //Total amount to be raised
    uint256 public raisedAmount; //The current amount raised
    uint256 public minimumContribution; //Minimum amount per contribution

    uint256 public totalContributors; //current number of contributors
    uint256 public deadline; //the deadline

    string public about; //Description about why are you raising this Fund

    mapping(address => uint256) public contributions; //keep a mapping of contributions

    constructor(
        uint256 numberOfDays,
        uint256 _goal,
        string memory _about
    ) {
        admin = msg.sender;
        deadline = block.timestamp + (numberOfDays * 1 days);
        goalAmount = _goal;
        about = _about;

        minimumContribution = 1000000; //1 szabo
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the FundRaise admin can do this !");
        _;
    }

    //Contribute to the Fund Raiser
    function contribute() public payable {
        require(
            msg.value > minimumContribution,
            "Contribution not meeting the require minimum amount"
        );

        //if new contributor
        if (contributions[msg.sender] == 0) {
            totalContributors++;
        }

        contributions[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    //A Spending request, to be created by Admins
    struct Request {
        uint256 requestAmount; //how much to spend
        string description; //Reason
        address recipient; //beneficiary
        bool complete; //if Request complete
        uint256 votesCount; //number of people supported
        mapping(address => bool) voters;
    }

    //To contain the list of Requests
    Request[] public requests;
    uint256 public numRequests = 0;

    //Request to create a Spending Request
    function createSpendingRequest(
        string memory _description,
        address _recipient,
        uint256 _value
    ) public onlyAdmin {
        require(admin == msg.sender, "only admin can request");
        require(_value > 0, "spending amount cannot be 0");

        /*
        Struct containing a (nested) mapping cannot be constructed

        Request memory newRequest = Request({
            requestAmount: _value,
            description: _description,
            recipient: _recipient,
            complete: false,
            votesCount: 0
        });

        requests.push(newRequest);

        */
        
        Request storage r = requests.push();
       // Request storage r = requests[numRequests];
        numRequests++;
        r.requestAmount = _value;
        r.description = _description;
        r.recipient = _recipient;
        r.complete = false;
        r.votesCount = 0;
        
    }

    /**
        Handles the functionality when people try to vote for Spending Request
     */
    function voteSpendingRequest(uint256 index) public {
        require(
            index >= 0 && index < requests.length,
            "Invalid Spending Request"
        );

        require(
            contributions[msg.sender] > 0,
            "Not contributed to this Cause, can't vote"
        );

        Request storage spendingRequest = requests[index];

        require(spendingRequest.voters[msg.sender] == false, "Already voted !");

        spendingRequest.voters[msg.sender] = true;
        spendingRequest.votesCount++;
    }

    /**Function to make the payment to the recepient
        If 50% of the contributers vote
     */
    function makePayment(uint256 index) public onlyAdmin {
        Request storage spendingRequest = requests[index];
        require(
            spendingRequest.complete == false,
            "This spending request is already complete"
        );

        //More than 50% of the contibutors
        require(spendingRequest.votesCount > totalContributors / 2,
        "Need 50% votes in order to make Payment");

        payable(spendingRequest.recipient).transfer(
            spendingRequest.requestAmount
        );
        spendingRequest.complete = true;
    }
}
