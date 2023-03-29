import { useEffect, useState } from "react";
import Web3 from "web3";
import O2Token from "./contracts/O2Token.json";
import MARSNFT from "./contracts/MARS_NFT.json";
import SALE_FACTORY from "./contracts/SaleFactory.json";

// const SERVER_ACCOUNT = "0xf773bf0A6Fd046e1fF3Ca023E98897d8624A2F16";

const MARS_CONTRACT_ADDRESS = "0xA74810FCD09c968952BaE8a4070cDd71C14870e4";
const O2_CONTRACT_ADDRESS = "0x4033910d6e54D2c8bc8D9A13bB58D0379E2b3886";
const SALE_FACTORY_ADDRESS = "0xE9948BB2290Bfe52F95de0923269939114eaE1F3";

function App() {
  const [account, SetAccount] = useState();
  const web3 = new Web3(window.ethereum);
  const getRequestAccounts = async () => {
    const accounts = await window.ethereum.request({
      // 연결이 되어있다면 메타마스크가 갖고 있는 계정들 중 사용하고 있는 계정 가져오기.
      // 연결이 안되어있다면 메타마스크 내의 계정들과 연결 요청
      method: "eth_requestAccounts",
    });
    return accounts[0];
  };

  const init = async () => {
    // const targetChainId = 1337; // ganache default chainId : 1337, hex : 0x539
    // try {
    //   await window.ethereum.request({
    //     method: "wallet_switchEthereumChain",
    //     params: [{ chainId: web3.utils.toHex(targetChainId) }],
    //   });
    //   console.log("wallet_switchEthereumChain - call");
    //   console.log(await getRequestAccounts());
    //   return await getRequestAccounts(); // 계정가지고 오기
    // } catch (switchError) {
    //   // This error code indicates that the chain has not been added to MetaMask.
    //   if (switchError.console === 4902) {
    //     try {
    //       await window.ethereum.request({
    //         method: "wallet_addEthereumChain",
    //         params: [
    //           {
    //             chainId: web3.utils.toHex(targetChainId),
    //             chainName: "ganache",
    //             rpcUrls: ["http://127.0.0.1:8545"],
    //             nativeCurrency: {
    //               name: "Ethereum",
    //               symbol: "ETH",
    //               decimals: 18,
    //             },
    //           },
    //         ],
    //       });
    //       console.log("wallet_addEthereumChain - call");
    //     } catch (addError) {
    //       console.log(addError);
    //     }
    //   }
    // }
    const targetChainId = 1337;
    try {
      await window.ethereum.request({
        method: "wallet_switchEthereumChain",
        params: [{ chainId: web3.utils.toHex(targetChainId) }],
      });
      console.log("wallet_switchEthereumChain - call");
      console.log(await getRequestAccounts());
      return await getRequestAccounts();
    } catch (error) {
      const code = error.code;
      const str = `${code}`;
      return str;
    }
  };

  const load = async () => {
    // // const balance = await web3.eth.getBalance(account);
    // // console.log(balance);
    // if (!(await init())) {
    //   // window.open("https://metamask.io/download/");
    //   // 메타마스크 설치 페이지로 이동
    // }
    // // metamask 로그인 하고 우리 네트워크 (현재는 localhost://8545 에 연결)
    // SetAccount(await init());
    const result = await init();
    if (result === "4902") {
      const targetChainId = 1337;
      try {
        await window.ethereum.request({
          method: "wallet_addEthereumChain",
          params: [
            {
              chainId: web3.utils.toHex(targetChainId),
              chainName: "ganache",
              rpcUrls: ["http://127.0.0.1:8545"],
              nativeCurrency: {
                name: "Ethereum",
                symbol: "ETH",
                decimals: 18,
              },
            },
          ],
        });
        console.log("wallet_addEthereumChain - call");
      } catch (addError) {
        console.log(addError);
      }
    } else if (result === "-32002") {
      alert("메타마스크가 켜져있는지 확인해주세요.");
    } else if (result === "undefined") {
      window.open("https://metamask.io/download/");
    } else {
      SetAccount(result);
    }
  };

  const buyO2 = async () => {
    const contractAddress = O2_CONTRACT_ADDRESS;
    const contract = new web3.eth.Contract(O2Token.abi, contractAddress);
    console.log(contract);
    try {
      await contract.methods.mint(10000).send({
        from: account,
        value: "500000000000",
      });
    } catch (error) {
      console.log(error);
    }
  };

  const mintMarsNFT = async () => {
    const contract = new web3.eth.Contract(MARSNFT.abi, MARS_CONTRACT_ADDRESS);
    // url
    await contract.methods.mint(imageUrl, corp, nonce).send({
      from: account,
    });
    getCntToken();
  };

  const getNftsData = async () => {
    const contract = new web3.eth.Contract(MARSNFT.abi, MARS_CONTRACT_ADDRESS);
    // url
    console.log(await contract.methods.getNftDna(tokenId).call());
  };

  const [tokenId, setTokenId] = useState();

  const changeTokenId = (e) => {
    setTokenId(e.target.value);
    console.log(e.target.value);
  };

  const [imageUrl, setImgaeUrl] = useState();

  const changeImageUrl = (e) => {
    setImgaeUrl(e.target.value);
  };

  const [corp, setCrop] = useState();

  const changeCrop = (e) => {
    setCrop(e.target.value);
  };

  const [nonce, setNonce] = useState();

  const changeNonce = (e) => {
    setNonce(e.target.value);
  };

  const [cntToken, setCntToken] = useState();

  const getCntToken = async () => {
    const contract = new web3.eth.Contract(MARSNFT.abi, MARS_CONTRACT_ADDRESS);
    // url
    setCntToken(await contract.methods.current().call());
  };

  const [nft1, setNft1] = useState();
  const [nft2, setNft2] = useState();

  const changeNft1 = (e) => {
    setNft1(e.target.value);
  };

  const changeNft2 = (e) => {
    setNft2(e.target.value);
  };

  const combMarsNFT = async () => {
    const contract = new web3.eth.Contract(MARSNFT.abi, MARS_CONTRACT_ADDRESS);
    // url
    await contract.methods.combNFT(nft1, nft2, nonce).send({ from: account });
  };

  const getNftDetail = async () => {
    const contract = new web3.eth.Contract(MARSNFT.abi, MARS_CONTRACT_ADDRESS);
    setDetailNftOwner(await contract.methods.owner(saleNftId).call());
  };

  const changeGetMarsNft = (e) => {
    setDetailNft(e.target.value);
  };

  const [saleNftId, setDetailNft] = useState();
  const [detialNftOwner, setDetailNftOwner] = useState();

  const createSale = async () => {
    const contract = new web3.eth.Contract(
      SALE_FACTORY.abi,
      SALE_FACTORY_ADDRESS
    );
    await contract.methods
      .createSale(MARS_CONTRACT_ADDRESS, saleNftId, detialNftOwner, 3)
      .send({ from: account });
  };

  const cancelSale = async () => {
    const contract = new web3.eth.Contract(
      SALE_FACTORY.abi,
      SALE_FACTORY_ADDRESS
    );
    await contract.methods
      .cancel(MARS_CONTRACT_ADDRESS, saleNftId)
      .send({ from: account });
  };

  const buySale = async () => {
    const contract = new web3.eth.Contract(
      SALE_FACTORY.abi,
      SALE_FACTORY_ADDRESS
    );
    await contract.methods
      .buy(MARS_CONTRACT_ADDRESS, saleNftId, buyer)
      .send({ from: account });
  };

  const changeBuyerAddress = (e) => {
    setBuyer(e.target.value);
  };

  const [buyer, setBuyer] = useState();

  useEffect(() => {
    getCntToken();
  }, [account]);

  return (
    <div style={{ fontSize: "20px" }}>
      <div>Your account is : {account}</div>
      <div>
        <button onClick={load}>로그인</button>{" "}
        <button type="submit">회원가입</button>{" "}
        <button onClick={buyO2}>O2 구매</button>
      </div>
      <hr />
      <div>
        <p>현재 발급된 MARST NFT 갯수 : {cntToken}</p>
        <p>MARS NFT 발급</p>
        <button onClick={mintMarsNFT}>MARS NFT 발급</button>
        <div>
          image_url :{" "}
          <input
            type="text"
            name="imtUrl "
            id="imtUrl"
            onChange={changeImageUrl}
          />
          <br />
          corp 종류 :{" "}
          <input
            type="text"
            name="cropType"
            id="cropType"
            onChange={changeCrop}
          />
          <br />
          nonce 값 :{" "}
          <input type="text" name="nonce" id="nonce" onChange={changeNonce} />
          <br />
        </div>
        nft tokenId 값 :{" "}
        <input
          type="text"
          name="tokenId"
          id="tokenId"
          onChange={changeTokenId}
        />
        <button onClick={getNftsData}>Get MARS DNA</button>{" "}
      </div>
      <hr />
      <div>
        <p>MARS NFT 조합</p>
        <span>NFT 1 tokenId </span>
        <input
          type="text"
          name="nft_address"
          id="nft_address"
          onChange={changeNft1}
        />{" "}
        <br />
        <span>NFT 2 tokenId </span>
        <input
          type="text"
          name="nft_address"
          id="nft_address"
          onChange={changeNft2}
        />{" "}
        <br />
        <span>nonce </span>
        <input
          type="text"
          name="nft_address"
          id="nft_address"
          onChange={changeNonce}
        />{" "}
        <br />
        <button onClick={combMarsNFT}>조합</button>
        <hr />
        판매할 Mars NFT Id{" "}
        <input
          type="text"
          name="nft_address"
          id="nft_address"
          onChange={changeGetMarsNft}
        />{" "}
        <br />
        Owner :{detialNftOwner}
        {/* isSale : {isSale} */} <br />
        <button onClick={getNftDetail}>상태 확인</button>{" "}
        <button onClick={createSale}>판매 등록</button>{" "}
        <button onClick={cancelSale}>등록 취소</button> <br />
        <input
          type="text"
          name="nft_address"
          id="nft_address"
          onChange={changeBuyerAddress}
        />
        <button onClick={buySale}>구매</button>{" "}
      </div>
    </div>
  );
}

export default App;
