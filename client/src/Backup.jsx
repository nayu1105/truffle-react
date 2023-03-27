import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Web3 from "web3/dist/web3.min.js";

function App() {
  const [web3, setWeb3] = useState();
  const navigate = useNavigate();
  const [account, setAccount] = useState(); // state variable to set account.

  const load = async () => {
    if (typeof window.ethereum !== "undefined") {
      try {
        const web = new Web3(
          new Web3.providers.HttpProvider("http://127.0.0.1:7545")
        );
        setWeb3(web);
        alert("metamask connect!");
        connectWallet();
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
    const accounts = await web3.eth.getAccounts();
    setAccount(accounts[0]);
  };

  return (
    <>
      <div>Your account is : {account}</div>
      <div>
        Nickname :
        <input type="text" name="nickname" id="nickname" />
      </div>
      <button onClick={load}>getAccount</button>{" "}
      <button type="submit">login</button>
    </>
  );
}

export default App;
