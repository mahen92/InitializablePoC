pragma solidity ^0.8.20;

import "./UUPSUpgradeable.sol";

contract ImplementationTwo is UUPSUpgradeable {
    function myNumber() public pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(address _newImplementation) internal override {}
}
