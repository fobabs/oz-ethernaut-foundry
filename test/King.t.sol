// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {KingFactory} from "../src/King/KingFactory.sol";
import {King} from "../src/King/King.sol";
import {KingAttacker} from "../src/King/KingAttacker.sol";

contract KingTest is BaseTest {
    uint256 private constant INITIAL_PRIZE = 0.5 ether;
    uint256 private constant AMOUNT_TO_SEND = 1 ether;

    function testKingHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        KingFactory factory = new KingFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance{value: INITIAL_PRIZE}(factory);
        King ethernautKing = King(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        KingAttacker attacker = new KingAttacker(levelAddress);
        attacker.attack{value: AMOUNT_TO_SEND}();
        assertEq(ethernautKing._king(), address(attacker));

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
