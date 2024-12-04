// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {ITransparentUpgradeableProxy} from "./TransparentUpgradeableProxy.sol";

contract ProxyAdmin is Ownable {
    string public constant UPGRADE_INTERFACE_VERSION = "5.0.0";

    constructor(address initialOwner) Ownable(initialOwner) {}

    function upgradeAndCall(ITransparentUpgradeableProxy proxy, address _implementation, bytes memory data) external {
        proxy.upgradeToAndCall(_implementation, data);
    }
}
