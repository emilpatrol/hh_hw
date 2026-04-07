// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract Optimized {
    uint256[] public numbers; 
    uint256 public totalSum;  

    function processNumbers(uint256[] calldata _input) public {
        uint256 length = _input.length; 
        uint256 tempSum = 0; 
        for (uint256 i = 0; i < length; ++i) { 
            uint256 doubled = _input[i] * 2;
            numbers.push(doubled);      
            tempSum += doubled; 
        }
        totalSum += tempSum; 
    }
}
