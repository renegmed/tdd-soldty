// contracts/Funding.sol
pragma solidity 0.4.24;

contract Funding {
  uint public raised;
  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function donate() public payable {
    raised += msg.value;
  }
}


