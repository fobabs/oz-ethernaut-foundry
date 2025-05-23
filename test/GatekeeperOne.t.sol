// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {GatekeeperOneFactory} from "../src/GatekeeperOne/GatekeeperOneFactory.sol";
import {GatekeeperOne} from "../src/GatekeeperOne/GatekeeperOne.sol";
import {GatekeeperOneAttacker} from "../src/GatekeeperOne/GatekeeperOneAttacker.sol";

contract GatekeeperOneTest is BaseTest {
    function setUp() public override {
        super.setUp();
        vm.deal(tx.origin, PLAYER_STARTING_BALANCE);
    }

    function testGateKeeperOneHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        GatekeeperOneFactory factory = new GatekeeperOneFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(factory);
        GatekeeperOne ethernautGatekeeperOne = GatekeeperOne(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        GatekeeperOneAttacker attacker = new GatekeeperOneAttacker(levelAddress);
        attacker.attack();
        assertEq(ethernautGatekeeperOne.entrant(), tx.origin);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
