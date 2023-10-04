# Finch Protocol Contracts

## Theme
`DeFi` (can also be considered for the `Web3` category).

# TLDR
We are connecting Tron to the larger crypto ecosystem by providing secure cross-chain bridging and communication to and from Tron. Anyone can use Finch's dirty-easy API (see below) to quickly turn their regular smart contracts on Tron into super-charged cross-chain dApps. Our thesis is that this will make it easier to onboard users into Tron!


# Intro

Finch is a secure interoperability layer for Web3 which allows for the decentralized transfer of arbitrary data (messages and value) across blockchain networks regardless of whether they are EVM-compatible or not. This allows Finch to provide something that very few bridges have been able to provide (EVM <-> non-EVM as opposed to siloed EVM <-> EVM or non-EVM <-> non-EVM).

A network of independent validators is responsible for validating these cross-chain messages. Each validator upholds the blockchain infrastructure by running a node on Finch, which is used to sign all transactions passing through the network via Finch’s smart contracts across various blockchains. To ensure the security of the protocol, delegated staking and slashing mechanics are in place. These mechanics serve as an economic deterrent for validators against collusion.

But, Finch is not just an infrastructure platform. It acts as a framework that could potentially enable:
- Decentralized transfers of arbitrary data and assets

- Cross-chain interoperability of smart contracts

- Cross-chain swaps

- Interoperability and bridging of NFTs

... and help connect Tron to the rest of the crypto ecosystem (Ethereum, Cosmos, Solana; the possibilities are endless).


# Finch <-> Tron

While Finch is still in active development, we have built out the following products for this hackathon to showcase the endless possibilities it provides:
- cross-chain bridge
- cross-chain message passing
- cross-chain interoperability of smart contracts (call arbitrary contracts on any chain from any chain)


# Architecture & API

Finch employs a robust model that prioritizes security and speed when delivering cross-chain messages (data + value). We offer a _dirt simple_ API that allows developers to simply plug and play Finch into their existing applications without any hassle.

Here's how easy it is to send cross-chain messages with Finch [see detailed example](https://github.com/finch-protocol/contracts/blob/dev/src/mailbox/Mailbox.sol)

```solidity
...

function sendMessage(
    uint32 _destChainId,
    bytes32 _targetAddress,
    bytes calldata _message
) external payable {
    IFinch(finch).xsend{ value: msg.value }(
         _destChainId,
         _targetAddress,
         address(0),
         _message,
         ""
    );
}
...
```

Let's break it down...

```solidity

// This comprises Finch's public-facing endpoint
function xsend(
    uint32 _destChainId,       // the destination chain to send the message to
    bytes32 _destAddress,      // address of the contract to call on the destination chain
    address _refundAddress,    // excess native token is refunded to this address (TRX on Tron/BTT on BTTC)
    bytes calldata _payload,   // encoded payload to execute on `_destChainId` (if any)
    bytes calldata _callData   // extra params/configuration options
) external payable;
```

# Finch's Features

## [1. Faucet](https://finch-tron.vercel.app/faucet)

Get some test tokens (`$USDT` and `$USDC`) to use on the app, and test out the rest of Finch's offerings


## 2. [Cross-chain bridge (transfer assets from Tron to other chains)](https://finch-tron.vercel.app/bridge)

`Networks supported: Tron Shasta, Goerli, BTTC Testnet`

Seamlessly transfer assets from Tron to other chains and vice versa. Thanks to Finch's cross-chain message passing, this is possible even if the chains are not EVM-compatible. Oh, and most settlements are near-instant (`<1 min`)!


## 3. [Cross-chain message-passing](https://finch-tron.vercel.app/send-message)

`Networks supported: Tron Shasta, Goerli, BTTC Testnet`

Seamlessly send messages from Tron to other chains and vice versa. Thanks to Finch's unique architecture, this is possible even if the chains are not EVM-compatible. Settlements on Finch are near-instant (`<1 min`)!


# Judging Notes

Finch is in _heavy_ active development. We have built out the above-mentioned products for this hackathon to showcase the endless possibilities it provides, but we are not done yet. But until then, [enjoy Finch!](https://finch-tron.vercel.app/)