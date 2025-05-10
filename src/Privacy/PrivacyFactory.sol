// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Level} from "../Level.sol";
import {Privacy} from "./Privacy.sol";

contract PrivacyFactory is Level {
    function createInstance(address /*_player*/ ) public payable override returns (address) {
        bytes32[3] memory data = [keccak256("password"), keccak256("pass"), keccak256("passkey")];
        Privacy instance = new Privacy(data);
        return address(instance);
    }

    function validateInstance(address payable _instance, address /*_player*/ ) public view override returns (bool) {
        Privacy instance = Privacy(_instance);
        return !instance.locked();
    }
}
