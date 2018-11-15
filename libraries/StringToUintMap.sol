// contracts/StringToUintMap.sol

pragma solidity ^0.4.17;

library StringToUintMap {
  struct Data {
    mapping (string => uint8) map;
  }

  // NOTE: changing functions type 
  // from public to internal makes compiling the 
  // library becomes the part of the compiled code of
  // the contract and does not have to be
  // deployed separately.

  function insert (
    Data storage self,
    string key, 
    uint8 value
  ) internal returns (bool updated) 
  {
    require(value > 0);

    updated = self.map[key] != 0;
    self.map[key] = value;	
  }

  function get(Data storage self, string key) internal returns (uint8) {
    return self.map[key];
  } 
}
