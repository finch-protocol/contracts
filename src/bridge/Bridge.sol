// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../core/interfaces/IFinch.sol";
import "../core/interfaces/IFinchReceiver.sol";

interface IToken {
    function mint(address receiver, uint256 amount) external;
}

// Simple Bridge. No checks.
// A Better implementation is being written and will be published soon.
contract Bridge is IFinchReceiver {
    address admin;
    address finch;

    constructor(address _finch) {
        require(_finch != address(0), "ZERO");

        admin = msg.sender;
        finch = _finch;
    }

    // Bridge tokens from current chain to destination chain
    function bridge(
        uint32 _destChainId, 
        bytes32 _targetAddress,
        address token,
        uint256 amount,
        bytes calldata _callData
    ) external payable { 
        if(token != address(0))
            ERC20(token).transferFrom(msg.sender, address(this), amount);
        ERC20(token).approve(finch, amount);
 
        // A simple API endpoint to transfer value + data to another chain
        IFinch(finch).xsend{ value: msg.value }(
            _destChainId,
            _targetAddress,
            token,
            _callData,
            ""
        ); 
    }

    function xreceive(
        uint64,
        uint32,
        bytes32,
        address _destAddress,
        bytes calldata _payload
    ) external {
        (address token, uint256 amount) = abi.decode(_payload, (address, uint256));

        IToken(token).mint(_destAddress, amount);
    }

    function changeOldFinchImpl(address _finch) external {
        require(msg.sender == admin, "Not admin");
        finch = _finch;
    }

    function encodeData(address _token, uint256 amount) external pure returns(bytes memory) {
        return abi.encode(_token, amount);
    }
}