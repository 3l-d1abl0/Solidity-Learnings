const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');

const web3 = new Web3(ganache.provider());
const { interface, bytecode } = require('../compile');  //abi, evm

/*console.log(ganache.provider());
console.log(interface);
console.log(bytecode);*/

let fetchedAccounts;
let fundRaiser;

let fundraiserGoalAmount = 100000000000;


/*
beforeEach(async () => {

    let contract = await new web3.eth.Contract(interface);

    //Get a list of Accounts
    fetchedAccounts = await web3.eth.getAccounts();
    console.log(fetchedAccounts);

    fundRaiser = await contract
        .deploy({
            data: bytecode,
            arguments: [3, 100000000000, 'Just Testing']
        })
        .send({ from: fetchedAccounts[0], gas: '1000000' });


});
*/


describe('FundRaiser', () => {


    before(async () => {

        let contract = await new web3.eth.Contract(interface);

        //Get a list of Accounts
        fetchedAccounts = await web3.eth.getAccounts();

        /* let idx = 0;
        fetchedAccounts.forEach(async address => {
            let bal = web3.utils.fromWei(await web3.eth.getBalance(address), 'ether');
            console.log(`${idx} = ${address} => ${bal} ETH`);
            idx++;
        }); */

        fundRaiser = await contract
            .deploy({
                data: bytecode,
                arguments: [2, 100000000000, 'Just Testing']
            })
            .send({ from: fetchedAccounts[0], gas: '1000000' });

        
    });

    it('Contract address Check', () => {
        console.log('Contract Address: ', fundRaiser.options.address);
        assert.ok(fundRaiser.options.address);
    });

    /*
    it('Deadline Check', async () => {
        const deadline = await fundRaiser.methods.deadline().call();
        console.log('deadline : ', deadline);
        assert.equal(deadline, "40320");
    });
    */

    it('Contract Admin Check', async () => {
        const admin = await fundRaiser.methods.admin().call();
        console.log('Contract Admin: ', admin);
        assert.ok(admin);
    });

    it('Fundraiser Amount Check', async () => {
        const amount = await fundRaiser.methods.goalAmount().call();
        console.log('Fundraiser Target Amount: ', amount);
        assert.equal(amount, fundraiserGoalAmount);
    });

    
    it('Check initial Contributions', async () => {

        let idx = 0, totalContributions = 0;
        for (const address of fetchedAccounts) {

            const contributions = await fundRaiser.methods.contributions(address).call();
            totalContributions +=contributions;
            //console.log(`${idx} = ${address} => ${contributions} ETH`);
            idx++;

        }

        assert.equal(totalContributions, 0);
    });
    


    it('Contribution Check', async () => {

        let idx = 0, totalContributions = 0;

        //forEach doesnt work with async/await
        //await fetchedAccounts.forEach(async address => {
        for (const address of fetchedAccounts) {

            const contribute = await fundRaiser.methods.contribute().send({
                from: address,
                value: '2000000000000000000'
            });

            const contributed = await fundRaiser.methods.contributions(address).call();

            totalContributions += Number('2000000000000000000');

            let bal = web3.utils.fromWei(await web3.eth.getBalance(address), 'ether');
            //console.log(`${idx} = ${address} => ${bal} ETH`);
            idx++;

        }

        const raisedAmount = await fundRaiser.methods.raisedAmount().call();
        
        //console.log('totalContibutions: ', totalContributions);
        console.log('raisedAmount: ', raisedAmount);
        assert.equal(raisedAmount, totalContributions);
    });


    it('Create Spending Request', async() =>{
        //createSpendingRequest
        try {
        
            let contributed = await fundRaiser.methods
            .createSpendingRequest( "First Spending Request", fetchedAccounts[1], '200000000000000000')
            .send({
                from: fetchedAccounts[0],
                gas: '1000000'
            });

            contributed = await fundRaiser.methods
            .createSpendingRequest( "Second Spending Request", fetchedAccounts[2], '200000000000000000')
            .send({
                from: fetchedAccounts[0],
                gas: '1000000'
            });
        
        } catch (err) {
            console.log('err',err);
            assert(false);
        }

        //get Last Spending Request
        const requestLength = await fundRaiser.methods.numRequests().call();
        const lastRequest = await fundRaiser.methods.requests(requestLength-1).call();
        
        //console.log('Request: ',lastRequest);

        //Check for the lastest Spending request
        assert.equal(lastRequest.description,"Second Spending Request");
        assert.equal(lastRequest.requestAmount,'200000000000000000');
        assert.equal(lastRequest.recipient,fetchedAccounts[2]);

    });

});