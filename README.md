# Uniswap V3 Swap Contracts

This repository contains Solidity smart contracts that facilitate token swaps using Uniswap V3 Protocol. The contracts enable both single-hop and multi-hop swaps between WETH (Wrapped Ether), USDC, and DAI tokens.

## Overview

The project implements two main contracts:

1. `UniswapV3SingleHopSwap.sol`

   - Enables direct swaps between WETH and DAI
   - Supports both exact input and exact output swaps
   - Implements slippage protection

2. `UniswapV3MultipleHopSwap.sol`

   - Facilitates multi-hop swaps through WETH → USDC → DAI path
   - Supports both exact input and exact output swaps
   - Includes automatic refund mechanism for unused tokens

## Contract Addresses

The contracts interact with the following tokens on Ethereum mainnet:

- WETH: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2
- USDC: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
- DAI: 0x6B175474E89094C44Da98b954EedeAC495271d0F
- Uniswap V3 SwapRouter: 0xE592427A0AEce92De3Edee1F18E0157C05861564

## Features

### Single Hop Swaps

1. Exact Input Swap

   - Function: `swapExactInputSingleHop`
   - Swaps an exact amount of WETH for as much DAI as possible
   - Includes minimum output amount for slippage protection

2. Exact Output Swap

   - Function: `swapExactOutputSingleHop`
   - Swaps minimum required WETH for an exact amount of DAI
   - Automatically refunds unused WETH to the sender

### Multi Hop Swaps

1. Exact Input Multi-Hop Swap

   - Function: `swapExactInputMultiHop`
   - Swaps exact WETH through USDC to get maximum DAI
   - Path: WETH → USDC → DAI

2. Exact Output Multi-Hop Swap

   - Function: `swapExactOutputMultiHop`
   - Swaps minimum WETH through USDC for exact DAI
   - Path: WETH → USDC → DAI
   - Includes automatic refund mechanism

## Usage

Before using these contracts:

1. Ensure you have sufficient WETH balance
2. Approve the contract to spend your WETH tokens
3. Calculate appropriate slippage parameters:
   - amountOutMin for exact input swaps
   - amountInMax for exact output swaps

## Development

The project uses:

- Solidity version ^0.8.28
- Hardhat development environment
- TypeScript for testing and deployment scripts

### Project Structure

```
├── contracts/
│   ├── UniswapV3MultipleHopSwap.sol
│   ├── UniswapV3SingleHopSwap.sol
│   └── interfaces/
│       ├── IERC20.sol
│       ├── ISwapRouter.sol
│       └── IWETH.sol
├── test/
│   └── UniswapV3.ts
└── ignition/
    └── modules/
        └── UniswapModules.ts
```

## Security Considerations

1. All functions include deadline parameters to prevent stale transactions
2. Slippage protection is implemented for all swap functions
3. Contracts use SafeMath implicitly through Solidity ^0.8.28
4. Token approvals are precisely managed to minimize exposure

## License

This project is licensed under the MIT License.
