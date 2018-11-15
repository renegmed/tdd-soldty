// contracts/Funding.sol
pragma solidity 0.4.24;

contract Funding {
  address public owner;

  constructor() public {
    owner = msg.sender;
  }

}


