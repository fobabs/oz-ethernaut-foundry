// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Level} from "../Level.sol";
import {GatekeeperTwo} from "./GatekeeperTwo.sol";

contract GatekeeperTwoFactory is Level {
    function createInstance(address /*_player*/ ) public payable override returns (address) {
        GatekeeperTwo instance = new GatekeeperTwo();
        return address(instance);
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool) {
        GatekeeperTwo instance = GatekeeperTwo(_instance);
        return instance.entrant() == _player;
    }
}
