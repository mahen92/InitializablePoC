//SPDX-License-identifier:MIT
pragma solidity ^0.8.13;

library ERC1967Utils {
    error NonPayableCheck();
    error DelegateFailed();

    bytes32 private constant IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    struct AddressSlot {
        address value;
    }

    function getImplementation() internal view returns (address) {
        AddressSlot storage r;
        assembly {
            r.slot := IMPLEMENTATION_SLOT
        }
        return r.value;
    }

    function _setImplementation(address _implementation) internal {
        AddressSlot storage r;
        assembly {
            r.slot := IMPLEMENTATION_SLOT
        }
        r.value = _implementation;
    }

    function upgradeToAndCall(address _implementation, bytes memory data) public {
        _setImplementation(_implementation);
        if (data.length > 0) {
            (bool success, bytes memory returndata) = _implementation.delegatecall(data);
            if (!success) {
                revert DelegateFailed();
            } else {
                _checkNonPayable();
            }
        }
    }

    function _checkNonPayable() internal view {
        if (msg.value > 0) {
            revert NonPayableCheck();
        }
    }
}
