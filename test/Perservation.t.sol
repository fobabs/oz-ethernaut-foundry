// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {Preservation} from "../src/Preservation/Preservation.sol";
import {PreservationFactory} from "../src/Preservation/PreservationFactory.sol";
import {PreservationAttacker} from "../src/Preservation/PreservationAttacker.sol";

contract PreservationTest is BaseTest {
    function testPreservationHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        PreservationFactory factory = new PreservationFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Preservation ethernautPreservation = Preservation(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        PreservationAttacker attacker = new PreservationAttacker(levelAddress);
        attacker.attack();
        assertEq(ethernautPreservation.owner(), player);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
