// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Level} from "../Level.sol";
import {Reentrance} from "./Reentrance.sol";

contract ReentranceFactory is Level {
    function createInstance(address /*_player*/ ) public payable override returns (address) {
        Reentrance instance = new Reentrance();
        return address(instance);
    }

    function validateInstance(address payable _instance, address /*_player*/ ) public view override returns (bool) {
        Reentrance instance = Reentrance(_instance);
        return address(instance).balance == 0;
    }
}
