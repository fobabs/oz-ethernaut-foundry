// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {ElevatorFactory} from "../src/Elevator/ElevatorFactory.sol";
import {Elevator} from "../src/Elevator/Elevator.sol";
import {ElevatorAttacker} from "../src/Elevator/ElevatorAttacker.sol";

contract ElevatorTest is BaseTest {
    function testElevatorHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        ElevatorFactory factory = new ElevatorFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Elevator ethernautElevator = Elevator(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        ElevatorAttacker attacker = new ElevatorAttacker(levelAddress);
        attacker.attack();
        assertTrue(ethernautElevator.top());

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
