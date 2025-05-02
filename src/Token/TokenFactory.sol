// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Level} from "../Level.sol";
import {Token} from "./Token.sol";

contract TokenFactory is Level {
    uint256 public constant TOTAL_SUPPLY = 21_000_000;
    uint256 public constant PLAYER_SUPPLY = 20;

    function createInstance(address _player) public payable override returns (address) {
        Token instance = new Token(TOTAL_SUPPLY);
        instance.transfer(_player, PLAYER_SUPPLY);
        return address(instance);
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool) {
        Token instance = Token(_instance);
        return instance.balanceOf(_player) > PLAYER_SUPPLY;
    }
}
