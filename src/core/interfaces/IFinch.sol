// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.17;

interface IFinch {
    /// @notice Send a message to another chain
    /// @param _destChainId    destination chain id
    /// @param _destAddress    address on destination chain to send payload 
    ///                        (encoded as bytes32 to support runtimes other than EVM)
    /// @param _refundAddress  the address to refund any extra source chain gas
    /// @param _payload        arbitrary bytes to execute on `_destAddress`
    /// @param _callData       arbitrary bytes "settings" for an application implementation
    ///
    /// @dev who? anyone (EOA or contract) can call this function
    function xsend(
        uint32 _destChainId,
        bytes32 _destAddress, 
        address _refundAddress,
        bytes calldata _payload,
        bytes calldata _callData
    ) external payable;

    /// @notice Receive a message from another chain via a configured messaging client 
    ///         (or the default messaging client where not configured)
    /// @param _nonce           the inbound nonce of the message
    /// @param _srcChainId      the source chain id
    /// @param _destAddress     the destination address to transport the payload to
    ///
    /// @dev who? configured messaging client (or the default messaging client where not configured)
    function receivePayload(
        uint64 _nonce,
        uint32 _srcChainId,
        bytes32 _srcAddress,
        address _destAddress,
        bytes calldata _payload
    ) external;

    /// @notice Retry sending a message that failed in a `receivePayload`
    /// @param _srcChainId      the source chain id
    /// @param _srcAddress      the source address
    /// @param _payload         the payload to retry
    ///
    /// @dev who? anyone (EOA or contract) can call this function; invariants check for valid inputs
    function retryPayload(
        uint32 _srcChainId,
        bytes32 _srcAddress,
        bytes memory _payload
    ) external;

    /// @notice Get the chain id of the current chain
    function getChainId() external view returns (uint32);
}