// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Level} from "../Level.sol";
import {Delegation, Delegate} from "./Delegation.sol";

contract DelegationFactory is Level {
    function createInstance(address /*_player*/ ) public payable override returns (address) {
        Delegate delegate = new Delegate(address(1));
        Delegation instance = new Delegation(address(delegate));
        return address(instance);
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool) {
        Delegation instance = Delegation(_instance);
        return instance.owner() == _player;
    }
}
