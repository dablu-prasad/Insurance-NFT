// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/**
 * ERC721 interface contracts
 */
import "./ERC721.sol";
import "./IERC721URIStorage.sol";
import "./safeMath.sol";
import "./address.sol";
import "./counters.sol";

contract Insurance is ERC721, ERC721URIStorage {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address owner;

    struct NFTDetails {
        address beneficiary;
        uint256 tokenId;
        uint256 mintTime;
        string uri;
    }
    NFTDetails nftDetails;
    NFTDetails[] public nftList;

    event Details(address, uint256, uint256, string);

    constructor() ERC721("Insurance Token", "IT") {
        owner = _msgSender();
    }

    function _baseURI() internal pure override returns (string memory) {
        return "../pdfs";
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_msgSender() == owner, "ERC721: sender is now authorized.");
        _;
    }

    function mintNFT(address _recipient, string memory _insurancePDF)
        external
        onlyOwner
        returns (uint256)
    {
        //generate NFT id
        _tokenIds.increment();
        uint256 newID = _tokenIds.current();

        //record timestamp
        uint256 mt = block.timestamp;

        //NFT mint function call
        _mint(owner, newID);
        //map NFT metadata with NFT id
        _setTokenURI(newID, _insurancePDF);
        //record NFT details in array
        nftDetails = NFTDetails(_recipient, newID, mt, _insurancePDF);
        nftList.push(nftDetails);

        return newID;
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
        // nftList.pop();
    }
}

// function withdraw() public onlyOwner() {
//         require(address(this).balance > 0, "Balance is zero");
//         payable(owner()).transfer(address(this).balance);
//     }
