// migrations/2_funding.js
const Funding = artifacts.require("./Funding.sol");
const StringToUintMap = artifacts.require("./StringToUintMap.sol");
const PersonsAge = artifacts.require("./PersonsAge.sol");

const FINNEY = 10 ** 15;
const DAY = 3600 * 12;

module.exports = function(deployer) {
  deployer.deploy(Funding, DAY, 100 * FINNEY);
  deployer.deploy(StringToUintMap);
  deployer.link(StringToUintMap, PersonsAge);
  deployer.deploy(PersonsAge);
}



