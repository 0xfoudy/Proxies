## Proxies

**Question 1:** The OZ upgrade tool for hardhat defends against 6 kinds of mistakes. What are they and why do they matter?
- Initialising once (setting owner = msg.sender in initialize function would ruin our ownership if called many times)
- Constructor inside implementation (storage would be on the implementation and not in the proxy's storage since we delegate call)
- Storage (delegate call matches storage 1 to 1, so we need to be careful updating storage variables)
- Upgrades: new storage variables have to be added AFTER the existing one (the new storage would have the value of the one whose place it took)
- selfdestruct inside implementation, we would end up without an implementation and our proxy becomes useless
- Admins? to avoid confusion between functions that could have the same name but require an admin

**Question 2:** What is a beacon proxy used for?
- We store the implementation address in an external contract instead of our proxy, advantage would be to update what multiple proxies are pointing to in a single transaction instead of having to update every proxy.

**Question 3:** Why does the openzeppelin upgradeable tool insert something like `uint256[50] private __gap;` inside the contracts? To see it, create an upgradeable smart contract that has a parent contract and look in the parent.
- To avoid storage clash, the gap allows us to be able to add storage as we go forward with upgrading the implementation, also protects for inheritance (not to push down any storage).

**Question 4:** What is the difference between initializing the proxy and initializing the implementation? Do you need to do both? When do they need to be done?
Initializing the proxy is creating it, initializing the implementation is the replacement of the constructor. We do need to do both, the implementation initiliazation has to be done as soon as it's pointed at by the proxy. + remember to call the initializer of all parent contracts (with onlyInitializing modifier).

Question: Initialization is done via a delegate call, shouldn't the logic contract be initialised via a regular call to have its own storage updated (for example if ownership is set via the initialize)? Or should we let initialize only be called via delegate call?

**Question 5:** What is the use for the [reinitializer](https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/proxy/utils/Initializable.sol#L119)? Provide a minimal example of proper use in Solidity
- Given that initializer can only be called once (even after an upgrade because the storage variable isInitialized is updated on the proxy side not the logic), we might need to reinitialize in the future to a newer version.


My proxies:

Staking 0x9Cc0f3d31bF929Fe136832532a10caBcCbB2c7ce (https://sepolia.etherscan.io/address/0x9cc0f3d31bf929fe136832532a10cabccbb2c7ce#code)
NFT 0x644EbB155343A53b8B1B80ab6F719aed7e85B34c (https://sepolia.etherscan.io/address/0x644ebb155343a53b8b1b80ab6f719aed7e85b34c#readProxyContract)
ERC20 0xB15d5CC06015c350E18f1079e5b6d23444042D7e (https://sepolia.etherscan.io/address/0xb15d5cc06015c350e18f1079e5b6d23444042d7e#readProxyContract)