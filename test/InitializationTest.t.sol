// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/ChildNaive.sol";
import "../src/NaiveInitialization.sol";
import "../src/ParentNaive.sol";

contract InititializationTest is Test {
    ChildNaive cNaive;

    function setUp() public {
        cNaive = new ChildNaive();
    }

    function test_child() public {
        cNaive.initializeChild();
    }
}
