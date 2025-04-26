// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Level} from "../Level.sol";
import {Telephone} from "./Telephone.sol";

contract TelephoneFactory is Level {
    function createInstance(address /*_player*/ ) public payable override returns (address) {
        Telephone telephone = new Telephone();
        return address(telephone);
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool) {
        Telephone instance = Telephone(_instance);
        return instance.owner() == _player;
    }
}
