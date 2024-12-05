//SPDX-License-identifier:MIT
pragma solidity ^0.8.13;

import "./Proxy.sol";
import {ERC1967Utils} from "./ERC1967Utils.sol";
/**
 * @title ERC1967 Barebones recreation
 * @author Mahendran Anbarasan
 * @notice
 */

abstract contract ERC1967Proxy is Proxy {
    constructor(address implementation, bytes memory _data) payable {
        ERC1967Utils.upgradeToAndCall(implementation, _data);
    }

    function _implementation() internal view virtual override returns (address) {
        return ERC1967Utils.getImplementation();
    }
}
