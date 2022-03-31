// ItGold.io Contracts (v1.0.0) 

pragma ton-solidity = 0.58.1;

pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;


import '../TIP4_1/TIP4_1Nft.sol';
import './interfaces/ITIP4_2JSON_Metadata.sol';

/// @title One of the required contracts of an TIP4-1(Non-Fungible Token Standard) compliant technology.
/// For detect what interfaces a smart contract implements used TIP-6.1 standard. ...
/// ... Read more here (https://github.com/nftalliance/docs/blob/main/src/Standard/TIP-6/1.md)
abstract contract TIP4_2Nft is TIP4_1Nft, ITIP4_2JSON_Metadata {

    string _json;

    constructor(
        string json
    ) public {
        tvm.accept();

        _json = json;

        _supportedInterfaces[
            bytes4(tvm.functionId(ITIP4_2JSON_Metadata.getJson))
        ] = true;
    }
    
    /// See interfaces/ITIP4_2JSON_Metadata.sol
    function getJson() external view override responsible returns (string json) {
        return {value: 0, flag: 64, bounce: false} (_json);
    }

}