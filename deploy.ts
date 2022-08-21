import { ethers } from 'ethers';
import * as fs from 'fs-extra';
import 'dotenv/config';

async function main() {
  const provider = new ethers.providers.JsonRpcProvider(process.env.BASE_URL);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY!, provider);

  const abi = fs.readFileSync(
    './artifacts/simple_storage_sol_SimpleStorage.abi',
    'utf8'
  );

  const bin = fs.readFileSync(
    './artifacts/simple_storage_sol_SimpleStorage.bin',
    'utf8'
  );

  const contractFactory = new ethers.ContractFactory(abi, bin, wallet);
  console.log('deploying contract...');
  const contract = await contractFactory.deploy();
  await contract.deployTransaction.wait(1);

  console.log(contract.address);

  // Get favorite number
  const fvn = await contract.retrieve();
  console.log(fvn.toString());

  const storeNumber = await contract.create('10');
  const storeReceipt = await storeNumber.wait(1);

  const fvn2 = await contract.retrieve();
  console.log(fvn2.toString());
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err);
    process.exit(1);
  });
