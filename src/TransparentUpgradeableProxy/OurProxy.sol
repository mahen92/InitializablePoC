pragma solidity ^0.8.13;

import "./TransparentUpgradeableProxy.sol";
import {ITransparentUpgradeableProxy} from "./TransparentUpgradeableProxy.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

/**
 * @title Child Proxy of TransparentUpgradeableProxy
 * @author Mahendran Anbarasan
 * @notice
 */
contract OurProxy is TransparentUpgradeableProxy, ITransparentUpgradeableProxy, ERC20 {
    constructor(address _logic, address _intitialOwner, bytes memory data)
        TransparentUpgradeableProxy(_logic, _intitialOwner, data)
        ERC20("CheckToken", "CT")
    {}

    function upgradeToAndCall(address newImplementation, bytes calldata data) public payable override {
        _fallback();
    }
}
