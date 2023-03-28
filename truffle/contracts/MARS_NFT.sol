// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract MARS_NFT is ERC721  {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId;

    // uint == uint256 
    constructor() public ERC721("MARS_NFT", "MARSNFT"){}

    uint32  dna;

    // color   , crop   , eye     , headgear , mouth
    // 1~2자리 , 3~4자리 , 5~6자리 , 7~8자리   , 9~10자리  
    // 두 자리씩 유전 코드
    // 00 은 none인 상태 01부터 유전자로 취급
    

    event mint_call(address indexed from, uint32 dna, uint256 tokenId);

    mapping(uint256 => string) tokenURIs;
    mapping (uint256 => uint32) marsDnas;
    

    // tokenIds 는 생성된 token 수 만큼 증가한다.
    // 현재까지 생성된 nft 수 리턴 (지워진 토큰 포함)
    function current() public view returns (uint256) {
        return _tokenId.current();
    }

    // nft의 유전 정보 조회
    function getNftDna(uint256 tokenId) public view returns (uint32){
        return marsDnas[tokenId];
    }
    
    // nft 생성(민팅)
    // 생성 시에는 crop만 내려받고 배경은 random
    function mint(string memory _tokenURI, uint32 crop, uint256 nonce) public {
        _tokenId.increment();
        tokenURIs[ _tokenId.current()] = _tokenURI; 

        _mint( msg.sender, _tokenId.current());
        uint256 color = (uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))) % 10 )+ 1;
        // 배경은 10가지 이고 0은 none 으로 쓰기로 했으니 나누기 11 
        marsDnas[ _tokenId.current()] = uint32(uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))) % 11 )* 100 + crop ;
        emit mint_call(msg.sender, marsDnas[_tokenId.current()], _tokenId.current());
    }

    function burn(uint256 tokenId) public {
        _burn(tokenId);
        delete marsDnas[tokenId];
    }

    function random(uint256 nonce) internal returns (uint) {
        uint randomnumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))) % 2;
        // 0, 1 랜덤으로 생성.
        // 외부에서 nonce를 받고 그 nonce로 랜덤 값 생성
        return randomnumber;
    }

    // nft 조합
    function combNFT(uint256 nft1TokenId, uint256 nft2TokenId, uint256 nonce) public {
        // burn된 token의 경우 ERC721에서 ownerOf 하면서 처리해줌
        require(msg.sender == ownerOf(nft1TokenId), "you are not NFT owner");
        require(msg.sender == ownerOf(nft2TokenId), "you are not NFT owner");

        _burn(nft1TokenId);
        _burn(nft2TokenId);
        // burn 하기 전에 nft1 과 nft2에서 각 유전정보 가지고 조합한 값을 빼놓아야함

        // mintNFT(msg.sender, 2, 1);

    }

}