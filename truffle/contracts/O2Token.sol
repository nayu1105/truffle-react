// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// // import "./JAV_NFT.sol";
// // import "./SaleFactory.sol";

// contract O2Token is ERC20, Ownable{
//     event createNFT (uint256 indexed _tokenId, address indexed _owner);
//     event purchaseNFT (uint256 _tokenId);
//     constructor(string memory name, string memory symbol, uint8 decimal, address JAV_NFT_address) ERC20(name, symbol, decimal) {
//         JAV_NFT_Contract = JAV_NFT(JAV_NFT_address);
//     }
    
//     function mint(uint256 amount) public {
//         _mint(_msgSender(), amount);
//     }

//     function JavPickup(string memory _tokenURI, uint[3] memory _gene, uint[4] memory _accessory) public returns(uint) {
//         super.transfer(address(JAV_NFT_Contract),100);
//         uint tokenId = JAV_NFT_Contract.pickup(_tokenURI, _gene, _accessory);
//         JAV_NFT_Contract.transferFrom(address(this),msg.sender,tokenId);
//         emit createNFT(tokenId, msg.sender);
//         return tokenId;
//     }

//     function transfer(address recipient, uint256 amount) public override returns (bool) {
//         super.transfer(recipient,amount);
//         return true;
//     }

//     function purchase(address saleAddress) public returns(uint){
//         Sale SaleContract = Sale(saleAddress);
//         require(SaleContract.getcurrencyAddress() == address(this),"bank essue");
//         uint price = SaleContract.purchasePrice();
//         uint tokenId = SaleContract.tokenId();
//         address seller = SaleContract.seller();
//         transfer(seller,price);
//         JAV_NFT_Contract.transferFrom(seller,msg.sender,tokenId);
//         JAV_NFT_Contract.pushSaleData(tokenId,price);
//         SaleContract.purchase(price,msg.sender);
//         emit purchaseNFT(tokenId);
//         return tokenId;
//     }
// }