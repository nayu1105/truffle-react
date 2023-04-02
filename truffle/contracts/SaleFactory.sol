// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Sale.sol";


contract SaleFactory is Ownable{

    address private _O2TokenAddress;

    address private _MarsTokenAddress;
    
    // address private TokenAddress;
    // // 지금은 하나지만 나중에 작물별로 ContractAdress 만들어지면 수정해야함
    // // ex ) WheatTokenAddress, CornTokenAddress ... ;

    using Counters for Counters.Counter;
    Counters.Counter private _saleId;


    mapping(uint256 => address) private _saleAddr;
    mapping(uint256 => uint256) private _currentMarsSaleId; // token 종류 마다 만들기

    constructor( 
        address o2TokenAddress,
        address marsTokenAddress){
        _O2TokenAddress = o2TokenAddress;
        _MarsTokenAddress = marsTokenAddress;
    }

    // _saleId 는 생성된 sale과 관련된 자료만큼 증가한다.
    // 현재까지 생성된 nft 수 리턴 (지워진 토큰 포함)
    function current() public view returns (uint256) {
        return _saleId.current();
    }

    // creatSale
    // 판매등록 함수
    // 파라미터 : 어떤작물인지(tokenTypeAddress), 토큰아이디(tokenId), 판매가격(price)
 
    function createSale(
        address contractAddress,
        uint256 tokenId,
        address seller,
        uint256 price        
    ) public {
        if(contractAddress == _MarsTokenAddress){
            _saleId.increment();        
            Sale newSale = new Sale(tokenId, seller, price, _O2TokenAddress, _MarsTokenAddress);
            
            MARS_NFT(_MarsTokenAddress).approve(address(newSale), tokenId);

            _saleAddr[_saleId.current()] = address(newSale);
            _currentMarsSaleId[tokenId] = _saleId.current();
        }
    }

    function cancel(
        address contractAddress,
        uint256 tokenId
    ) public {
        if(contractAddress == _MarsTokenAddress){
            require(_currentMarsSaleId[tokenId]>0, "This Sale does not exist");
            address saleAddr = _saleAddr[_currentMarsSaleId[tokenId]];
            Sale sale = Sale(saleAddr);
            sale.cancel();
            _currentMarsSaleId[tokenId] = 0;
        }
    }

    function buy(
        address contractAddress,
        uint256 tokenId,
        address buyer
    ) public {
        if(contractAddress == _MarsTokenAddress){
            require(_currentMarsSaleId[tokenId]>0, "This deal does not exist");
            address saleAddr = _saleAddr[_currentMarsSaleId[tokenId]];
            Sale sale = Sale(saleAddr);
            require(sale.getIsSale(),"This deal is not for Sale");
            
            sale.buy(buyer);
        }
    }


    // SaleFactory에 등록할 내용 함수
    // 1. 판매 등록 기록
    // 2. 판매 취소 기록
    // 3. 구매 등록 기록

}