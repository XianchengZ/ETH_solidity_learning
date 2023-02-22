import { HardhatUserConfig } from 'hardhat/config'

import('@nomiclabs/hardhat-etherscan')
import '@nomicfoundation/hardhat-toolbox'
import 'dotenv/config'

const GEORLI_RPC_URL = process.env.GEORLI_RPC_URL
const GEORLI_PRIVATE_KEY = process.env.GEORLI_PRIVATE_KEY

const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY

const config: HardhatUserConfig = {
	defaultNetwork: 'hardhat',
	networks: {
		georli: {
			url: GEORLI_RPC_URL,
			accounts: [GEORLI_PRIVATE_KEY!],
			chainId: 5,
		},
	},
	solidity: '0.8.7',
	etherscan: {
		apiKey: ETHERSCAN_API_KEY,
	},
}

export default config
