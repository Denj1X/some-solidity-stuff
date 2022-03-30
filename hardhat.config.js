require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks:{
    rinkeby:{
      url: 'https://rinkeby.infura.io/v3/2f09e485a9514e8b80efd471b0fe0326',
      accounts: ['564872faf24706da69a6968cb4c8d16cf70f3b37186f4b27e689cd694e870e4c'],
    },
    mumbai:{
      url: 'https://rpc-mumbai.matic.today',
      accounts: ['564872faf24706da69a6968cb4c8d16cf70f3b37186f4b27e689cd694e870e4c'],
    }
  }
};
