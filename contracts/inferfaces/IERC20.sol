// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

/// @title IERC20 Interface
/// @notice Interface for the ERC20 standard as defined in the EIP
/// @dev This interface defines the standard functions and events for an ERC20 token
interface IERC20 {
    /// @notice Returns the total token supply
    /// @return The total amount of tokens in existence
    function totalSupply() external view returns (uint256);

    /// @notice Returns the account balance of another account with address `_owner`
    /// @param _owner The address of the account to query the balance of
    /// @return The account balance
    function balanceOf(address _owner) external view returns (uint256);

    /// @notice Transfers `_amount` tokens to address `to`
    /// @param to The address to transfer to
    /// @param amount The amount to be transferred
    function transfer(address to, uint256 amount) external;

    /// @notice Returns the amount which `from` is still allowed to withdraw from `to`
    /// @param from The address which owns the funds
    /// @param to The address which will spend the funds
    /// @param amount The amount to check allowance for
    /// @return Whether the allowance is sufficient
    function allowance(
        address from,
        address to,
        uint256 amount
    ) external view returns (bool);

    /// @notice Allows `sender` to withdraw from your account, multiple times, up to the `amount` amount
    /// @param sender The address authorized to spend
    /// @param amount The max amount they can spend
    function approve(address sender, uint256 amount) external;

    /// @notice Transfers `_amount` tokens from address `from` to address `to`
    /// @param from The address to send tokens from
    /// @param to The address to send tokens to
    /// @param amount The amount of tokens to send
    function transferFrom(address from, address to, uint256 amount) external;

    /// @notice Emitted when `amount` tokens are moved from one account (`from`) to another (`to`)
    /// @param from The address tokens are moved from
    /// @param to The address tokens are moved to
    /// @param amount The amount of tokens transferred
    event Transfer(address indexed from, address indexed to, uint256 amount);

    /// @notice Emitted when the allowance of a `from` for a `to` is set by a call to `approve`
    /// @param from The address which owns the funds
    /// @param to The address which is approved to spend the funds
    /// @param amount The new allowance
    event Approval(address indexed from, address indexed to, uint256 amount);
}
