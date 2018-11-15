// contracts/Funding.sol
pragma solidity 0.4.24;

contract Funding {
  uint public raised;
  uint public finishesAt;
  address public owner;
  mapping(address => uint) public balances; 

  uint public goal;
 
  modifier onlyFunded() {
    require(isFunded());
    _;
  }

  modifier onlyNotFinished() {
    require(!isFinished());
    _;
  }

  constructor(uint _duration, uint _goal) public {
    owner = msg.sender;
    finishesAt = now + _duration;
    goal = _goal;
  }

  function isFunded() public view returns (bool) {
    return raised >= goal;
  }

  function withdraw() public onlyFunded {
    owner.transfer(this.balance);
  }


  function isFinished() public view returns (bool)  {
    return finishesAt <= now;
  }

  function donate() public onlyNotFinished payable {
    balances[msg.sender] += msg.value;
    raised += msg.value;
  }

}


