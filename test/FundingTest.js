// test/FundingTest.js
const Funding = artifacts.require("Funding");
const { increaseTime } = require("./utils");

const DAY = 3600 * 24;
const FINNEY = 10**15;

contract("Funding", accounts => {
  
  const [firstAccount, secondAccount] = accounts;
  
  let funding;

  beforeEach( async () => {
    funding = await Funding.new(DAY);	
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


});

