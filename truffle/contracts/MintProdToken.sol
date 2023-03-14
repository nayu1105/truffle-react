// // SPDX-License-Identifier: MIT

// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// contract MintProdToken is ERC721Enumerable {
//     constructor() ERC721("RKSProducts", "HAS") {}

//     struct ProdTokenData {
//         uint256 prodTokenId;
//         string serialNo;
//         string productType;
//         address lastOwner;
//         uint256 lastPrice;
//         uint256 price;
//         uint256 repairedCount;
//     }

//     mapping(uint256 => string) serialNo;
//     mapping(uint256 => string) productType;
//     mapping(uint256 => address) lastOwner;
//     mapping(uint256 => uint256) lastPrice;
//     mapping(uint256 => uint256) price;
//     mapping(uint256 => uint256) repairedCount;

//     function mintProdToken(string memory _serialNo, string memory _productType, uint256 _price) public {
//         uint256 prodTokenId = totalSupply() + 1;

//         serialNo[prodTokenId] = _serialNo;
//         productType[prodTokenId] = _productType;
//         lastOwner[prodTokenId] = msg.sender;
//         lastPrice[prodTokenId] = _price;
//         price[prodTokenId] = _price;
//         repairedCount[prodTokenId] = 0; 

//         _mint(msg.sender, prodTokenId);
//     }

//     function getProdTokens(address _prodTokenOwner) view public returns (ProdTokenData[] memory) {
//         uint256 length = balanceOf(_prodTokenOwner);

//         require(length != 0, "No Purchased Item");

//         ProdTokenData[] memory prodTokenData = new ProdTokenData[](length);

//         for(uint i=0; i<length; i++) {
//             uint256 prodTokenId = tokenOfOwnerByIndex(_prodTokenOwner, i);
//             string memory _serialNo = serialNo[prodTokenId];
//             string memory _productType = productType[prodTokenId];
//             address _lastOnwer = lastOwner[prodTokenId];
//             uint256 _lastPrice = lastPrice[prodTokenId];
//             uint256 _price = price[prodTokenId];
//             uint256 _repairedCount = repairedCount[prodTokenId];

//             prodTokenData[i] = ProdTokenData(prodTokenId, _serialNo, _productType, _lastOnwer, _lastPrice, _price, _repairedCount);
//         }

//         return prodTokenData;
//     }
// }