// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

/**
 * @title ISwapRouter
 * @dev Interface for Uniswap V3 Swap Router.
 * Provides functions for swapping tokens with exact input or output amounts.
 */
interface ISwapRouter {
    /**
     * @dev Parameters for exactInputSingle function.
     * @param tokenIn The address of the input token.
     * @param tokenOut The address of the output token.
     * @param fee The fee tier of the pool, expressed in hundredths of a bip (1e-6).
     * @param recipient The address that will receive the output tokens.
     * @param deadline The time by which the transaction must be included to effect the swap.
     * @param amountIn The amount of input token to send.
     * @param amountOutMinimum The minimum amount of output token that must be received for the transaction not to revert.
     * @param sqrtPriceLimitX96 The price limit for the swap as a sqrt(price) Q64.96 value.
     */
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint deadline;
        uint amountIn;
        uint amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }

    /**
     * @dev Parameters for exactInput function.
     * @param path The encoded swap path.
     * @param recipient The address that will receive the output tokens.
     * @param deadline The time by which the transaction must be included to effect the swap.
     * @param amountIn The amount of input token to send.
     * @param amountOutMinimum The minimum amount of output token that must be received for the transaction not to revert.
     */
    struct ExactInputParams {
        bytes path;
        address recipient;
        uint deadline;
        uint amountIn;
        uint amountOutMinimum;
    }

    /**
     * @dev Parameters for exactOutputSingle function.
     * @param tokenIn The address of the input token.
     * @param tokenOut The address of the output token.
     * @param fee The fee tier of the pool, expressed in hundredths of a bip (1e-6).
     * @param recipient The address that will receive the output tokens.
     * @param deadline The time by which the transaction must be included to effect the swap.
     * @param amountOut The amount of output token to receive.
     * @param amountInMaximum The maximum amount of input token to spend.
     * @param sqrtPriceLimitX96 The price limit for the swap as a sqrt(price) Q64.96 value.
     */
    struct ExactOutputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint deadline;
        uint amountOut;
        uint amountInMaximum;
        uint160 sqrtPriceLimitX96;
    }

    /**
     * @dev Parameters for exactOutput function.
     * @param path The encoded swap path.
     * @param recipient The address that will receive the output tokens.
     * @param deadline The time by which the transaction must be included to effect the swap.
     * @param amountOut The amount of output token to receive.
     * @param amountInMaximum The maximum amount of input token to spend.
     */
    struct ExactOutputParams {
        bytes path;
        address recipient;
        uint deadline;
        uint amountOut;
        uint amountInMaximum;
    }

    /**
     * @notice Swaps a fixed amount of input token for as much as possible of output token, along a single pool.
     * @param params The parameters for the swap, encoded as ExactInputSingleParams.
     * @return amountOut The amount of output token received.
     */
    function exactInputSingle(
        ExactInputSingleParams calldata params
    ) external payable returns (uint amountOut);

    /**
     * @notice Swaps a fixed amount of input token for as much as possible of output token, along the specified path.
     * @param params The parameters for the swap, encoded as ExactInputParams.
     * @return amountOut The amount of output token received.
     */
    function exactInput(
        ExactInputParams calldata params
    ) external payable returns (uint amountOut);

    /**
     * @notice Swaps as little as possible of input token for a fixed amount of output token, along a single pool.
     * @param params The parameters for the swap, encoded as ExactOutputSingleParams.
     * @return amountIn The amount of input token spent.
     */
    function exactOutputSingle(
        ExactOutputSingleParams calldata params
    ) external payable returns (uint amountIn);

    /**
     * @notice Swaps as little as possible of input token for a fixed amount of output token, along the specified path.
     * @param params The parameters for the swap, encoded as ExactOutputParams.
     * @return amountIn The amount of input token spent.
     */
    function exactOutput(
        ExactOutputParams calldata params
    ) external payable returns (uint amountIn);
}
