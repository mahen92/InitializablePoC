pragma solidity ^0.8.13;

import "./TransparentUpgradeableProxy.sol";
import {ITransparentUpgradeableProxy} from "./TransparentUpgradeableProxy.sol";

/**
 * @title Child Proxy of TransparentUpgradeableProxy
 * @author Mahendran Anbarasan
 * @notice 
 */
contract OurProxy is TransparentUpgradeableProxy,ITransparentUpgradeableProxy{

    constructor(address _logic, address _intitialOwner, bytes memory data) TransparentUpgradeableProxy(_logic,_intitialOwner, data){

    }
     function upgradeToAndCall(address newImplementation, bytes calldata data) public payable override{
               _fallback();
     }
}