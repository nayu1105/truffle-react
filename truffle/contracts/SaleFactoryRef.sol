// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.4;


// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// // import "./access/Ownable.sol";
// // import "./token/ERC20/ERC20.sol";
// // import "./token/ERC721/ERC721.sol";
// import "./O2Token.sol";
// import "./MARS_NFT.sol";

// contract SaleFactory is Ownable {

//     address public admin; // 관리자, 계약 배포자
//     address[] public sales; // 판매자
//     mapping(uint256=>address) saleContractAddress;  // 토큰id -> Salecontract address 맵핑
//     JAV_NFT public NFTcreatorContract;

//     event NewSale(
//         address indexed _saleContract,
//         address indexed _owner,
//         uint256 _workId
//     );

//     constructor(address _NFTcreatorAddress) {
//         admin = msg.sender;
//         NFTcreatorContract = JAV_NFT(_NFTcreatorAddress);
//     }

//     // 판매 등록
//     function createSale(
//         uint256 itemId, // 아마 NFT_ID
//         uint256 purchasePrice,  //즉구가
//         address currencyAddress,    //ERC-20 주소
//         address nftAddress  // NFT 계약 주소
//     ) public returns (address) {
//         require(msg.sender==NFTcreatorContract.ownerOf(itemId));    // NFT 오너만 판매 등록 가능
//         require(saleContractAddress[itemId] == address(0), "this token is already on sale.");
//         require(NFTcreatorContract.isApprovedForAll(msg.sender,currencyAddress));
//         address seller = msg.sender;    //해당 컨트랙트 호출자가 판매자
//         Sale instance = new Sale(admin, seller, itemId, purchasePrice, currencyAddress, nftAddress, address(this));
//         sales.push(address(instance));
//         saleContractAddress[itemId] = address(instance);
//         emit NewSale(address(instance), msg.sender, itemId);
//         return address(instance);
//     }

//     //생성된 모든 Sale 주소 반환
//     function allSales() public view returns (address[] memory) {
//         return sales;
//     }

//     function getSaleContractAddress(uint256 tokenId) public view returns (address) {
//         return saleContractAddress[tokenId];
//     }

//     function resetSaleContractAddress(uint256 tokenId) external {
//         require(msg.sender == getSaleContractAddress(tokenId));
//         saleContractAddress[tokenId] = address(0);
//     }
// }

// contract Sale {
//     // 생성자에 의해 정해지는 값
//     address public seller;  // 판매자
//     address public buyer;   // 구매자
//     address admin;  // 관리자
//     uint256 public purchasePrice;   // 즉구가
//     uint256 public tokenId; // 거래할 NFT tokenId
//     address public currencyAddress; // 거래시 사용할 ERC-20(JavToken)의 주소
//     address public nftAddress;  // nft creator 주소(NFT 계약 주소)
//     bool public ended;  // 판매 종료 여부

//     event Cancel(
//         uint256 tokenId
//     );
//     JavToken public JavTokenContract;
//     JAV_NFT public NFTcreatorContract;
//     SaleFactory public SaleFactoryContract;

//     event SaleEnded(address winner, uint256 amount);    // 최종 구매자 정보(판매 종료시, 구매자, 가격 event 발생)
//     // 최초 배포시 관리자, 구매자, 판매자 등 기록
//     constructor(
//         address _admin,
//         address _seller,
//         uint256 _tokenId,
//         uint256 _purchasePrice,
//         address _currencyAddress,
//         address _nftAddress,
//         address _saleFactoryAddress
//     ) {
//         require(_purchasePrice > 0); // 정말 필요한지 나중에 다시 확인해보자
//         tokenId = _tokenId;
//         purchasePrice = _purchasePrice;
//         seller = _seller;
//         admin = _admin;
//         currencyAddress = _currencyAddress;
//         nftAddress = _nftAddress;
//         ended = false;
//         JavTokenContract = JavToken(_currencyAddress);
//         NFTcreatorContract = JAV_NFT(_nftAddress);
//         SaleFactoryContract = SaleFactory(_saleFactoryAddress);     
//     }

//     // 구매
//     function purchase(uint256 purchase_amount, address _buyer) public {
//         require(seller != _buyer, "you are seller");
//         require(ended == false,"ended sale");
//         buyer = _buyer;
//         emit SaleEnded(buyer, purchase_amount);
//         _end();
//     }

//     // 판매 철회 함수
//     function cancelSales() public {
//         require(msg.sender == seller, "you are not seller");
//         _end();
//         emit Cancel(tokenId);
//     }
//     // 판매 정보
//     function getSaleInfo()
//         public
//         view
//         returns (
//             uint256,
//             uint256,
//             address,
//             address
//         )
//     {
//         return (
//             purchasePrice,
//             tokenId,
//             currencyAddress,
//             nftAddress
//         );
//     }
//     // 판매 종료
//     function _end() internal {
//         ended = true;
//         SaleFactoryContract.resetSaleContractAddress(tokenId);
//     }
//     // 잔액 조회
//     function _getCurrencyAmount() private view returns (uint256) {
//         return JavTokenContract.balanceOf(msg.sender);
//     }

//     function getcurrencyAddress() public view returns(address) {
//         return currencyAddress;
//     }

//     modifier onlySeller() {
//         require(msg.sender == seller, "Sale: You are not seller.");
//         _;
//     }
// }