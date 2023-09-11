// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/IERC721ReceiverUpgradeable.sol";
import "./UpgradeableNFT.sol"; 
import "./UpgradeableERC20.sol";

contract UpgradeableNFTStakerV1 is IERC721ReceiverUpgradeable {
    IERC721Upgradeable public stakeableNFT;
    mapping(uint256 => address) public originalOwner;
    mapping(address => stakerInfo) public stakersMap;
    uint256 constant public REWARDS_PER_DAY = 10;
    uint256 constant public DECIMALS = 18;
    UpgradeableERC20 public rewardToken;
    address public haha;

    struct stakerInfo {
        uint256 nftsStaked;
        uint256 timeStaked;
        uint256 leftover;
    }

    function getStakerInfo(address user) public view returns (stakerInfo memory){
        return stakersMap[user];
    }
    
    function initialize(address _nft, address _rewardToken) external {
        stakeableNFT  = IERC721Upgradeable(_nft);
        rewardToken = UpgradeableERC20(_rewardToken);
    }

    function depositNFT(uint256 tokenId) external{
        originalOwner[tokenId] = msg.sender;
        stakeableNFT.safeTransferFrom(msg.sender, address(this), tokenId);
    }

    function withdrawNFT(uint256 tokenId) external{
        require(originalOwner[tokenId] == msg.sender, "Not original owner");
        stakersMap[msg.sender].nftsStaked -= 1;
        stakeableNFT.safeTransferFrom(address(this), msg.sender, tokenId);      
    }

    function newDeposit(address from) internal {
        if(stakersMap[from].nftsStaked > 0) {
            collectRewards();
        }
        stakersMap[from].nftsStaked += 1;
    }

    function collectRewards(address from) internal {
        (uint256 toGive, uint256 toRetain) = calculateReward(from);
        rewardToken.mintReward(toGive, from);
        stakersMap[from].timeStaked = block.timestamp;
        stakersMap[from].leftover = toRetain;
    }

    function collectRewards() public {
        collectRewards(msg.sender);
    }

    function calculateReward(address from) public view returns (uint256, uint256){
        uint256 timesSinceClaim = block.timestamp - stakersMap[from].timeStaked;
        uint256 totalRewards = stakersMap[from].leftover + stakersMap[from].nftsStaked * REWARDS_PER_DAY * 10**DECIMALS * (timesSinceClaim)/(1 days);
        uint256 unitsOfTenRewards = (totalRewards/10**18)*10**18;
        uint256 remainder = totalRewards - unitsOfTenRewards;
        return (unitsOfTenRewards, remainder);
    }

    // depositing an additional NFT will let users claim pending reward and start fresh
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4) {
        // make sure we can only transfer the NFT collection we want
        require(msg.sender == address(stakeableNFT), "Non acceptable NFT");
        originalOwner[tokenId] = from;
        newDeposit(from);
        return IERC721ReceiverUpgradeable.onERC721Received.selector;
    }
}