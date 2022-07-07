const TruffleContract = artifacts.require("ERC20Token");
const { expectRevert, expectEvent } = require("@openzeppelin/test-helpers");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */

let owner_address, accountA, accountB, accountC;
let erc20;

let token_name = "My Custom Token";
let token_symbol = "MCT";
let total_supply = 10000;
let decimals = 15;



contract("TruffleContract", (accounts) => {
    
  before(async () => {
   [owner_address, accountA, accountB, accountC] = accounts;

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

  it("should check balance transfer", async() =>{

    let tokensA = 600;
    let receipt = await erc20.transfer(accountA, tokensA);
    //Check for Transfer event for account A
    expectEvent(receipt, "Transfer", {
      from: owner_address,
      to: accountA,
      tokens: web3.utils.toBN(tokensA),
    });
    
    let tokensB = 500;
    receipt = await erc20.transfer(accountB, tokensB);
    //Check for Transfer event for account B
    expectEvent(receipt, "Transfer", {
      from: owner_address,
      to: accountB,
      tokens: web3.utils.toBN(tokensB),
    });

    //A balance should be equal to tokensA
    const balanceA = await erc20.balanceOf(accountA);
    assert.equal(balanceA, tokensA);
    
    //B balance should be equal to tokensB
    const balanceB = await erc20.balanceOf(accountB);
    assert.equal(balanceB, tokensB);

  });

  it("should not transfer without approval", async()=>{

      //Has accountA allowed owner to transfer on its behalf ?
      allowance = await erc20.allowance(accountA, owner_address);
      //console.log(allowance);
      assert(allowance.isZero(), "Allowance should be zero");

      let tokens = 300;
      //expecct a revert since accountA has not approved owner_account to transfer token on its behalf
      await expectRevert(
        erc20.transferFrom(accountA, accountB, tokens),
        "allowance too low",
      );

  });
    
  it("should aprove owner_account as a spender for accountA", async ()=>{

    let allowance = 500;
    
    //accountA allowing owner to be spender on its behalf
    receipt = await erc20.approve(owner_address, allowance, { from: accountA });
    expectEvent(receipt, "Approval", {
      tokenOwner: accountA,
      spender: owner_address,
      tokens: web3.utils.toBN(allowance),
    });

    const allowedByA = await erc20.allowance(accountA, owner_address);
    assert.equal(allowance,allowedByA, "Allowance Mismatch");

    //Transfer token A to B by owner
    let transferAtoB = 500;
    receipt = await erc20.transferFrom(accountA, accountB, transferAtoB);
    //Expect a Transfer Event
    expectEvent(receipt, "Transfer", {
      from: accountA,
      to: accountB,
      tokens: web3.utils.toBN(transferAtoB),
    });


    //A balance should be equal to 100
    const balanceA = await erc20.balanceOf(accountA);
    assert.equal(balanceA, 100);
    
    //B balance should be equal to 1000
    const balanceB = await erc20.balanceOf(accountB);
    assert.equal(balanceB, 1000);


  });
    

  it("should not transfer due to low Balance (transferFrom)", async ()=>{

    //Approve allowance of 500
    let allowance = 500;
    
    //accountA allowing owner to be spender on its behalf
    receipt = await erc20.approve(owner_address, allowance, { from: accountA });
    expectEvent(receipt, "Approval", {
      tokenOwner: accountA,
      spender: owner_address,
      tokens: web3.utils.toBN(allowance),
    });

    //Transfer token A to B by owner
    let transferAtoB = 500;
    //Expect a revert - since accoutnA doesn't have that much in balance
    await expectRevert(
      erc20.transferFrom(accountA, accountB, transferAtoB),
      "token balance too low",
    );

  });

});
