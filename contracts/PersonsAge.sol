// contracts/PersonsAge.sol

pragma solidity ^0.4.17;

import { StringToUintMap } from "../libraries/StringToUintMap.sol";

contract PersonsAge {
  
  StringToUintMap.Data private _stringToUintMapData;

  event PersonAdded(string name, uint8 age);
  event GetPersonAgeResponse(string name, uint8 age);

  function addPersonAge(string name, uint8 age) public {
    StringToUintMap.insert(_stringToUintMapData, name, age);
 
    emit PersonAdded(name, age);
  }

  function getPersonAge(string name) public returns (uint8) {
    uint8 age = StringToUintMap.get(_stringToUintMapData, name);
    
    emit GetPersonAgeResponse(name, age);

    return age;
  }
}

