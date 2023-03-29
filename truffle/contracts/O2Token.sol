// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract O2Token is ERC20, Ownable{
    event createNFT (uint256 indexed _tokenId, address indexed _owner);
    event purchaseNFT (uint256 _tokenId);
    // constructor(string memory name, string memory symbol, uint8 decimal, address JAV_NFT_address) ERC20(name, symbol, decimal) {
    //     JAV_NFT_Contract = JAV_NFT(JAV_NFT_address);
    // }

    event mint_call(address indexed from, uint256 amount);
    //ERC20 contructor 에 필요한 param : (name, symbol)
    // name : 토큰 이름
    // symbol : 이름의 더 짧은 버전인 토큰의 기호

    constructor () ERC20("O2Token", "O2") {
        // decimals 는 토큰 소수점 자리
        // 소수점 둘째 자릿수로 설정해서 토큰 생성
    
        // ERC20의 deciamls는  _setupDecimals 함수를 통해 설정
        // _setupDecimals 는 생성자에서만 호출 가능
    }

    function decimals() override public pure returns (uint8) {
        return 2;
    }

    function mint(uint256 amount) public {
        emit mint_call(msg.sender, amount);
        _mint(msg.sender, amount);
    }

    function transfer(address from, address to, uint256 amount) public returns (bool) {
        _transfer(from, to, amount);
        return true;
    }
}