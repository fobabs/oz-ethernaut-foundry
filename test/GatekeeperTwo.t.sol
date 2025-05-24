// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {GatekeeperTwoFactory} from "../src/GatekeeperTwo/GatekeeperTwoFactory.sol";
import {GatekeeperTwo} from "../src/GatekeeperTwo/GatekeeperTwo.sol";
import {GatekeeperTwoAttacker} from "../src/GatekeeperTwo/GatekeeperTwoAttacker.sol";

contract GatekeeperTwoTest is BaseTest {
    function setUp() public override {
        super.setUp();
        vm.deal(tx.origin, PLAYER_STARTING_BALANCE);
    }

    function testGatekeeperTwoHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        GatekeeperTwoFactory factory = new GatekeeperTwoFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(factory);
        GatekeeperTwo ethernautGatekeeperTwo = GatekeeperTwo(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        new GatekeeperTwoAttacker(levelAddress);
        assertEq(ethernautGatekeeperTwo.entrant(), tx.origin);

        //////////////////////*/
        //   Level Completion
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
