// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {IERC20} from "./interfaces/IERC20.sol";
import {IWETH} from "./interfaces/IWETH.sol";

import {ISwapRouter} from "./interfaces/ISwapRouter.sol";

/// @title UniswapV3MultiHopSwap
/// @notice Enables multi-hop swaps on Uniswap V3 using WETH, USDC, and DAI
/// @dev Uses Uniswap V3 SwapRouter for multi-hop swaps between WETH, USDC, and DAI
/// @author 0xose
contract UniswapV3MultiHopSwap {
    ISwapRouter private constant router =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    IWETH private constant weth = IWETH(WETH);
    IERC20 private constant dai = IERC20(DAI);

    /// @notice Swaps an exact amount of WETH for as much DAI as possible via USDC
    /// @dev Transfers WETH from the sender, approves the router, and performs a multi-hop swap (WETH -> USDC -> DAI)
    /// @param amountIn The exact amount of WETH to swap
    /// @param amountOutMin The minimum amount of DAI to receive for the transaction to succeed
    function swapExactInputMultiHop(uint amountIn, uint amountOutMin) external {
        weth.transferFrom(msg.sender, address(this), amountIn);
        weth.approve(address(router), amountIn);

        bytes memory path = abi.encodePacked(
            WETH,
            uint24(3000),
            USDC,
            uint24(100),
            DAI
        );

        ISwapRouter.ExactInputParams memory params = ISwapRouter
            .ExactInputParams({
                path: path,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: amountOutMin
            });

        router.exactInput(params);
    }

    /// @notice Swaps as little WETH as possible to receive an exact amount of DAI via USDC
    /// @dev Transfers up to amountInMax WETH from the sender, approves the router, and performs a multi-hop swap (WETH -> USDC -> DAI)
    ///      Refunds any unused WETH to the sender
    /// @param amountOut The exact amount of DAI to receive
    /// @param amountInMax The maximum amount of WETH to spend
    function swapExactOutputMultiHop(
        uint amountOut,
        uint amountInMax
    ) external {
        weth.transferFrom(msg.sender, address(this), amountInMax);
        weth.approve(address(router), amountInMax);

        bytes memory path = abi.encodePacked(
            DAI,
            uint24(100),
            USDC,
            uint24(3000),
            WETH
        );

        ISwapRouter.ExactOutputParams memory params = ISwapRouter
            .ExactOutputParams({
                path: path,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountOut: amountOut,
                amountInMaximum: amountInMax
            });

        uint amountIn = router.exactOutput(params);

        if (amountIn < amountInMax) {
            weth.approve(address(router), 0);
            weth.transfer(msg.sender, amountInMax - amountIn);
        }
    }
}
