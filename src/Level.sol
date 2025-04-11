// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

abstract contract Level {
    function createInstance(address _player) public payable virtual returns (address instance);
    function validateInstance(address payable _instance, address _player) public virtual returns (bool);
}
