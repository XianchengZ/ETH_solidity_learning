import { ethers } from 'hardhat'
import { SimpleStorage, SimpleStorage__factory } from '../typechain-types'
import { expect, assert } from 'chai'

describe('SimpleStorage', function () {
	let SimpleStorageFactory: SimpleStorage__factory
	let simpleStorage: SimpleStorage

	beforeEach(async function () {
		SimpleStorageFactory = await ethers.getContractFactory('SimpleStorage')
		simpleStorage = await SimpleStorageFactory.deploy()
	})

	it('Should start with a favorite number of 0', async function () {
		const currentValue = await simpleStorage.retrieve()
		const expectedValue = '0'
		// assert
		// expect
		assert.equal(currentValue.toString(), expectedValue)
	})

	it('Should update when we call store', async function () {
		const expectedValue = '778'
		const transactionResponse = await simpleStorage.store(expectedValue)
		await transactionResponse.wait(1)

		const currentValue = await simpleStorage.retrieve()
		assert.equal(currentValue.toString(), expectedValue)
	})
})
