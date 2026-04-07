// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract Unoptimized {
    uint256[] public numbers; 
    uint256 public totalSum;  

    function processNumbers(uint256[] memory _input) public {
        
        for (uint256 i = 0; i < _input.length; i++) {
            numbers.push(_input[i] * 2); 
            totalSum += _input[i] * 2; 
        }
    }
}
