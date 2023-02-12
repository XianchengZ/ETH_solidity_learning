import { ethers } from 'ethers'
import fs from 'fs'

const main = async () => {
  // rpc server: http://127.0.0.1:7545
  const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:7545')
  const wallet = new ethers.Wallet(
    '64913d67ce8fcdceec9ab3ba7506a75d7cb18c6d53ad7b78ca1e2204ae27f126',
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
  const contract = await contractFactory.deploy()
  // const deploymentReceipt = await contract.deployTransaction.wait()
  // console.log(`Contract deployed to ${contract.address}`)
  console.log(contract)
}

main()
  .then(() => {
    process.exit(0)
  })
  .catch((error: any) => {
    console.log(error)
    process.exit(1)
  })
