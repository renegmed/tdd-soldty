// contracts/Funding.sol
pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";


contract Funding is Ownable {
  using SafeMath for uint;

  uint public raised;
  uint public finishesAt;
  address public owner;
  mapping(address => uint) public balances; 

  uint public goal;

  modifier onlyNotFunded() {
    require(!isFunded());
    _;
  }

  modifier onlyFunded() {
    require(isFunded());
    _;
  }

  modifier onlyNotFinished() {
    require(!isFinished());
    _;
  }

  modifier onlyFinished() {
    require(isFinished());
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

  function withdraw() public onlyOwner onlyFunded {
    owner.transfer(this.balance);
  }


  function isFinished() public view returns (bool)  {
    return finishesAt <= now;
  }

  function donate() public onlyNotFinished payable {
    balances[msg.sender] += msg.value;
    raised += msg.value;
  }

  function refund() public onlyFinished onlyNotFunded {
    uint amount = balances[msg.sender];
    require(amount > 0 );
    balances[msg.sender] = 0;
    msg.sender.transfer(amount);
  }
}


