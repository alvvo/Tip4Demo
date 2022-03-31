pragma ton-solidity = 0.58.1;
pragma AbiHeader expire;
pragma AbiHeader pubkey;
pragma AbiHeader time;

import "../everscale-tip4/contracts/TIP4_2/TIP4_2Collection.sol";
import "../everscale-tip4/contracts/TIP4_1/TIP4_1Collection.sol";
import "../everscale-tip4/contracts/access/OwnableExternal.sol";
import "./ParamNft.sol";

contract Collection is TIP4_1Collection, TIP4_2Collection, OwnableExternal {

    uint256 public mintedSupply;

    constructor(uint256 ownerPubkey, TvmCell codeNft, string json) 
        OwnableExternal(ownerPubkey) 
        TIP4_1Collection(codeNft) 
        TIP4_2Collection(json)
    public {
        tvm.accept();
    }

    function mint(
        address owner,
        address sendGasTo,
        uint128 remainOnNft,
        string json,
        address carNft,
        address manager,
        uint8 speed,
        uint8 acceleration,
        uint8 braking,
        uint8 control
    ) 
        public
        onlyOwner
        returns(address paramsAddr)
    {
        require(address(this).balance >= 1.1 ton, 102);
        tvm.accept();
        TvmCell codeData = _buildNftCode(address(this));
        TvmCell stateData = _buildNftState(codeData, mintedSupply);
        paramsAddr = new ParamNft{
            stateInit: stateData,
            value: 1.1 ton
        }(
            owner,
            sendGasTo,
            remainOnNft,
            json,
            carNft,
            manager,
            speed,
            acceleration,
            braking,
            control
        );

        emit NftCreated(
            mintedSupply, 
            paramsAddr,
            address(this),
            manager, 
            address(this)
        );

        mintedSupply += 1;
    }

    function _buildNftState(
        TvmCell code,
        uint256 id
    ) internal override(TIP4_1Collection, TIP4_2Collection) pure returns (TvmCell) {
        return tvm.buildStateInit({
            contr: ParamNft,
            varInit: {_id: id},
            code: code
        });
    }

}