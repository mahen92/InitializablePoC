// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

/**
 * @title Mock ERC20 Token
 * @author Mahendran Anbarasan
 * @notice
 */
contract MockTokenV1 is ERC20 {
    constructor() ERC20("MToken1", "MT1") {}

    function mint(uint256 amount) public {
        amount = amount * 2;
        _mint(msg.sender, amount);
    }
}
