// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Level} from "../Level.sol";
import {CoinFlip} from "./CoinFlip.sol";

contract CoinFlipFactory is Level {
    function createInstance(address /*_player*/ ) public payable override returns (address) {
        CoinFlip instance = new CoinFlip();
        return address(instance);
    }

    function validateInstance(address payable _instance, address /*_player*/ ) public view override returns (bool) {
        CoinFlip instance = CoinFlip(_instance);
        return instance.consecutiveWins() >= 10;
    }
}
