// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/UUPS/ImplementationOne.sol";
import "../src/UUPS/ImplementationTwo.sol";

import "../src/UUPS/UUPSProxy.sol";

/**
 * @title Testing barebones Upgradeable Implementation
 * @author Mahendran Anbarasan
 * @notice
 */
contract UUPSTest is Test {
    ImplementationOne impl;
    ImplementationTwo impl2;

    UUPSProxy proxy;

    function setUp() public {
        impl = new ImplementationOne();
        proxy = new UUPSProxy(address(impl), "");
        impl2 = new ImplementationTwo();
    }

    /**
     * The mint function in MockToken is called through the OurProxy contract through delegation.
     */
    function test_impl() public {
        (bool success, bytes memory result) = address(proxy).call(abi.encodeWithSignature("myNumber()"));
        uint256 number = abi.decode(result, (uint256));
        assertEq(number, 1);
    }

    function test_changeImpl() public {
        address(proxy).call(abi.encodeWithSignature("upgradeAndCall(address,bytes)", address(impl2), ""));
        (bool success, bytes memory result) = address(proxy).call(abi.encodeWithSignature("myNumber()"));
        uint256 number = abi.decode(result, (uint256));
        assertEq(number, 2);
    }
}
