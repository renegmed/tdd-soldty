// test/FundingTest.sol
pragma solidity 0.4.24;

import "truffle/Assert.sol";
import "../contracts/Funding.sol";

contract FundingTest {
  Funding funding;
  uint public initialBalance = 10 ether;

  function beforeEach() public {
    funding = new Funding(1 days);
  }

  function testSettingAnOwnerDuringCreation() public {
    Assert.equal(funding.owner(), this, "An owner is different than a deployer");
  }

  function testAcceptingDonations() public {
    Assert.equal(funding.raised(), 0, "Initial raised amount is different than 0");
    funding.donate.value(10 finney)();
    funding.donate.value(20 finney)();
    Assert.equal(funding.raised(), 30 finney, "Raised amount is different than sum of donations");
  }

  function testTrackingDonorsBalance() public { 
    funding.donate.value(5 finney)();
    funding.donate.value(15 finney)();
    Assert.equal(funding.balances(this), 20 finney, "Donator balance is different than sum of donations");
  }

  function testDonatingAfterTimeIsUp() public {
    bool result = funding.call.value(10 finney)(bytes4(bytes32(keccak256("donate()"))));
    Assert.equal(result, true, "Should allow for donations before the deadline.");
    
    funding = new Funding(0);
    result = funding.call.value(10 finney)(bytes4(bytes32(keccak256("donate()"))));
    Assert.equal(result, false, "Should not allow for donations when time is up.");

    
  }
}

