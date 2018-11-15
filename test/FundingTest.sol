// test/FundingTest.sol
pragma solidity 0.4.24;

import "truffle/Assert.sol";
import "../contracts/Funding.sol";

contract FundingTest {

  uint public initialBalance = 10 ether;

  function testSettingAnOwnerDuringCreation() public {
    Funding funding = new Funding();
    Assert.equal(funding.owner(), this, "An owner is different than a deployer");
  }

  function testAcceptingDonations() public {
    Funding funding = new Funding();
    Assert.equal(funding.raised(), 0, "Initial raised amount is different than 0");
    funding.donate.value(10 finney)();
    funding.donate.value(20 finney)();
    Assert.equal(funding.raised(), 30 finney, "Raised amount is different than sum of donations");
  }

  function testTrackingDonorsBalance() public { 
    Funding funding = new Funding();
    funding.donate.value(5 finney)();
    funding.donate.value(15 finney)();
    Assert.equal(funding.balances(this), 20 finney, "Donator balance is different than sum of donations");
  }
}

