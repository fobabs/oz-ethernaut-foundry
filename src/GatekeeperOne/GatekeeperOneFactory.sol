// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Level} from "../Level.sol";
import {GatekeeperOne} from "./GatekeeperOne.sol";

contract GatekeeperOneFactory is Level {
    function createInstance(address /*_player*/ ) public payable override returns (address) {
        GatekeeperOne gateKeeperOne = new GatekeeperOne();
        return address(gateKeeperOne);
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool) {
        GatekeeperOne instance = GatekeeperOne(_instance);
        return instance.entrant() == _player;
    }
}
