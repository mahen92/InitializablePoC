//SPDX-License-identifier:MIT
pragma solidity ^0.8.13;

import "../TransparentUpgradeableProxy/ERC1967Proxy.sol";
/**
 * @title Barebones Proxy Recreation
 * @author Mahendran Anbarasan
 * @notice
 */

contract UUPSProxy is ERC1967Proxy {
    constructor(address implementation, bytes memory _data) payable ERC1967Proxy(implementation, _data) {}

    fallback() external payable override {
        _delegate(_implementation());
    }
}
