// contracts/Funding.sol
pragma solidity 0.4.24;

contract Funding {
  uint public raised;
  uint public finishesAt;
  address public owner;
  mapping(address => uint) public balances; 

  modifier onlyNotFinished() {
    require(!isFinished());
    _;
  }

  constructor(uint _duration) public {
    owner = msg.sender;
    finishesAt = now + _duration;
  }

  function isFinished() public view returns (bool)  {
    return finishesAt <= now;
  }

  function donate() public onlyNotFinished payable {
    balances[msg.sender] += msg.value;
    raised += msg.value;
  }

}


