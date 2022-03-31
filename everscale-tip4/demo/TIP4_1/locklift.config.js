// TVM_LINKER_LIB_PATH=$HOME/.everdev/solidity/stdlib_sol.tvm; export TVM_LINKER_LIB_PATH

module.exports = {
  compiler: {
    // Specify path to your TON-Solidity-Compiler
    path: '/root/.tondev/solidity/solc',
  },
  linker: {
    // Path to your TVM Linker
    path: '/root/.tondev/solidity/tvm_linker',
    // lib: '/root/.tondev/solidity/stdlib_sol.tvm',
  },
  networks: {
    // You can use TON labs graphql endpoints or local node
    local: {
      ton_client: {
        // See the TON client specification for all available options
        network: {
          server_address: 'http://188.227.35.77/',
        },
      },
      // This giver is default local-node giver
      giver: {
        address: '0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94',
        abi: { "ABI version": 1, "functions": [ { "name": "constructor", "inputs": [], "outputs": [] }, { "name": "sendGrams", "inputs": [ {"name":"dest","type":"address"}, {"name":"amount","type":"uint64"} ], "outputs": [] } ], "events": [], "data": [] },
        key: '',
      },
      // Use tonos-cli to generate your phrase
      // !!! Never commit it in your repos !!!
      keys: {
        phrase: 'nature invest lecture about level dune wool trophy vacant cave rotate vocal',
        amount: 20,
      }
    },
    devnet: {
      ton_client: {
        // See the TON client specification for all available options
        network: {
          server_address: 'https://net.ton.dev/'
        },
      },
      // This giver is default local-node giver
      giver: {
        address: '0:f7597aecd0ecd2a78f220469f73a18585ad10a3f00391eeee337514a8f0b351e',
        abi: { "ABI version": 1, "functions": [ { "name": "constructor", "inputs": [], "outputs": [] }, { "name": "sendGrams", "inputs": [ {"name":"dest","type":"address"}, {"name":"amount","type":"uint64"} ], "outputs": [] } ], "events": [], "data": [] },
        key: '327caeff7c4727d76d3b2a82410e12c699c174796a5c7dd024ca5bed865c980c',
      },
      // Use tonos-cli to generate your phrase
      // !!! Never commit it in your repos !!!
      keys: {
        phrase: 'nature invest lecture about level dune wool trophy vacant cave rotate vocal',
        amount: 20,
      }
    },
  },
};
