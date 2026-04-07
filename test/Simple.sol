// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import "forge-std/Test.sol";

import "../contracts/Unoptimized.sol";
import "../contracts/Optimized.sol";

contract DataLocationsTest is Test {
    Unoptimized unoptimizedContract;
    Optimized optimizedContract;

    function setUp() public {
        unoptimizedContract = new Unoptimized();
        optimizedContract = new Optimized();
    }

    function test_OptimizedLogicAndSum() public {
        uint256[] memory inputData = new uint256[](5);
        inputData[0] = 1;
        inputData[1] = 2;
        inputData[2] = 3;
        inputData[3] = 4;
        inputData[4] = 5;

        optimizedContract.processNumbers(inputData);

        assertEq(optimizedContract.totalSum(), 30, "Total sum should be 30");

        assertEq(optimizedContract.numbers(0), 2, "First element should be 2");
        assertEq(optimizedContract.numbers(4), 10, "Last element should be 10");
    }

    function test_GasUsageComparison() public {
        uint256[] memory inputData = new uint256[](50);
        for (uint256 i = 0; i < 50; i++) {
            inputData[i] = i + 1;
        }

        uint256 gasBeforeUnopt = gasleft();
        unoptimizedContract.processNumbers(inputData);
        uint256 gasUsedUnopt = gasBeforeUnopt - gasleft();

        uint256 gasBeforeOpt = gasleft();
        optimizedContract.processNumbers(inputData);
        uint256 gasUsedOpt = gasBeforeOpt - gasleft();

        console.log("=== Gas Consumption Report ===");
        console.log("Unoptimized Gas Used: ", gasUsedUnopt);
        console.log("Optimized Gas Used:   ", gasUsedOpt);
        console.log("Gas Saved:            ", gasUsedUnopt - gasUsedOpt);
        console.log("==============================");

        assertTrue(gasUsedOpt < gasUsedUnopt, "Optimized contract should be cheaper");
    }
}
