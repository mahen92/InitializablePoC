pragma solidity ^0.8.13;

import "../../lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import "../../lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
import {Test, console} from "forge-std/Test.sol";

/**
 * @title Basic ERCUpgradeable
 * @author Mahendran Anbarasan
 * @notice
 */

contract DynamicERC20 is ERC20Upgradeable,UUPSUpgradeable{
       function _authorizeUpgrade(address _newImplementation) internal override {}

     

   function disable() public{
        _disableInitializers();
    }

       function initialize(string memory _name,string memory _symbol) initializer public {
        __ERC20_init(_name, _symbol);
        __UUPSUpgradeable_init();

        _mint(msg.sender, 1000000 * 10 ** decimals());
    }



    function namer() public view returns(string memory){
        console.log(" DERC20 namer()");
        return name();
    }
    
}
