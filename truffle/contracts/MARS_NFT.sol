// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MARS_NFT is ERC721URIStorage, Ownable{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId;
    // uint256 
    constructor() public ERC721("MARS_NFT", "MARSNFT"){}

    struct detail{
        uint[5] dna; 
        // color, crop, eye, headgear, mouth;
    }

    event createNFT (uint256 indexed _tokenId, address indexed _owner);

    mapping (uint256 => detail) marsData;
    

    // tokenIds 는 생성된 token 수 만큼 증가한다.
    // 현재까지 생성된 nft 수 리턴 (지워진 토큰 포함)
    function current() public view returns (uint256) {
        return _tokenIds;
    }

    // nft의 유전 정보 조회
    function getNftDna(uint256 tokenId) public view returns (uint[5] memory){
        return marsData[tokenId].dna;
    }
    
    // nft 생성(민팅)
    function mintNFT(address to, uint[5] dna) public onlyOwner {
        _tokenIds.increment();

        // to == msg.sender
        _mint(to, _tokenIds);
        marsData[_tokenId].dna = dna;
        emit createNFT(_tokenId, to);
    }

    function burn(uint256 tokenId) internal override{
        super.burn(tokenId);
        delete marsData[tokenId];
    }

    function random(uint256 nonce) internal returns (uint) {
        uint randomnumber = uint(keccak256(now, msg.sender, nonce)) % 2;
        // 0, 1 랜덤으로 생성.
        // 외부에서 nonce를 받고 그 nonce로 랜덤 값 생성
        return randomnumber;
    }

    // nft 조합
    function combNFT(uint256 nft1, uint256 nft2, uint256 nonce){
        // burn된 token의 경우 ERC721에서 ownerOf 하면서 처리해줌
        require(msg.sender == ownerOf(nft1), "you are not NFT owner");
        require(msg.sender == ownerOf(nft2), "you are not NFT owner");

        uint256[5] _dna = [2,1,1,2,2];
        
        if(random(nonce)==1){
            
        }// 작성 중...

        _burn(nft1);
        _burn(nft2);
        // burn 하기 전에 nft1 과 nft2에서 각 유전정보 가지고 조합한 값을 빼놓아야함

        mintNFT(msg.sender, _dna);





    }

}