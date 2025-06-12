import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const UniswapModules = buildModule("UniswapModules", (m) => {
  const uniswapV3SingleHopSwap = m.contract("UniswapV3SingleHopSwap");
  const uniswapV3MultipleHopSwap = m.contract("UniswapV3MultiHopSwap");

  return { uniswapV3SingleHopSwap, uniswapV3MultipleHopSwap };
});

export default UniswapModules;
