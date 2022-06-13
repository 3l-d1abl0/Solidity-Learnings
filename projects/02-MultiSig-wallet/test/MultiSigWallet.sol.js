//artifact
const Wallet = artifacts.require('Wallet');


contract('Wallet', (accounts) => {

    let wallet;
    beforeEach(async () => {
        wallet = await Wallet.new([accounts[0], accounts[2], accounts[4]], 2);

        await web3.eth.sendTransaction({ from: accounts[0], to: wallet.address, value: 10000 });
    });



    it('Approvers and Quorum Check', () => {

        const approvers = await wallet.getApprovers();
        const auorum = await.quorum();

        assert(approvers.length === 3);

        assert(approvers[0] === accounts[0]);
        assert(approvers[1] === accounts[1]);
        assert(approvers[2] === accounts[2]);

        assert(quorum.toNumber() === 2);


    });
});