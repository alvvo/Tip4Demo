const getRandomNonce = () => Math.random() * 64000 | 0;


async function main() {
  const Collection = await locklift.factory.getContract('Collection');
  const [keyPair] = await locklift.keys.getKeyPairs();
  
  const collection = await locklift.giver.deployContract({
    contract: Collection,
    constructorParams: {
      //
    },
    initParams: {
      //
    },
    keyPair,
  });
  
  console.log(`Collection deployed at: ${collection.address}`);
}


main()
  .then(() => process.exit(0))
  .catch(e => {
    console.log(e);
    process.exit(1);
  });
