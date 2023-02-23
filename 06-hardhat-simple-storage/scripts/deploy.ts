import { ethers, run, network } from 'hardhat'

const verify = async (contractAddress: string, args: any[]) => {
	console.log('Verifying contract...')
	try {
		await run('verify:verify', {
			address: contractAddress,
			constructorArguments: args,
		})
	} catch (e: any) {
		if (e.message.toLowerCase().includes('already verified')) {
			console.log('Already verified!')
		} else {
			console.log(e)
		}
	}
}

async function main() {
	const SimpleStorageFactory = await ethers.getContractFactory(
		'SimpleStorage'
	)
	console.log('Deploying contract...')
	const SimpleStorage = await SimpleStorageFactory.deploy()
	await SimpleStorage.deployed()
	console.log(`Deployed contract to: ${SimpleStorage.address}`)

	if (network.config.chainId === 5 && process.env.ETHERSCAN_API_KEY) {
		await SimpleStorage.deployTransaction.wait(6)
		await verify(SimpleStorage.address, [])
	}

	const currentValue = await SimpleStorage.retrieve()
	console.log(`Current Value is: ${currentValue}`)

	const transactionResponse = await SimpleStorage.store('78')
	await transactionResponse.wait(1)
	const updatedValue = await SimpleStorage.retrieve()
	console.log(`Updated Value is: ${updatedValue}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
	.then(() => process.exit(1))
	.catch((error) => {
		console.error(error)
		process.exitCode = 1
	})
