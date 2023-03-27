import { useState } from "react";
import Web3 from "web3";
import O2Token from "./contracts/O2Token.json";

const SERVER_ACCOUNT = "0xf773bf0A6Fd046e1fF3Ca023E98897d8624A2F16";
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
    const targetChainId = 1337; // ganache default chainId : 1337, hex : 0x539
    try {
      await window.ethereum.request({
        method: "wallet_switchEthereumChain",
        params: [{ chainId: web3.utils.toHex(targetChainId) }],
      });
      console.log("wallet_switchEthereumChain - call");
      console.log(await getRequestAccounts());
      return await getRequestAccounts(); // 계정가지고 오기
    } catch (switchError) {
      // This error code indicates that the chain has not been added to MetaMask.
      if (switchError.console === 4902) {
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
      }
    }
  };

  const load = async () => {
    // const balance = await web3.eth.getBalance(account);
    // console.log(balance);
    if (!(await init())) {
      // window.open("https://metamask.io/download/");
      // 메타마스크 설치 페이지로 이동
    }
    // metamask 로그인 하고 우리 네트워크 (현재는 localhost://8545 에 연결)
    SetAccount(await init());
  };

  const buyO2 = async () => {
    // const networkID = await web3.eth.net.getId();

    // const artifact = require("./contracts/O2Token.json");
    // artifact.setProvider("http://127.0.0.1:8545");
    // set provider for all later instances to use
    // Contract.setProvider('ws://localhost:8546');
    // const fs = require("fs");
    // const ABI_FILE = JSON.parse(fs.readFileSync("./abi/O2Token_ABI.json"));
    // const web3js = new Web3(web3.currentProvider);

    const contractAddress = "0xe015174015Ac70E3Dae98A3A1b1E8542c302AC21";
    const contract = new web3.eth.Contract(O2Token.abi, contractAddress);

    await contract.methods.mint(10000).send({
      from: account,
      value: "5000000000000000000",
    });
    // decimals가 2이기 때문에 100 이라고 하면 1.00 O2 발급됨
    // 100 O2 발급을 위해서 10000 parameter 전달

    // console.log(mint);
    // console.log(await response);
    // await contract
    //   .request({
    //     method: "mint",
    //     params: [
    //       {
    //         from: account,
    //         to: SERVER_ACCOUNT,
    //         // Only required to send ether to the recipient from the initiating external account.
    //         gas: "0x76c0", // 30400
    //         gasPrice: "0x9184e72a000", // 10000000000000
    //         value: 100,
    //       },
    //     ],
    //   })
    //   .then((txHash) => console.log(txHash))
    //   .catch((error) => console.log(error));
  };

  return (
    <>
      <div style={{ fontSize: "20px" }}>Your account is : {account}</div>
      <button onClick={load}>로그인</button>{" "}
      <button type="submit">회원가입</button>{" "}
      <button onClick={buyO2}>O2 구매</button>
    </>
  );
}

export default App;
