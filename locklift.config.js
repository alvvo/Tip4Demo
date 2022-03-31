module.exports = {
  compiler: {
    // Specify path to your TON-Solidity-Compiler
    path: '/root/.tondev/solidity/solc',
  },
  linker: {
    // Path to your TVM Linker
    path: '/root/.tondev/solidity/tvm_linker',
  },
  networks: {
    // You can use TON labs graphql endpoints or local node
    local: {
      ton_client: {
        // See the TON client specification for all available options
        network: {
          server_address: '',
        },
      },
      // This giver is default local-node giver
      giver: {
        address: '',
        abi: {},
        key: '',
      },
      // Use tonos-cli to generate your phrase
      // !!! Never commit it in your repos !!!
      keys: {
        phrase: '',
        amount: 20,
      }
    },
  },
};
