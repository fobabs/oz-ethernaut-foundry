// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {ReentranceFactory} from "../src/Reentrancy/ReentranceFactory.sol";
import {Reentrance} from "../src/Reentrancy/Reentrance.sol";
import {ReentranceAttacker} from "../src/Reentrancy/ReentranceAttacker.sol";

contract ReentranceTest is BaseTest {
    function testReentranceHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        ReentranceFactory factory = new ReentranceFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Reentrance ethernautReentrance = Reentrance(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        ReentranceAttacker attacker = new ReentranceAttacker(levelAddress);
        attacker.attack{value: 1 ether}();
        assertEq(address(ethernautReentrance).balance, 0);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelCompleted);
    }
}
