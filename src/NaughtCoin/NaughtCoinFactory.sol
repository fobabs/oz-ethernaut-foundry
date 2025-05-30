// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Level} from "../Level.sol";
import {NaughtCoin} from "./NaughtCoin.sol";

contract NaughtCoinFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        NaughtCoin instance = new NaughtCoin(_player);
        return address(instance);
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool) {
        NaughtCoin instance = NaughtCoin(_instance);
        return instance.balanceOf(_player) == 0;
    }
}
