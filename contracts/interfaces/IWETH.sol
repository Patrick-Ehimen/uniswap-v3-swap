// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

/**
 * @title IWETH
 * @dev Interface for Wrapped Ether (WETH) token.
 * Provides standard ERC20 functions along with deposit and withdraw for wrapping/unwrapping ETH.
 */

interface IWETH {
    /**
     * @notice Deposit ETH and mint WETH tokens.
     */
    function deposit() external payable;

    /**
     * @notice Withdraw ETH by burning WETH tokens.
     */
    function withdraw(uint) external;

    /**
     * @notice Returns the total supply of WETH tokens.
     * @return The total supply.
     */
    function totalSupply() external view returns (uint);

    /**
     * @notice Returns the WETH balance of a specific account.
     * @param account The address to query the balance of.
     * @return The balance of the account.
     */
    function balanceOf(address account) external view returns (uint);

    /**
     * @notice Transfers WETH tokens to a specified address.
     * @param recipient The address to transfer to.
     * @param amount The amount to transfer.
     * @return True if the transfer was successful.
     */
    function transfer(address recipient, uint amount) external returns (bool);

    /**
     * @notice Returns the remaining number of tokens that spender is allowed to spend on behalf of owner.
     * @param owner The address which owns the funds.
     * @param spender The address which will spend the funds.
     * @return The remaining allowance.
     */
    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    /**
     * @notice Approves the passed address to spend the specified amount of tokens on behalf of msg.sender.
     * @param spender The address which will spend the funds.
     * @param amount The amount of tokens to be spent.
     * @return True if the approval was successful.
     */
    function approve(address spender, uint amount) external returns (bool);

    /**
     * @notice Transfers tokens from one address to another using allowance mechanism.
     * @param sender The address which you want to send tokens from.
     * @param recipient The address which you want to transfer to.
     * @param amount The amount of tokens to be transferred.
     * @return True if the transfer was successful.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    /**
     * @dev Emitted when tokens are transferred, including zero value transfers.
     * @param from The address tokens are transferred from.
     * @param to The address tokens are transferred to.
     * @param value The amount of tokens transferred.
     */
    event Transfer(address indexed from, address indexed to, uint value);

    /**
     * @dev Emitted when the allowance of a spender for an owner is set by a call to approve.
     * @param owner The address which owns the funds.
     * @param spender The address which will spend the funds.
     * @param value The new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint value);
}
