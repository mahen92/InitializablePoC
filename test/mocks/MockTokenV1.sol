// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MockTokenV1 is ERC20 {
    constructor() ERC20("MToken1", "MT1") {}
}
