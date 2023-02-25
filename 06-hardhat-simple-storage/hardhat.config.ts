import { HardhatUserConfig } from 'hardhat/config'

import '@nomiclabs/hardhat-etherscan'
import 'hardhat-gas-reporter'
import 'solidity-coverage'
import '@nomicfoundation/hardhat-toolbox'
import 'dotenv/config'
import './tasks/block-number'

const GEORLI_RPC_URL = process.env.GEORLI_RPC_URL || ''
const GEORLI_PRIVATE_KEY = process.env.GEORLI_PRIVATE_KEY || ''

const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || ''

const COIN_MARKET_CAP_API_KEY = process.env.COIN_MARKET_CAP_API_KEY || ''

const config: HardhatUserConfig = {
	defaultNetwork: 'hardhat',
	networks: {
		georli: {
			url: GEORLI_RPC_URL,
			accounts: [GEORLI_PRIVATE_KEY!],
			chainId: 5,
		},
		localhost: {
			url: 'http://127.0.0.1:8545/',
			chainId: 31337,
		},
	},
	solidity: '0.8.7',
	etherscan: {
		apiKey: ETHERSCAN_API_KEY,
	},
	gasReporter: {
		enabled: true, // switch to false if you don't want gas reporter
		outputFile: 'gas-report.txt',
		noColors: true,
		currency: 'USD',
		coinmarketcap: COIN_MARKET_CAP_API_KEY,
	},
}

export default config
