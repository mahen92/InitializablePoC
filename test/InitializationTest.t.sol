// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/ProxyAdmin.sol";
import "../src/TransparentUpgradeableProxy.sol";
import {ITransparentUpgradeableProxy} from"../src/TransparentUpgradeableProxy.sol";
import {ERC1967Proxy} from "../src/ERC1967Proxy.sol";
import "./mocks/MockToken.sol";
import "./mocks/MockTokenV1.sol";
import "../src/OurProxy.sol";

/**
 * @title Testing barebones Upgradeable Implementation
 * @author Mahendran Anbarasan
 * @notice 
 */
contract InititializationTest is Test {
    
    ProxyAdmin pAdmin;
    OurProxy tProxy;
    address owner = makeAddr("owner");
    address alice = makeAddr("alice");
    MockToken mt = new MockToken();
    MockTokenV1 mt1 = new MockTokenV1();

    function setUp() public {
        //ProxyAdmin contract is created with its owner as "owner"
        pAdmin = new ProxyAdmin(owner);
        //OurProxy contract which is a child of TransparentUpgradeableProxy is created. The logic address is
        // MockToken and owner Address is given as the ProxyAdmin.
        tProxy = new OurProxy(address(mt), address(pAdmin), "");
    }

    /**
     * The mint function in MockToken is called through the OurProxy contract through delegation.
     */
    function test_mint() public {
        vm.startPrank(alice);
        address(tProxy).call(abi.encodeWithSignature("mint(uint256)", 10));
        vm.stopPrank();
        (bool success, bytes memory result) = address(tProxy).staticcall(abi.encodeWithSignature("balanceOf(address)", alice));
         uint256 balance = abi.decode(result, (uint256));
         assertEq(balance,10);
    }

    /**
     * This test illustrates how the logic is upgraded from MockToken to MockTokenV1.
     */
    function test_upgrade() public {
        vm.startPrank(owner);
        pAdmin.upgradeAndCall(ITransparentUpgradeableProxy(tProxy),address(mt1),"");
        vm.stopPrank();
        assertEq(address(mt1),tProxy.impl());
    }

    /**
     * Upgrade and mint are tested in the same method.
     */
    function test_upgradeAndMint() public {
        vm.startPrank(owner);
        pAdmin.upgradeAndCall(ITransparentUpgradeableProxy(tProxy),address(mt1),"");
        vm.stopPrank();

        vm.startPrank(alice);
        address(tProxy).call(abi.encodeWithSignature("mint(uint256)", 10));
        vm.stopPrank();
        (bool success, bytes memory result) = address(tProxy).staticcall(abi.encodeWithSignature("balanceOf(address)", alice));
         uint256 balance = abi.decode(result, (uint256));
         assertEq(balance,20);

    }
}
