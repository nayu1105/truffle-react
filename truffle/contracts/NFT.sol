// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.7;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Counters.sol"; //


// contract NFT is ERC721URIStorage, Ownable{
//     using Counters for Counters.Counter;
//     Counters.Counter private _tokenIds;
//     // 토큰 id 발행에 쓰이는 Counter
//     // current(counter)를 하면 uint256 이 나옴 => tokenId
//     // 이를 increment(counter) 하면서 tokenId 증가하면서 계속 발행해주면 됨.

//     constructor() public ERC721("NFT", "NFT"){

//     }

//     function tokenURI(uint256 tokenId)
//         public
//         view
//         override(ERC721, ERC721URIStorage)
//         returns (string memory)
//     {
//         // memory & storage
//         // Storage는 블록체인 상에 영구적으로 저장되며, 
//         // Memory는 임시적으로 저장되는 변수로 함수의 외부 호출이 일어날 때마다 초기화

//         // 비유하자면 Storage 는 하드디스크, Memory는 RAM에 저장하는 것.
//         return super.tokenURI(tokenId);
//     }

//     function mint()
//         public
//         onlyOwner
//         returns(uint256)    
//     {   
//         _tokenIds.increment();  
//         return newNFTId;
//     }

//     function _burn(uint256 tokenId)
//         internal 
//         override(ERC721, ERC721URIStorage)
//     {
//         super._burn(tokenId);
//     }

// }