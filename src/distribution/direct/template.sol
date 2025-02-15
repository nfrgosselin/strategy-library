// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IDistributionStrategy} from "../../../lib/allo-v2/contracts/core/interfaces/IDistributionStrategy.sol";

error NotUsed();

contract DirectGrantsDistributionStrategy is IDistributionStrategy {
    // NOTE: Should support multicall using OZ's Multicall2

    uint256 poolId;
    address allo;
    // todo: should we name this poolOwner?
    address strategyOwner;

    constructor(address _strategyOwner) {
        strategyOwner = _strategyOwner;
    }

    function owner() public view override returns (address) {
        return strategyOwner;
    }

    function activateDistribution(bytes memory _data) public override {
        // decode data to get the recipients and amounts
        (address[] memory recipients, uint256[] memory amounts) = abi.decode(
            _data,
            (address[], uint256[])
        );
        // Send the tokens to the recipients.
        // todo: add custom options for token types. i.e. ETH, ERC20, ERC721, ERC1155
        for (uint256 i = 0; i < recipients.length; i++) {
            (bool success, ) = recipients[i].call{value: amounts[i]}("");
            require(success, "DirectGrantsDistributionStrategy: Transfer failed.");
        }
    }

    function claim(bytes memory /* _data */) public pure override {
        // Not used in this strategy.
        revert NotUsed();
    }

    // Custom functions

    function setStrategyOwner(address _strategyOwner) public {
        strategyOwner = _strategyOwner;
    }
}
