pragma ton-solidity = 0.58.1;

interface INftChangeOwner {
    function onNftChangeOwner(uint256 id, address oldOwner, address oldManager, address newOwner,  address newManager, address collection, address sendGasTo, TvmCell payload) external;
}