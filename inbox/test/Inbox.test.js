// contract test code will go here
const assert = require('assert');
const ganache = require('ganache-cli');
const { describe, it, beforeEach } = require('mocha');
const Web3 = require('web3'); // constructor Function
const { interface, bytecode } = require('../compile');

const web3 = new Web3(ganache.provider());
let accounts;
let inbox;

beforeEach(async () => {
  // Get a list of all accounts
  accounts = await web3.eth.getAccounts();
  // use one of those accounts to deploy the contract

  inbox = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({
      data: bytecode,
      arguments: ['Hi there!'],
    })
    .send({ from: accounts[0], gas: '1000000' });
});

describe('Inbox', () => {
  it('deploys a contract', () => {
    assert.ok(inbox.options.address);
  });
  it('has a default messsage', async () => {
    const message = await inbox.methods.message().call();
    assert.equal(message, 'Hi there!');
  });

  it('can change the message', async () => {
    await inbox.methods.setMessage('new Message').send({ from: accounts[0] });
    const message = await inbox.methods.message().call();
    assert.equal(message, 'new Message');
  });
});
