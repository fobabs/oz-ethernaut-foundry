// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {ForceFactory} from "../src/Force/ForceFactory.sol";
import {Force} from "../src/Force/Force.sol";
import {ForceAttacker} from "../src/Force/ForceAttacker.sol";

contract ForceTest is BaseTest {
    uint256 private constant AMOUNT_TO_SEND = 0.1 ether;

    function testForceHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        ForceFactory factory = new ForceFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Force ethernautForce = Force(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        ForceAttacker attacker = new ForceAttacker(payable(levelAddress));
        attacker.attack{value: AMOUNT_TO_SEND}();
        assertEq(AMOUNT_TO_SEND, address(ethernautForce).balance);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
