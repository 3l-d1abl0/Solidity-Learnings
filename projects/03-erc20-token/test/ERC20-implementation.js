const TruffleContract = artifacts.require("ERC20Token");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */

let owner_address;
let erc20;

let token_name = "My Custom Token";
let token_symbol = "MCT";
let total_supply = 10000;
let decimals = 15;



contract("TruffleContract", (accounts) => {
    
  before(async () => {
    [owner_address] = accounts;

    //await TruffleContract.deployed();
    //this.testContract = await TruffleContract.new("QQQToken","QQQ", 18, 5000, {from: pwner_address});
    erc20 = await TruffleContract.new(token_name,token_symbol, decimals, total_supply, {from: owner_address});

  });

  it("should check Token name, symbol, total supply and decimals", async ()=> {
    
    assert.equal(await erc20.name(), token_name, "Token name mismatch");
    assert.equal(await erc20.symbol(), token_symbol, "Token symbol mismatch");
    assert.equal(await erc20.decimals(), decimals, "Token decimal mismatch");
    assert.equal(await erc20.totalSupply(), total_supply, "Token totalSupply mismatch");

    //console.log(await this.testContract.symbol());
    //return assert.isTrue(true);
      
    });

});
