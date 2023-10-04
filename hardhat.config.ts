import "@typechain/hardhat"
import "@nomiclabs/hardhat-ethers"
import "@nomiclabs/hardhat-waffle"
import "@nomiclabs/hardhat-etherscan"
import "hardhat-deploy"

const PRIVATE_KEY = ""

const settings = {
    optimizer: {
        enabled: true,
        runs: 999999,
    },
}

module.exports = {
    networks: {
        bttc: {
            url: "https://pre-rpc.bt.io/",
            accounts: [PRIVATE_KEY],
        },
    },
    solidity: {
        settings: {
            evmVersion: "istanbul",
            outputSelection: {
                "*": {
                    "": ["ast"],
                    "*": [
                        "evm.bytecode.object",
                        "evm.deployedBytecode.object",
                        "abi",
                        "evm.bytecode.sourceMap",
                        "evm.deployedBytecode.sourceMap",
                        "metadata",
                    ],
                },
            },
        },
        compilers: [
            "0.8.10",
            "0.8.12",
            "0.8.17",
            "0.6.6",
            "0.5.16",
            "0.4.18",
        ].map((v) => {
            return {
                version: v,
                settings
            }
        }),
    },
}
