# everscale-tip4

# What is needed for development?

- Install [TON Solidity Compiler](https://github.com/tonlabs/TON-Solidity-Compiler.git)
- Install [TVM linker](https://github.com/tonlabs/TVM-linker/releases/tag/0.14.2)
- Install [nmp](https://www.npmjs.com/)
- Install  [TON locklift](https://github.com/broxus/ton-locklift)
- Install [tonos-cli](https://github.com/tonlabs/tonos-cli)

# Build demo

1. Get [testnet](https://net.ever.live/) coins
1. Deploy your [giver](https://github.com/broxus/ton-contracts/tree/master/contracts/giver) to testnet
1. Change [locklift.config.js](contracts/demo/NFT/locklift.config.js)
   1. update paths for ``compiler``, ``linker`` 
   1. Set ``giver`` address and keys
   1. generate key by ``tonos-cli`` for keys section
1. go to ``./contracts/demo/NFT``
   1. build ``locklift build --config locklift.config.js`` 
   1. deploy ``locklift run --config locklift.config.js --network local --script scripts/1-deploy-collection.js``
