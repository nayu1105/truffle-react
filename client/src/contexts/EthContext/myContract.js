var Web3 = require("web3");
var web3 = new Web3("http://localhost:8545");
// or
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));

// change provider
web3.setProvider("ws://localhost:8546");
// or
web3.setProvider(new Web3.providers.WebsocketProvider("ws://localhost:8546"));

// Using the IPC provider in node.js
var net = require("net");
var web3 = new Web3("/Users/myuser/Library/Ethereum/geth.ipc", net); // mac os path
// or
var web3 = new Web3(
  new Web3.providers.IpcProvider("/Users/myuser/Library/Ethereum/geth.ipc", net)
); // mac os path
// on windows the path is: "\\\\.\\pipe\\geth.ipc"
// on linux the path is: "/users/myuser/.ethereum/geth.ipc"
