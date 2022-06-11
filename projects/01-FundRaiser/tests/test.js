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

        //console.log(fundRaiser);
    });

    it('Contract address Check', () => {
        assert.ok(fundRaiser.options.address);
        console.log(fundRaiser.options.address);
    });

    /*it('Deadline Check', async () => {
        const deadline = await fundRaiser.methods.deadline().call();
        console.log('deadline : ', deadline);
        assert.equal(deadline, "40320");
    });*/

    it('Contract Admin', async () => {
        const admin = await fundRaiser.methods.admin().call();
        console.log('Admin: ', admin);
        assert.ok(admin);
    });

    it('Goal Amount Check', async () => {
        const amount = await fundRaiser.methods.goalAmount().call();
        console.log('Amount: ', amount);
        assert.equal(amount, 100000000000);
    });

    /*
        it('Check initial Contributions', () => {
    
            let idx = 0;
            fetchedAccounts.forEach(async address => {
    
                const contributions = await fundRaiser.methods.contributions(address).call();
                console.log(`${idx} = ${address} => ${contributions} ETH`);
                idx++;
    
            });
    
            assert.ok(1);
        });
    */


    it('Contribute', async () => {

        let idx = 0;
        fetchedAccounts.forEach(async address => {

            const contribute = await fundRaiser.methods.contribute().send({
                from: address,
                value: '2000000000000000000'
            });

            const contributed = await fundRaiser.methods.contributions(address).call();
            //assert.equal(contributions, '2000000000000000000');
            console.log(`Sent.. ${address}  => 2000000000000000000`);

            let bal = web3.utils.fromWei(await web3.eth.getBalance(address), 'ether');
            console.log(`${idx} = ${address} => ${bal} ETH`);
            idx++;

            //assert.equal(contributed, '2000000000000000000');

        });

        //assert.ok(1);
    });


});