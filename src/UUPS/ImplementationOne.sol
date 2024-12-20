pragma solidity ^0.8.20;

import "./UUPSUpgradeable.sol";

/**
 * @title UUPS Demonstration
 * @author Mahendran Anbarasan
 * @notice
 */
contract ImplementationOne is UUPSUpgradeable {
    function myNumber() public pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address _newImplementation) internal override {}
}
