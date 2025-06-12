// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

import {IWETH} from "./interfaces/IWETH.sol";
import {IERC20} from "./interfaces/IERC20.sol";

/// @title UniswapV3SingleHopSwap
/// @notice Facilitates single-hop swaps between WETH and DAI using Uniswap V3
/// @dev Uses Uniswap V3 Periphery's ISwapRouter for swaps. Assumes user has approved WETH to this contract.
/// @author 0xOse
contract UniswapV3SingleHopSwap {
    ISwapRouter private constant router =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    IWETH private constant weth = IWETH(WETH);
    IERC20 private constant dai = IERC20(DAI);

    /// @notice Swaps an exact amount of WETH for as much DAI as possible (single-hop)
    /// @dev Transfers WETH from sender, approves router, and performs swap. Assumes prior approval.
    /// @param amountIn The exact amount of WETH to swap
    /// @param amountOutMin The minimum acceptable amount of DAI to receive (slippage protection)
    function swapExactInputSingleHop(
        uint amountIn,
        uint amountOutMin
    ) external {
        weth.transferFrom(msg.sender, address(this), amountIn);
        weth.approve(address(router), amountIn);
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: WETH,
                tokenOut: DAI,
                fee: 3000,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: amountOutMin,
                sqrtPriceLimitX96: 0
            });
        router.exactInputSingle(params);
    }

    /// @notice Swaps as little WETH as needed to receive an exact amount of DAI (single-hop)
    /// @dev Transfers up to amountInMax WETH from sender, approves router, and performs swap. Refunds excess WETH.
    /// @param amountOut The exact amount of DAI to receive
    /// @param amountInMax The maximum amount of WETH to spend (slippage protection)
    function swapExactOutputSingleHop(
        uint amountOut,
        uint amountInMax
    ) external {
        weth.transferFrom(msg.sender, address(this), amountInMax);
        weth.approve(address(router), amountInMax);
        ISwapRouter.ExactOutputSingleParams memory params = ISwapRouter
            .ExactOutputSingleParams({
                tokenIn: WETH,
                tokenOut: DAI,
                fee: 3000,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountOut: amountOut,
                amountInMaximum: amountInMax,
                sqrtPriceLimitX96: 0
            });
        uint amountIn = router.exactOutputSingle(params);

        if (amountIn < amountInMax) {
            weth.approve(address(router), 0);
            weth.transfer(msg.sender, amountInMax - amountIn);
        }
    }
}
