// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

/**
 * @title Mock ERC20 Token
 * @author Mahendran Anbarasan
 * @notice
 */
contract MockToken is ERC20 {
    constructor() ERC20("MToken", "MT") {}

    function mint(uint256 amount) public {
        console.log("MKToken mint()");
        _mint(msg.sender, amount);
    }

    function balance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }

    fallback() external {
        console.log("fallback");
    }
}
