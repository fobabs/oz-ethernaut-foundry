// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Level} from "../Level.sol";
import {Elevator} from "./Elevator.sol";

contract ElevatorFactory is Level {
    function createInstance(address /*_player*/ ) public payable override returns (address) {
        Elevator instance = new Elevator();
        return address(instance);
    }

    function validateInstance(address payable _instance, address /*_player*/ ) public view override returns (bool) {
        Elevator instance = Elevator(_instance);
        return instance.top();
    }
}
