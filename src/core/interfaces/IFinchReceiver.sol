// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.17;

interface IFinchReceiver {
    function xreceive(
        uint64 _nonce,
        uint32 _srcChainId,
        bytes32 _srcAddress,
        address _destAddress,
        bytes calldata _payload
    ) external;
}