// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/ProxyAdmin.sol";
import "../src/TransparentUpgradeableProxy.sol";
import "./mocks/MockToken.sol";

import "./mocks/MockTokenV1.sol";

contract InititializationTest is Test {}
