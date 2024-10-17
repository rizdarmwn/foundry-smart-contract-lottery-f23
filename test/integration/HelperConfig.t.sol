// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {HelperConfig, CodeConstants} from "script/HelperConfig.s.sol";

contract HelperConfigTest is Test, CodeConstants {
    HelperConfig public helperConfig;

    function setUp() external {
        helperConfig = new HelperConfig();
    }

    function testGetConfigByChainIdAnvil() public {
        HelperConfig.NetworkConfig memory networkConfig = helperConfig.getOrCreateAnvilEthConfig();

        assert(helperConfig.getConfigByChainId(LOCAL_CHAIN_ID).account == networkConfig.account);
    }

    function testGetConfigByChainIdSepolia() public {
        HelperConfig.NetworkConfig memory networkConfig = helperConfig.getSepoliaEthConfig();

        assert(helperConfig.getConfigByChainId(ETH_SEPOLIA_CHAIN_ID).account == networkConfig.account);
    }

    function testGetConfigByChainIdInvalidChainId() public {
        vm.expectRevert(HelperConfig.HelperConfig__InvalidChainId.selector);
        helperConfig.getConfigByChainId(0);
    }
}
