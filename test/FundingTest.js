// test/FundingTest.js
const Funding = artifacts.require("Funding");
const { increaseTime } = require("./utils");

const DAY = 3600 * 24;
const FINNEY = 10**15;

contract("Funding", accounts => {
  
  const [firstAccount, secondAccount, thirdAccount] = accounts;
  
  let funding;

  beforeEach( async () => {
    funding = await Funding.new(DAY, 100 * FINNEY);	
  });

  it("sets an owner", async () => {
    assert.equal(await funding.owner.call(), firstAccount);
  });

  it("accepts donations", async () => {
    await funding.donate({ from: firstAccount, value: 10 * FINNEY });
    await funding.donate({ from: secondAccount, value: 20 * FINNEY });
    assert.equal(await funding.raised.call(), 30 * FINNEY);
 		
  });	

  it("keeps track of donator balance", async () => {
    await funding.donate({ from: firstAccount, value: 5 * FINNEY });
    await funding.donate({ from: secondAccount, value: 15 * FINNEY }); 
    await funding.donate({ from: secondAccount, value: 3 * FINNEY });
    assert.equal( await funding.balances.call(firstAccount), 5 * FINNEY );
    assert.equal( await funding.balances.call(secondAccount), 18 * FINNEY ); 	
  });

  it("finishes fundraising when time is up", async () => {
    assert.equal(await funding.isFinished.call(), false);
    await increaseTime(DAY);
    assert.equal( await funding.isFinished.call(), true);
  });

  it("allows an owner to withdraw funds when goal is reached", async () =>{
    await funding.donate({ from: secondAccount, value: 30 * FINNEY });
    await funding.donate({ from: thirdAccount, value: 70 * FINNEY });
    const initBalance = web3.eth.getBalance(firstAccount);
    assert.equal(web3.eth.getBalance(funding.address), 100 * FINNEY);
    await funding.withdraw();
    const finalBalance = web3.eth.getBalance(firstAccount);
    assert.ok(finalBalance.greaterThan(initBalance));  // hard to be exact due to the gas usage 
  });

});

