// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {BaseTest} from "./BaseTest.t.sol";
import {TelephoneFactory} from "../src/Telephone/TelephoneFactory.sol";
import {Telephone} from "../src/Telephone/Telephone.sol";
import {TelephoneAttacker} from "../src/Telephone/TelephoneAttacker.sol";


contract TelephoneTest is BaseTest {
    function testTelephoneHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        TelephoneFactory factory = new TelephoneFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Telephone ethernautTelephone = Telephone(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        TelephoneAttacker attacker = new TelephoneAttacker(levelAddress);
        attacker.attack();
        assertEq(ethernautTelephone.owner(), player);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
