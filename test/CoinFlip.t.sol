// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {CoinFlip} from "../src/CoinFlip/CoinFlip.sol";
import {CoinFlipFactory} from "../src/CoinFlip/CoinFlipFactory.sol";
import {CoinFlipAttacker} from "../src/CoinFlip/CoinFlipAttacker.sol";

contract CoinFlipTest is BaseTest {
    function testCoinFlipHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        CoinFlipFactory factory = new CoinFlipFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        CoinFlip ethernautCoinFlip = CoinFlip(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        CoinFlipAttacker coinFlipAttacker = new CoinFlipAttacker(levelAddress);
        // Run the attack 10 times
        for (uint256 i = 0; i < 10; i++) {
            vm.roll(i + 1);
            coinFlipAttacker.attack();
        }
        assert(ethernautCoinFlip.consecutiveWins() >= 10);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
