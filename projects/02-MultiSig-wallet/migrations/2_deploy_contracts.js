var SimpleStorage = artifacts.require("../contracts/MultiSigWallet.sol");

module.exports = function (deployer) {
    deployer.deploy(SimpleStorage);
};