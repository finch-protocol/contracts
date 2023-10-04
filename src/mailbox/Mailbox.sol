// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../core/interfaces/IFinch.sol";
import "../core/interfaces/IFinchReceiver.sol";

// Mailbox
contract Mailbox is IFinchReceiver {
    address admin;
    address finch;

    bytes latestMessage;

    constructor(address _finch) {
        require(_finch != address(0), "ZERO");

        admin = msg.sender;
        finch = _finch;
    }


    // Send message
    function sendMessage(
        uint32 _destChainId,
        bytes32 _targetAddress,
        bytes calldata _message
    ) external payable {
        // A simple API endpoint to transfer data to another chain
        IFinch(finch).xsend{ value: msg.value }(
            _destChainId,
            _targetAddress,
            address(0),
            _message,
            ""
        );
    }

    function xreceive(
        uint64,
        uint32,
        bytes32,
        address,
        bytes calldata _payload
    ) external {
        latestMessage = abi.decode(_payload, string);
    }

    function changeOldFinchImpl(address _finch) external {
        require(msg.sender == admin, "Not admin");
        finch = _finch;
    }
}