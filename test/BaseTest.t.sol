// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {Ethernaut} from "../src/Ethernaut.sol";

abstract contract BaseTest is Test {
    Ethernaut public ethernaut;
    address public player = makeAddr("player");
    uint256 public constant PLAYER_STARTING_BALANCE = 5 ether;

    function setUp() public virtual {
        ethernaut = new Ethernaut();
        vm.deal(player, PLAYER_STARTING_BALANCE);
    }
}
