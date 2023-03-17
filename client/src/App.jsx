import { useState } from "react";
import { useNavigate } from "react-router-dom";
// import Web3 from "web3";

function App() {
  const [web3, setWeb3] = useState();
  const navigate = useNavigate();
  const [account, setAccount] = useState(); // state variable to set account.

  // useEffect(() => {
  //   async function load() {
  //     const web3 = new Web3(Web3.givenProvider || "http://localhost:7545");
  //     const accounts = await web3.eth.requestAccounts();

  //     setAccount(accounts[0]);
  //   }

  //   load();
  // }, []);

  // async function load() {
  //   const web3 = new Web3(Web3.givenProvider);
  //   // const web3 = new Web3("http://localhost:7545");
  //   const accounts = await web3.eth.requestAccounts();
  //   if (!window.ethereum) {
  //     // console.error("MetaMask is not found!");
  //     navigate("https://metamask.io/");
  //   } else {
  //     console.log("설치됨");
  //   }
  //   // 첫번째 계정을 accounts 로 설정
  //   setAccount(accounts);
  //   // console.log(typeof accounts);
  // }

  const load = async () => {
    if (typeof window.ethereum !== "undefined") {
      try {
        const web = new Web3(window.ethereum);
        setWeb3(web);
      } catch (err) {
        console.log(err);
      }
    } else {
      navigate("https://metamask.io/");
    }
  };

  //  const accounts = await window.ethereum.request({
  //   method: "eth_requestAccounts",
  // });
  const connectWallet = async () => {
    accounts = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    setAccount(accounts[0]);
  };

  return (
    <>
      <button onClick={load}>getAccount</button>
      <div>Your account is: {account}</div>
    </>
  );
}

export default App;
