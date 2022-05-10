// contract test code will go here
const assert = require('assert');
const ganache = require('ganache-cli');
const { describe, it, beforeEach } = require('mocha');
const Web3 = require('web3'); // constructor Function

const web3 = new Web3(ganache.provider());
