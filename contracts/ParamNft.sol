pragma ton-solidity = 0.58.1;
pragma AbiHeader expire;
pragma AbiHeader pubkey;
pragma AbiHeader time;

import "../everscale-tip4/contracts/TIP4_2/TIP4_2Nft.sol";
import "../everscale-tip4/contracts/TIP4_1/TIP4_1Nft.sol";

contract ParamNft is TIP4_1Nft, TIP4_2Nft {

    uint16 constant NOT_SUPPORTED = 200;

    address carNft;
    uint8 speed;
    uint8 acceleration;
    uint8 braking;
    uint8 control;

    constructor(
        address owner,
        address sendGasTo,
        uint128 remainOnNft,
        string json,
        address _carNft,
        address manager,
        uint8 _speed,
        uint8 _acceleration,
        uint8 _braking,
        uint8 _control
    ) 
    TIP4_1Nft(
        owner,
        sendGasTo,
        remainOnNft
    ) 
    TIP4_2Nft(json) 
    public {
        tvm.accept();
        emit NftCreated(_id, owner, manager, msg.sender);
        carNft = _carNft;
        speed = _speed;
        acceleration = _acceleration;
        braking = _braking;
        control = _control;
    }

    function loadParams(
        uint8 _speed,
        uint8 _acceleration,
        uint8 _braking,
        uint8 _control
    ) external onlyManager {
        tvm.accept();
        speed = _speed;
        acceleration = _acceleration;
        braking = _braking;
        control = _control;
    }

    function changeOwner(
        address newOwner, 
        address sendGasTo, 
        mapping(address => CallbackParams) callbacks
    ) public override onlyManager {
        newOwner;
        sendGasTo;
        callbacks;
        revert(NOT_SUPPORTED);
    }

    function getCarNft() external view responsible returns(address) {
        return{value: 0, flag: 64} carNft;
    }

    function getCarParams() external view responsible returns(uint8, uint8, uint8, uint8) {
        return{value: 0, flag: 64}(speed, acceleration, braking, control);
    }

}