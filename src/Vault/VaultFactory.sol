// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Level} from "../Level.sol";
import {Vault} from "./Vault.sol";

contract VaultFactory is Level {
    function createInstance(address /* _player */ ) public payable override returns (address) {
        Vault instance = new Vault(keccak256("password"));
        return address(instance);
    }

    function validateInstance(address payable _instance, address /* _player */ ) public view override returns (bool) {
        Vault instance = Vault(_instance);
        return !instance.locked();
    }
}
