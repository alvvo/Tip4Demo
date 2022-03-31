pragma ton-solidity = 0.58.1;

pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;


import '../TIP4_1/TIP4_1Collection.sol';
import '../access/OwnableExternal.sol';
import './interfaces/ITIP4_3Collection.sol';
import './TIP4_3Nft.sol';
import './Index.sol';
import './IndexBasis.sol';


abstract contract TIP4_3Collection is TIP4_1Collection, ITIP4_3Collection, OwnableExternal {
    
    TvmCell _codeIndex;
    TvmCell _codeIndexBasis;

    /// @dev пересчитать значения
    uint128 _indexDeployValue = 0.4 ton;
    uint128 _indexDestroyValue = 0.1 ton;
    uint128 _deployIndexBasisValue = 0.4 ton;

    /// _remainOnNft - the number of crystals that will remain after the entire mint 
    /// process is completed on the Nft contract
    // uint128 _remainOnNft = 0.3 ton;

    constructor(
        TvmCell codeIndex,
        TvmCell codeIndexBasis,
        uint256 ownerPubkey
    ) OwnableExternal(
        ownerPubkey
    ) public {
        TvmCell empty;
        require(codeIndex != empty, CollectionErrors.value_is_empty);
        tvm.accept();

        _codeIndex = codeIndex;
        _codeIndexBasis = codeIndexBasis;

        _supportedInterfaces[
            bytes4(tvm.functionId(ITIP4_3Collection.indexBasisCode)) ^
            bytes4(tvm.functionId(ITIP4_3Collection.indexBasisCodeHash)) ^
            bytes4(tvm.functionId(ITIP4_3Collection.indexCode)) ^
            bytes4(tvm.functionId(ITIP4_3Collection.indexCodeHash)) ^
            bytes4(tvm.functionId(ITIP4_3Collection.resolveIndexBasis))
        ] = true;

    }

    function deployIndexBasis() external view responsible onlyOwner returns (address indexBasis) {
        TvmCell empty;
        require(_codeIndexBasis != empty, CollectionErrors.value_is_empty);
        require(address(this).balance > _deployIndexBasisValue);

        TvmCell code = _buildIndexBasisCode();
        TvmCell state = _buildIndexBasisState(code, address(this));
        indexBasis = new IndexBasis{stateInit: state, value: _deployIndexBasisValue}();
        return {value: 0, flag: 64} (indexBasis);
    }

    function setIndexBasisCode(TvmCell codeIndexBasis) external virtual onlyOwner {
        _codeIndexBasis = codeIndexBasis;
    }

    function indexBasisCode() external view override responsible returns (TvmCell code) {
        return {value: 0, flag: 64} (_codeIndexBasis);
    }   

    function indexBasisCodeHash() external view override responsible returns (uint256 hash) {
        return {value: 0, flag: 64} tvm.hash(_buildIndexBasisCode());
    }

    function resolveIndexBasis() external view override responsible returns (address indexBasis) {
        TvmCell code = _buildIndexBasisCode();
        TvmCell state = _buildIndexBasisState(code, address(this));
        uint256 hashState = tvm.hash(state);
        indexBasis = address.makeAddrStd(0, hashState);
        return {value: 0, flag: 64} indexBasis;
    }

    function _buildIndexBasisCode() internal virtual view returns (TvmCell) {
        string stamp = "nft";
        TvmBuilder salt;
        salt.store(stamp);
        return tvm.setCodeSalt(_codeIndexBasis, salt.toCell());
    }

    function _buildIndexBasisState(
        TvmCell code,
        address collection
    ) internal virtual pure returns (TvmCell) {
        return tvm.buildStateInit({
            contr: IndexBasis,
            varInit: {_collection: collection},
            code: code
        });
    }

    function indexCode() external view override responsible returns (TvmCell code) {
        return {value: 0, flag: 64} (_codeIndex);
    }

    function indexCodeHash() external view override responsible returns (uint256 hash) {
        return {value: 0, flag: 64} tvm.hash(_codeIndex);
    }

    function _buildIndexCode(
        address collection,
        address owner
    ) internal virtual view returns (TvmCell) {
        TvmBuilder salt;
        salt.store(collection);
        salt.store(owner);
        return tvm.setCodeSalt(_codeIndex, salt.toCell());
    }

    function _buildIndexState(
        TvmCell code,
        address nft
    ) internal virtual pure returns (TvmCell) {
        return tvm.buildStateInit({
            contr: Index,
            varInit: {_nft: nft},
            code: code
        });
    }

    function _buildNftState(
        TvmCell code,
        uint256 id
    ) internal virtual override pure returns (TvmCell) {
        return tvm.buildStateInit({
            contr: TIP4_3Nft,
            varInit: {_id: id},
            code: code
        });
    }

}