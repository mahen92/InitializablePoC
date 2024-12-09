// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/ERC20Upgradeable/DynamicERC20.sol";
import "../src/ERC20Upgradeable/DynamicERC20V2.sol";
import "../src/ERC20Upgradeable/UUPSProxy.sol";


/**
 * @title Tests to demonstrate initializer(),reinitializer() and disableInitializer() method
 * @author Mahendran Anbarasan
 * @notice
 */
contract UUPSTest is Test {
    DynamicERC20 erc20;
    DynamicERC20V2 erc20V2;
    UUPSProxy proxy;
    address alice = makeAddr("alice");

    function setUp() public {
        erc20 = new DynamicERC20();
        erc20V2 = new DynamicERC20V2();
        proxy = new UUPSProxy(address(erc20),"");
    }

    /**
     * The mint function in MockToken is called through the OurProxy contract through delegation.
     */
    function test_erc20() public {

        address(proxy).call(abi.encodeWithSignature("initialize(string,string)","MyDToken","MDK"));
        (bool success, bytes memory result) = address(proxy).call(abi.encodeWithSignature("name()"));
        string memory name = abi.decode(result, (string));
        console.log("success:",success);

        console.log("stringer:",name);
        //assertEq(number, 1);
    }


    function test_doubleInit() public{
        address(proxy).call(abi.encodeWithSignature("initialize(string,string)","MyDToken","MDK"));
        (bool success, bytes memory result) = address(proxy).call(abi.encodeWithSignature("name()"));
        string memory name = abi.decode(result, (string));
        console.log("firstName:",name);

        //address(proxy).call(abi.encodeWithSignature("disable()"));

        address(proxy).call(abi.encodeWithSignature("initialize(string,string)","MyD2Token","M2DK"));
        (bool success1, bytes memory result1) = address(proxy).call(abi.encodeWithSignature("name()"));
        string memory name1 = abi.decode(result1, (string));
        console.log("secondName:",name1);
    }

    function test_changeContract() public{
        address(proxy).call(abi.encodeWithSignature("initialize(string,string)","MyDToken","MDK"));
        (bool success, bytes memory result) = address(proxy).call(abi.encodeWithSignature("namer()"));
        string memory name = abi.decode(result, (string));
        console.log("firstName:",name);

        (bool passed,)=address(proxy).call(abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(erc20V2), ""));

        address(proxy).call(abi.encodeWithSignature("initialize(string,string)","MyD2Token","M2DK"));
        (bool success1, bytes memory result1) = address(proxy).call(abi.encodeWithSignature("namer()"));
        string memory name1 = abi.decode(result1, (string));
        console.log("secondName:",name1);
    }

    function test_changeContractWithoutReInt() public{
        address(proxy).call(abi.encodeWithSignature("initialize(string,string)","MyDToken","MDK"));
        (bool success, bytes memory result) = address(proxy).call(abi.encodeWithSignature("namer()"));
        string memory name = abi.decode(result, (string));
        console.log("firstName:",name);
        console.log("impl");

        address(proxy).call(abi.encodeWithSignature("disable()"));

        (bool passed,)=address(proxy).call(abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(erc20V2), ""));

        address(proxy).call(abi.encodeWithSignature("initialize(string,string)","MyD2Token","M2DK"));
        (bool success1, bytes memory result1) = address(proxy).call(abi.encodeWithSignature("namer()"));
        string memory name1 = abi.decode(result1, (string));
        console.log("secondName:",name1);
    }


    
}
