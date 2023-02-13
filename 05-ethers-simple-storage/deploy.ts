import { ethers } from 'ethers'
import fs from 'fs'

const main = async () => {
  // rpc server: http://127.0.0.1:7545
  const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:7545')
  const wallet = new ethers.Wallet(
    '265a39d592fb9cb029434c21b5279c9340961f77bad41a9b8da2d517342e8724',
    provider
  )

  const abi = fs.readFileSync('./SimpleStorage_sol_SimpleStorage.abi', 'utf8')
  const binary = fs.readFileSync(
    './SimpleStorage_sol_SimpleStorage.bin',
    'utf8'
  )
  // in ethers.js, contract factory is not factory pattern.
  // it is used to deploy a contract
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet)
  console.log('Deploying, please wait...')
  // const contract = await contractFactory.deploy({ gasLimit: 10000000 })
  const contract = await contractFactory.deploy()

  // transaction receipt is when you wait for block confirmation
  const transactionReceipt = await contract.deployTransaction.wait(1)

  console.log

  // console.log('Here is the deployment transaction: ')
  // console.log(contract.deployTransaction) // what you get right away
  // console.log('Here is the transaction receipt: ')
  // console.log(transactionReceipt)
}

main()
  .then(() => {
    process.exit(0)
  })
  .catch((error: any) => {
    console.log(error)
    process.exit(1)
  })
