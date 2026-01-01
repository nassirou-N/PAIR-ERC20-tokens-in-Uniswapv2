-- number of pair swap WETH or USDC (WETH/USDC,USDC/WETH) in the uniswap_v2 Factory ethereum
-- '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2'  WETH
-- '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48'   USDC

SELECT count(pair)
FROM uniswap_v2_ethereum.Factory_evt_PairCreated
WHERE token0 in (0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48) OR token1 in (0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);



SELECT 
  p.contract_address as pair,
  date_trunc('day', p.evt_block_date) as date,
  t0.symbol as token0_symbol,
  t1.symbol as token1_symbol
FROM uniswap_v2_ethereum.Factory_evt_PairCreated p
LEFT JOIN tokens.erc20 t0 
  ON t0.contract_address = p.token0  
LEFT JOIN tokens.erc20 t1 
  ON p.token1 = t1.contract_address
WHERE p.token0 in (0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48) 
  OR p.token1 in (0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48) 
  AND t1.blockchain = 'ethereum' AND t0.blockchain = 'ethereum';