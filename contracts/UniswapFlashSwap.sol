// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {IUniswapV3Pool} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import {IERC20} from "./interfaces/IERC20.sol";
import {PoolAddress} from "@uniswap/v3-periphery/contracts/libraries/PoolAddress.sol";

/// @title UniswapV3Flash - Example contract for performing Uniswap V3 flash swaps
/// @notice This contract demonstrates how to initiate and handle a flash swap using Uniswap V3 pools
/// @dev Uses Uniswap V3's flash functionality to borrow WETH and expects repayment plus fee in the callback
contract UniswapV3Flash {
    IUniswapV3Pool private immutable i_pool;

    address private constant FACTORY =
        0x1F98431c8aD98523631AE4a59f267346ea31F984;

    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    IERC20 private constant weth = IERC20(WETH);

    uint24 private constant POOL_FEE = 3000;

    /// @notice Struct to store flash swap data
    /// @param wethAmount The amount of WETH to borrow in the flash swap
    /// @param caller The address that initiated the flash swap
    struct FlashData {
        uint wethAmount;
        address caller;
    }

    /// @notice Initializes the Uniswap V3 pool for DAI/WETH with a specified fee tier
    /// @dev Computes the pool address using the factory and pool key
    constructor() {
        PoolAddress.PoolKey memory poolKey = PoolAddress.getPoolKey(
            DAI,
            WETH,
            POOL_FEE
        );
        i_pool = IUniswapV3Pool(PoolAddress.computeAddress(FACTORY, poolKey));
    }

    /// @notice Initiates a Uniswap V3 flash swap for a specified amount of WETH
    /// @param wethAmount The amount of WETH to borrow in the flash swap
    function flash(uint wethAmount) external {
        bytes memory data = abi.encode(
            FlashData({wethAmount: wethAmount, caller: msg.sender})
        );

        i_pool.flash(address(this), 0, wethAmount, data);
    }

    /// @notice Callback function called by the Uniswap V3 pool after the flash swap
    /// @dev Must repay the borrowed amount plus the fee to the pool
    /// @param fee0 The fee for token0 (DAI) borrowed (always 0 in this contract)
    /// @param fee1 The fee for token1 (WETH) borrowed
    /// @param data Encoded FlashData containing the original caller and amount
    function uniswapV3FlashCallback(
        uint fee0,
        uint fee1,
        bytes calldata data
    ) external {
        require(msg.sender == address(i_pool), "not authorized");

        FlashData memory decoded = abi.decode(data, (FlashData));

        weth.transferFrom(decoded.caller, address(this), fee1);
        weth.transfer(address(i_pool), decoded.wethAmount + fee1);
    }
}
