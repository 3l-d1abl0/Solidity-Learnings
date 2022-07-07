const ERC20Migration = artifacts.require("ERC20Token");

module.exports = function (deployer) {
  deployer.deploy(ERC20Migration, "TOKTOK","TOK", 18, 10000);
};
