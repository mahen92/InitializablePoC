//SPDX-License-identifier:MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

/**
 * @title Barebones Proxy Recreation
 * @author Mahendran Anbarasan
 * @notice
 */
abstract contract Proxy {
    function _delegate(address implementation) internal virtual {
        console.log("Proxy Delegate:", implementation);
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    function _implementation() internal view virtual returns (address);

    function _fallback() internal virtual {
        _delegate(_implementation());
    }

    fallback() external payable virtual {
        _fallback();
    }
}
