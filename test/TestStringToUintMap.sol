pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import { StringToUintMap } from "../libraries/StringToUintMap.sol"; 

contract TestStringtoUintMap {
  StringToUintMap.Data private _stringToUintMapData; 
  
  function testInsertNewKey() {
    // Arrange
    string memory key = "test";
    uint8 value = 10;

    // Act
    StringToUintMap.insert(_stringToUintMapData, key, value);
    
    // Assert
    Assert.equal(uint(_stringToUintMapData.map[key]), uint(value), "The key should be added");
  }

  function testUpdatekey() {
    // Arrange 
    string memory key = "test2";
    StringToUintMap.insert(_stringToUintMapData, key, 10);
    
   // Act
   uint8 newValue = 20;
   bool updated = StringToUintMap.insert(_stringToUintMapData, key, newValue);

   // Assert
   Assert.isTrue(updated, "The value should be updated");
   Assert.equal(uint(_stringToUintMapData.map[key]), uint(newValue), "The value should be updated");
  }

  function testGetValue() {
    // Arrange 
    string memory key = "test3";
    uint8 value = 10;
    StringToUintMap.insert(_stringToUintMapData, key, value);

    // Act 
    uint8 result = StringToUintMap.get(_stringToUintMapData, key);
    
    // Assert 
    Assert.equal(uint(result), uint(value), "The key should have value");
  }
}

