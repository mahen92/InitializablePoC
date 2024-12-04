pragma solidity ^0.8.13;

import "./ERC1967Proxy.sol";

interface ITransparentUpgradeableProxy {
    /// @dev See {UUPSUpgradeable-upgradeToAndCall}
    function upgradeToAndCall(address newImplementation, bytes calldata data) external payable;
}

contract TransparentUpgradeableProxy is ERC1967Proxy {
    address private immutable admin;

    error ProxyDeniedAdminAccess();

    constructor(address _logic, address _intitialOwner, bytes memory data) payable ERC1967Proxy(_logic, data) {
        admin = _intitialOwner;
        ERC1967Utils._setImplementation(admin);
    }

    function _proxyAdmin() public returns (address) {
        return admin;
    }

    function _fallback() internal virtual override {
        if (msg.sender == _proxyAdmin()) {
            if (msg.sig != ITransparentUpgradeableProxy.upgradeToAndCall.selector) {
                revert ProxyDeniedAdminAccess();
            } else {
                _dispatchUpgradeToAndCall();
            }
        } else {
            super._fallback();
        }
    }

    function _dispatchUpgradeToAndCall() private {
        (address newImplementation, bytes memory data) = abi.decode(msg.data[4:], (address, bytes));
        ERC1967Utils.upgradeToAndCall(newImplementation, data);
    }
}
