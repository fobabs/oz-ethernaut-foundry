// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Level} from "../Level.sol";
import {King} from "./King.sol";

contract KingFactory is Level {
    receive() external payable {}

    function createInstance(address /*_player*/ ) public payable override returns (address) {
        King instance = new King{value: msg.value}();
        return address(instance);
    }

    function validateInstance(address payable _instance, address /*_player*/ ) public view override returns (bool) {
        King instance = King(_instance);
        return instance._king() != address(this);
    }
}
