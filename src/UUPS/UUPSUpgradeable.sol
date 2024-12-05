pragma solidity ^0.8.13;

import "./Initializable.sol";
import {ERC1967Utils} from "../TransparentUpgradeableProxy/ERC1967Utils.sol";
import "./IERC1822Proxiable.sol";

/**
 * @title UUPS Demonstration
 * @author Mahendran Anbarasan
 * @notice
 */

abstract contract UUPSUpgradeable is Inititalizable {
    address private immutable __self = address(this);
    string public constant UPGRADE_INTERFACE_VERSION = "5.0.0";

    error UUPSUnauthorizedCallContext();
    error UUPSUnsupportedProxiableUUID(bytes32 slot);

    function __UUPSUpgradeable_init() internal onlyInitializing {}

    function __UUPSUpgradeable_init_unchained() internal onlyInitializing {}

    modifier onlyProxy() {
        _checkProxy();
        _;
    }

    modifier notDelegated() {
        _checkNotDelegated();
        _;
    }

    function _checkNotDelegated() internal view virtual {
        if (address(this) != __self) {
            // Must not be called through delegatecall
            revert UUPSUnauthorizedCallContext();
        }
    }

    function upgradeAndCall(address newImplementation, bytes memory data) public payable virtual onlyProxy {
        _authorizeUpgrade(newImplementation);
        _upgradeToAndCallUUPS(newImplementation, data);
    }

    function _authorizeUpgrade(address newImplementation) internal virtual;

    function _upgradeToAndCallUUPS(address newImplementation, bytes memory data) private {
        try IERC1822Proxiable(newImplementation).proxiableUUID() returns (bytes32 slot) {
            if (slot != ERC1967Utils.IMPLEMENTATION_SLOT) {
                revert UUPSUnsupportedProxiableUUID(slot);
            }
            ERC1967Utils.upgradeToAndCall(newImplementation, data);
        } catch {
            revert();
        }
    }

    function _checkProxy() internal view virtual {
        if (
            address(this) == __self // Must be called through delegatecall
                || ERC1967Utils.getImplementation() != __self // Must be called through an active proxy
        ) {
            revert UUPSUnauthorizedCallContext();
        }
    }

    function proxiableUUID() external view virtual notDelegated returns (bytes32) {
        return ERC1967Utils.IMPLEMENTATION_SLOT;
    }
}
