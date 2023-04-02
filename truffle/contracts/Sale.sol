// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./O2Token.sol";
import "./MARS_NFT.sol";


contract Sale is Ownable {

    O2Token private _O2TokenContract;
    
    MARS_NFT private _MarsTokenContract;
    // nft 종류

    uint256 private _tokenId;
    // nft address 

    address private _seller;
    // 판매자 address

    address private _buyer;
    // 구매자 address

    uint256 private _price;
    // 가격

    bool private _isSale  = false;
    // 판매 중인지 끝났는지 

    constructor( 
        uint256 tokenId,
        address seller,
        uint256 price,        
        address o2TokenAddress,
        address marsTokenAddress
        ){            
        _O2TokenContract = O2Token(o2TokenAddress);
        _MarsTokenContract = MARS_NFT(marsTokenAddress);
        _tokenId = tokenId;
        _seller = seller;
        _price = price;
        _isSale = false;
    }
    
    // 거래 관련 함수
    // 1. buyNow
    // 2. cancel


    // 거래 활성화/비활성화
    function setIsSale(bool active) public {
        _isSale = active;
    }

    function getIsSale() public returns (bool){
        return _isSale;
    }

    // 구매 

    function buy(address buyer) public { 
        _MarsTokenContract.safeTransferFrom(_seller, buyer, _tokenId);
        _O2TokenContract.transfer(_seller, buyer, _price);

        _buyer = buyer;
        setIsSale(false);
        // 거래 비활성화
    }


    function cancel() public {
        setIsSale(false);
    }
    

}