// "SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.8.0;


interface IERC20 {
  function transfer(address to, uint256 value) external returns (bool);
  function approve(address spender, uint256 value) external returns (bool);
  function transferFrom(address from, address to, uint256 value) external returns (bool);
  function totalSupply() external view returns (uint256);
  function balanceOf(address account) external view returns (uint256);
  function allowance(address owner, address spender) external view returns (uint256);
  function decimals() external view returns (uint8);
  function burn(uint256 amount) external;
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}


library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}


interface IPancakeRouter01 {
    function factory () external pure returns (address);
    function WETH () external pure returns (address);
    function WPLS () external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);

    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

pragma solidity >=0.6.2;

interface IRouter is IPancakeRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

pragma solidity >=0.6.2;

interface IFactory {
function getPair (address token1, address token2) external pure returns (address);
}


contract WhalesCandy {

    using SafeMath for uint256;

    address payable public _dev = payable (0x2fc8c6B7fE208Cf3f1e3e239DEb3EBf9E277898D); // receives ETH and Token
    // address public _setterDev =  0x2096aFDaA68EEaE1EbF95DFdf565eE6d9B1fbA37; // address that can help to set user stakings
    address payable public feeTokenRecipient = payable (0x2096aFDaA68EEaE1EbF95DFdf565eE6d9B1fbA37); // receives the fee Token
    bool public settingDone = false;
    uint8 public devAuctionFee = 30;
    uint8 public devDiscountedBuyFee = 30;

    address public contrAddr;

    address public feeTokenAddr =  0x15D38573d2feeb82e7ad5187aB8c1D52810B1f07;
    uint8 public feeTokenDecimals = IERC20(feeTokenAddr).decimals();

    address public _routerAddr = 0x98bf93ebf5c380C0e6Ae8e192A7e2AE08edAcc02;
    IRouter public _router = IRouter(_routerAddr);

    IFactory public _factory = IFactory(_router.factory());
    address public tradingPair = address(0);

    uint256 public usedETHforBuyBack;
    uint256 public lpBal;

    uint256 public overallStakedToken;
    uint256 public overallCollectedDividends;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Sake(address indexed user, uint256 stakeAmount, uint256 stakeTime);
    event EnterAuction (address indexed user, uint256 rawAmount, uint256 entryTime);
    event ClaimRewards (address indexed user, uint256 rewardAmount, uint256 claimTime);

    modifier onlyDev() {
        require(_dev == msg.sender, "Ownable: caller is not the dev");
        _;
    }

    string public constant name = "WhalesCandyPLS.com";
    string public constant symbol = "WC";
    uint256 public constant decimals = 18;

    uint256 private _totalSupply;

    mapping(address => uint256) private _Balances;

    /* Time of contract launch */
    uint256 public LAUNCH_TIME = 1685037600; // Sets Starttime of Auctions, Days and Weeks // TODO
    uint256 public oneDay = 1 days;  // TODO
    uint256 public oneWeek =  7 days; // TODO
    uint32 public offDays = 0 days; 
    uint256 public currentDay;
    uint256 public lastBUYINday;
    uint8 public buyBackPerecent = 40;
    uint8 public discountedBuyFactor = 100;  // percentage of tokens to be staked after buying from DEX (discounted buy)
    uint8 public percentToReceive = 20; // percentage of tokens to be received when doing a regular buy from DEX
    
    struct StakeData{
      uint256 stakeTime;
      uint256 amount;
      uint256 claimed;
      uint256 lastUpdate;
      uint256 collected;
      bool freeClaiming;
      uint256 claimingStartFee;
      uint256 feePaid;
    }

    uint256 public feePerWeek = 2 * 10 ** feeTokenDecimals;
    uint256 private maxTotalFee = 29 * 2 * 10 ** feeTokenDecimals;

    uint256 private weiPerSfor1perDay = 11574074074074;  // this token/wei amount need to be accounted per second to have 1 ETH per day

    uint256 private dayliAvailableToken = 2000000 ether;

    mapping(address => mapping(uint256 => StakeData)) public stakes;
    mapping(address => uint256) public stakeNumber;
    mapping(address => uint256) public refAddresstoCode;
    mapping(uint256 => address) public refCodeToAddress;
    mapping(address => address) public myRef;

    /* day's total auction entry */ 
    mapping(uint256 => uint256) public auctionEntry;
    /* day's liq already added? */ 
    mapping(uint256 => bool) public liqAdded;
    // total auction entry  
    uint256 public auctionEntry_allDays;

    // counting unique (unique for every day only) Auction enteries for each day
    mapping(uint256 => uint256) public usersCountDaily;
    // counting unique (unique for every day only) users
    uint256 public usersCount = 0;

    uint256 public refCount = 6110000;

    // mapping for allowance
    mapping (address => mapping (address => uint256)) private _allowance;

    
    // Auction memebrs overall data 
    struct memberAuction_overallData{
        uint256 overall_collectedTokens;
        uint256 total_auctionEnteries;
        uint256 overall_stakedTokens;
    }
    // new map for every user's overall data  
    mapping(address => memberAuction_overallData) public mapMemberAuction_overallData;
    
    /* Auction memebrs data */ 
    struct memberAuction{
        uint256 memberAuctionValue;
        uint256 memberAuctionEntryDay;
        bool hasChangedShareToToken;
        address referrer;
    }
    /* new map for every entry (users are allowed to enter multiple times a day) */ 
    mapping(address => mapping(uint256 => memberAuction)) public mapMemberAuction;

    /* new map for the referrers tokens */
    struct refData{
      uint256 refEarnedTokens;
    }
    mapping(address => mapping(uint256 => refData)) public mapRefData;
    
    // Addresses that excluded from transferTax when receiving
    mapping(address => bool) private _excludedFromTaxReceiver;




    constructor() {
        contrAddr = address(this);

        _excludedFromTaxReceiver[msg.sender] = true;
        _excludedFromTaxReceiver[contrAddr] = true;
        _excludedFromTaxReceiver[_routerAddr] = true;
        _excludedFromTaxReceiver[_dev] = true;
        _excludedFromTaxReceiver[feeTokenRecipient] = true;  

        _mint(contrAddr, 1 ether);
    }
    
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _Balances[account];
    }

    function allowance(address owner_, address spender) external view returns (uint256) {
        return _allowance[owner_][spender];
    }

    function approve(address spender, uint256 value) public returns (bool) {
        _allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) external returns (bool) {
        _allowance[msg.sender][spender] =
        _allowance[msg.sender][spender].add(addedValue);
        emit Approval(msg.sender, spender, _allowance[msg.sender][spender]);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool) {
        uint256 oldValue = _allowance[msg.sender][spender];
        if (subtractedValue >= oldValue) {
            _allowance[msg.sender][spender] = 0;
        } else {
            _allowance[msg.sender][spender] = oldValue.sub(subtractedValue);
        }
        emit Approval(msg.sender, spender, _allowance[msg.sender][spender]);
        return true;
    }

    // Set addresses of dev ad dev1
    function setDevs(address payable dev, address payable _feeTokenRecipient) external onlyDev {
        _dev = dev;
        feeTokenRecipient = _feeTokenRecipient;
     }


    // Set the fee that goes to dev with each auction entry
    function setDevAuctionFee(uint8 _devAuctionFee) external onlyDev {
      require(_devAuctionFee <= 30, "setDevAuctionFee: Dev Auction Fee cant be above 30%" );
        devAuctionFee = _devAuctionFee;
     }

    // Set the fee that goes to dev with each ussage of the discounted BUY function
    function setDevDiscountedBuyFee(uint8 _devDiscountedBuyFee) external onlyDev {
      require(_devDiscountedBuyFee <= 30, "setDevDiscountedBuyFee: Dev Auction Fee cant be above 30%" );
        devDiscountedBuyFee = _devDiscountedBuyFee;
     }


    // Set the LP-Buyback Percentage
    function setBuyBackPerecent(uint8 _buyBackPerecent) external onlyDev {
        require (_buyBackPerecent < 1000, "Value to big, use at max 999!");
        buyBackPerecent = _buyBackPerecent;
     }

    // Set the discounted Buy Factor for the discounted buy from DEX
    // 100 is 100%, user stake will be as big as the current ETH buy value!
    // 500 is 500%, user stake will be 5x higher than his ETH value!
     function setdiscountedBuyFactor(uint8 _discountedBuyFactor) external onlyDev {
        require (20 <= _discountedBuyFactor, "Value to small, use at least 20!");
        require (_discountedBuyFactor <= 500, "Value to big, use at max 500!");
        discountedBuyFactor = _discountedBuyFactor;
     }

    // Set the percentage to be received when buying from DEX
     function setPercentToReceive(uint8 _percentToReceive) external onlyDev {
        require (20 <= _percentToReceive, "Value to small, use at least 20!");
        require (_percentToReceive <= 100, "Value to big, use at max 100!");
        percentToReceive = _percentToReceive;
     }
     
    // Set address to be in- or excluded from Tax when receiving
    function setExcludedFromTaxReceiver(address _account, bool _excluded) external onlyDev {
        _excludedFromTaxReceiver[_account] = _excluded;
     }
    
    // Returns if the address is excluded from Tax or not when receiving.    
    function isExcludedFromTaxReceiver(address _account) public view returns (bool) {
        return _excludedFromTaxReceiver[_account];
    }
    
   function transferToZero(uint256 amount) internal returns (bool) {
        _Balances[contrAddr] = _Balances[contrAddr].sub(amount, "Token: transfer amount exceeds balance");
        _Balances[address(0)] = _Balances[address(0)].add(amount);
        emit Transfer(contrAddr, address(0), amount);
        return true;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }  

    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        if( msg.sender != contrAddr ) {
          _allowance[from][msg.sender] = _allowance[from][msg.sender].sub(amount);
        }
        _transfer(from, to, amount);
        return true;
    }

    // internal transfer function to apply the transfer tax ONLY for buys from DEX liquidity
    function _transfer(address from, address to, uint256 amount) internal virtual {
        // For Taxed Transfer (if pair is sender (token BUY) tax of 80% applies)
        bool _isTaxedRecipient = !isExcludedFromTaxReceiver(to);
        if ( from == tradingPair && _isTaxedRecipient ) {   // if sender is pair (its a buy tx) AND if it is a TaxedRecipient  
        _Balances[from] = _Balances[from].sub(amount, "transfer amount exceeds balance");
        uint256 taxedAmount = amount.mul(percentToReceive).div(100);
        _Balances[to] = _Balances[to].add(taxedAmount);
        _Balances[address(0)] = _Balances[address(0)].add(amount.sub(taxedAmount));
        emit Transfer(from, to, taxedAmount);
        emit Transfer(from, address(0), amount.sub(taxedAmount));
        } else {
        _Balances[from] = _Balances[from].sub(amount, "transfer amount exceeds balance");
        _Balances[to] = _Balances[to].add(amount);
        emit Transfer(from, to, amount);
        }
    }

    function _mint(address _user, uint256 _amount) internal { 
      _Balances[_user] = _Balances[_user].add(_amount);
      _totalSupply = _totalSupply.add(_amount);
      emit Transfer(address(0), _user, _amount);
    }

    function _burn(address _user, uint256 _amount) internal {
      _Balances[_user] = _Balances[_user].sub(_amount);
      _totalSupply = _totalSupply.sub(_amount);
      emit Transfer(_user, address(0), _amount);
    }
    
    // function for users to create theri ref code
    function createRefCode() external returns (uint256) {
      require (refAddresstoCode[msg.sender] == 0);
      refAddresstoCode[msg.sender] = refCount;
      refCodeToAddress[refCount] = msg.sender;
      refCount++;
      return refAddresstoCode[msg.sender];
    }

    // function for users to stake Token they have in their wallet
    function stake (uint256 _amount) public {
      require(_Balances[msg.sender] >= _amount, "not Enoght token to stake");

      _Balances[msg.sender] = _Balances[msg.sender].sub(_amount, "transfer amount exceeds balance");      
      _Balances[contrAddr] = _Balances[contrAddr].add(_amount);
      emit Transfer(msg.sender, contrAddr, _amount);

      stakes[msg.sender][stakeNumber[msg.sender]].amount = _amount;
      stakes[msg.sender][stakeNumber[msg.sender]].stakeTime = block.timestamp;
      stakes[msg.sender][stakeNumber[msg.sender]].lastUpdate = block.timestamp;
      stakes[msg.sender][stakeNumber[msg.sender]].freeClaiming = false;
      stakes[msg.sender][stakeNumber[msg.sender]].claimingStartFee = feePerWeek;

      stakeNumber[msg.sender]++;
      overallStakedToken += _amount;
      emit Sake(msg.sender, _amount, block.timestamp);
    }

    // internal function to stake user Token
    function stakeInt (uint256 _amount) internal {
      stakes[msg.sender][stakeNumber[msg.sender]].amount = _amount;
      stakes[msg.sender][stakeNumber[msg.sender]].stakeTime = block.timestamp;
      stakes[msg.sender][stakeNumber[msg.sender]].lastUpdate = block.timestamp;
      stakes[msg.sender][stakeNumber[msg.sender]].freeClaiming = false;
      stakes[msg.sender][stakeNumber[msg.sender]].claimingStartFee = feePerWeek;

      stakeNumber[msg.sender]++;
      overallStakedToken += _amount;
      emit Sake(msg.sender, _amount, block.timestamp);
    }
 
    // internal function to stake refferal earnings with no claim fee
    function refStake (uint256 _amount) internal {      
      stakes[msg.sender][stakeNumber[msg.sender]].amount = _amount;
      stakes[msg.sender][stakeNumber[msg.sender]].stakeTime = block.timestamp;
      stakes[msg.sender][stakeNumber[msg.sender]].lastUpdate = block.timestamp;
      stakes[msg.sender][stakeNumber[msg.sender]].freeClaiming = true;

      stakeNumber[msg.sender]++;
      overallStakedToken += _amount;
      emit Sake(msg.sender, _amount, block.timestamp);
    }

    // function to set launchtime
    function setLaunchTime (uint256 newTime) external onlyDev {
      require(newTime > block.timestamp);
      LAUNCH_TIME = newTime;
    }

    // Set the address of the token that needs to be used for the fee payment.
    function setFeeTokenAddr (address _feeTokenAddr) external onlyDev {
        feeTokenAddr = _feeTokenAddr;
        // update fee token decimals
        feeTokenDecimals = IERC20(_feeTokenAddr).decimals();
    }


    // function to see which dy it is
    function thisDay() public view returns (uint256) {
        return 1 + ((block.timestamp - LAUNCH_TIME) / oneDay);
    }

    // function to get amount out from buying from LP
    function getAmountFromLiq (uint256 amountIn) public view returns (uint256) {
      address[] memory path;
      path = new address[](2);
        path[0] = _router.WPLS();
        path[1] = contrAddr;
      uint256[] memory amountOutMins = _router.getAmountsOut(amountIn, path);
      return amountOutMins[path.length -1];
    }

    // function to do a "discounted" buy from liq and do a stake for the user
    // "discounted" buy means that the tax will be less than if users buys from DEX
    function buyAndStake () external payable returns (bool) {
      uint256 rawAmount = msg.value;
      require(rawAmount > 0, "No ETH to buy Token!");

      uint256 devFee = rawAmount.mul(devDiscountedBuyFee).div(100);
      _dev.transfer(devFee); // transfer dev share of ETH to dev

      uint256 stakeAmount = getAmountFromLiq(rawAmount.mul(discountedBuyFactor).div(100));

      address[] memory path = new address[](2);
        path[0] = _router.WPLS();
        path[1] = contrAddr;

          // Buy and Burn Token from LP with ETH
          _router.swapExactETHForTokens { value: rawAmount.sub(devFee) } (
          0,
          path,
          address(0),
          block.timestamp +100
          );
        
        stakeInt(stakeAmount);
        return true;
    }

    // function to add last days collected ETH to new liquiity and update the day
    function updateDaily() public {
      // this is true once per day
      if (currentDay != thisDay()) {

          uint256 contractETHBalance = contrAddr.balance;
          if (contractETHBalance > 1000){
            
            uint256 collectedThatDay = auctionEntry[lastBUYINday].mul(70).div(100);
            if (collectedThatDay != 0 && !liqAdded[lastBUYINday] ) {
                uint256 ETHtoAdd;
                if (collectedThatDay < contractETHBalance) {
                  ETHtoAdd = collectedThatDay;
                } else { ETHtoAdd = contractETHBalance;}

                uint256 tokenToAdd = dayliAvailableToken.mul(63).div(100);
                _mint(contrAddr, tokenToAdd);
                _mint(_dev, dayliAvailableToken.mul(75).div(10000));

                if (IERC20(contrAddr).allowance( contrAddr, _routerAddr) == 0) {       
                  approve(_routerAddr, type(uint256).max);
                  IERC20(contrAddr).approve(_routerAddr, type(uint256).max);
                }

                 (uint256 addedToken, uint256 addedEth,) = _router.addLiquidityETH {value: ETHtoAdd} (
                  contrAddr,
                  tokenToAdd,
                  0,
                  0,
                  contrAddr,
                  block.timestamp + 100
                  );

                liqAdded[lastBUYINday] = true; 
                  
                uint256 ethBal = contrAddr.balance;
                
                if (ethBal > 0.01 ether) {
                  uint256 currentLiqRatio = addedToken.mul(1e18).div(addedEth);
                  uint256 neededToken = currentLiqRatio.mul(ethBal).div(1e18);

                  _mint(contrAddr, neededToken);

                    _router.addLiquidityETH {value: ethBal} (
                    contrAddr,
                    neededToken,
                    0,
                    0,
                    contrAddr,
                    block.timestamp + 100
                    );

                uint256 leftOverToken = IERC20(contrAddr).balanceOf(contrAddr);

                if (leftOverToken > 1000 ether){
                    transferToZero(leftOverToken.sub(1 ether));
                }

                }                

            }
          }

          currentDay = thisDay();

          if (tradingPair == address(0)){
            tradingPair = _factory.getPair(_router.WPLS(), contrAddr);
          }

          lpBal = IERC20(tradingPair).balanceOf(contrAddr);

          if (lpBal > 1000) { 
            burnAndBuyback();    
          }
      }
    }

    // to make the contract being able to receive ETH from Router
    receive() external payable {}

    // function to remove some of the collected LP, and use funds to buyback and burn token, daily
    function burnAndBuyback () internal {   

        if (IERC20(tradingPair).allowance(contrAddr, _routerAddr) == 0) {
         IERC20(tradingPair).approve(_routerAddr, type(uint256).max);
        }

        uint256 lpBalToRemove = lpBal.mul(buyBackPerecent).div(1000);

        uint256 ethBalBefore = contrAddr.balance;

        // remove X% of the colected Liq daily to buyback Token
        _router.removeLiquidityETHSupportingFeeOnTransferTokens(
          contrAddr,
          lpBalToRemove,
          0,
          0,
          contrAddr,
          block.timestamp + 100
        );

        uint256 ethGain = contrAddr.balance.sub(ethBalBefore);
        usedETHforBuyBack += ethGain;

          address[] memory path = new address[](2);
          path[0] = _router.WPLS();
          path[1] = contrAddr;

          // Buyback token from LP from received ETH
          _router.swapExactETHForTokens { value: ethGain } (
          0,
          path,
          address(0),
          block.timestamp +100
        );

        // Burn Token received from Liq removal
        uint256 receivedToken = IERC20(contrAddr).balanceOf(contrAddr);
            if (receivedToken > 1000 ether){
              transferToZero(receivedToken);
            }      
    }

    // function to set the amount of days that need to pass after laucnch to allow new auction entries
    function setOffDays (uint32 _offDays) external onlyDev {
      offDays = _offDays;
    }

    // function for users to participate in the daily auctions
    function buyShareFromAuction () external payable returns (bool) {
        uint256 rawAmount = msg.value;
        require(rawAmount > 0, "No ETH to buy Shares!");
        require(block.timestamp >= LAUNCH_TIME + offDays, "Auctions have not starded now!");

        _dev.transfer(rawAmount.mul(devAuctionFee).div(100)); // transfer dev share of ETH to dev

        if ( currentDay == 0) {
          currentDay = thisDay();
        }

        updateDaily();

        auctionEntry[currentDay] += rawAmount;
        auctionEntry_allDays += rawAmount;
        lastBUYINday = currentDay;
        liqAdded[currentDay] = false;
    
        if (mapMemberAuction[msg.sender][currentDay].memberAuctionValue == 0) {
            usersCount++;
            usersCountDaily[currentDay]++;
        }

        mapMemberAuction_overallData[msg.sender].total_auctionEnteries += rawAmount;

        mapMemberAuction[msg.sender][currentDay].memberAuctionValue += rawAmount; 
        mapMemberAuction[msg.sender][currentDay].memberAuctionEntryDay = currentDay;
        mapMemberAuction[msg.sender][currentDay].hasChangedShareToToken = false;      

        emit EnterAuction (msg.sender, rawAmount, block.timestamp);
        return true;        
    }

    function calculateTokenPerShareOnDay (uint256 _day) public view returns (uint256) {
      uint256 collectedThatDay = auctionEntry[_day];
      uint256 tokenPerShare = dayliAvailableToken.mul(1e18).div(collectedThatDay);
      return tokenPerShare;
    }

    // function for users to change their shares from last day into token and immediately stakeInt
    function claimTokenFromSharesAndStake (uint256 _day, uint256 _referer) external returns (bool) {
      require(_day < currentDay, "Day must be over to claim!");
      require(mapMemberAuction[msg.sender][_day].hasChangedShareToToken == false, "User has already Changed his shares to Token that Day!");
      uint256 userShares = mapMemberAuction[msg.sender][_day].memberAuctionValue; 

      uint256 amountUserTokens = calculateTokenPerShareOnDay(_day).mul(userShares).div(1e18);      

        if(refCodeToAddress[_referer] != address(0)) {
            // eared ref token are accounted for the next day so be sure ref can claim all past days token at once
            mapRefData[refCodeToAddress[_referer]][_day + 1].refEarnedTokens += amountUserTokens.mul(5).div(100);
        }

      stakeInt(amountUserTokens);

      mapMemberAuction[msg.sender][_day].hasChangedShareToToken = true;

      updateDaily();

      return true;
    }

    // function for refs to claim the past days tokens and stakeInt them fee free
    function claimRefTokensAndStake (uint256 _day) external returns (bool) {
      require(_day < currentDay, "Refs Day must be over to claim!");
      require(mapRefData[msg.sender][_day].refEarnedTokens != 0, "Ref has not earned Token that day!");

      uint256 refTokens = mapRefData[msg.sender][_day].refEarnedTokens;

      refStake(refTokens);

      mapRefData[msg.sender][_day].refEarnedTokens = 0;

      updateDaily();

      return true;
    }


    // only called when claim (collect) is called
    // calculates the earned rewards since LAST UPDATE
    // earning is 1% per day
    // earning stopps after 200 days
    function calcReward (address _user, uint256 _stakeIndex) public view returns (uint256) {
      if(stakes[_user][_stakeIndex].stakeTime == 0){
        return 0;
      }
      // value 11574074074074 gives 1 ether per day as multiplier!
      uint256 multiplier = (block.timestamp - stakes[_user][_stakeIndex].lastUpdate).mul(weiPerSfor1perDay);
      // for example: if user amount is 100 and user has staked for 200 days and not collected so far,
      // reward would be 200, if 200 was already collected reward will be 0
      if(stakes[_user][_stakeIndex].amount.mul(multiplier).div(100 ether).add(stakes[_user][_stakeIndex].collected) > 
         stakes[_user][_stakeIndex].amount.mul(200).div(100)) {
        return(stakes[_user][_stakeIndex].amount.mul(200).div(100).sub(stakes[_user][_stakeIndex].collected));
      }
      // in same example: below 200 days of stakeInt the reward is stakes.amount * days/100
      return stakes[_user][_stakeIndex].amount.mul(multiplier).div(100 ether);
    }


    // (not called internally) Only for viewing the earned rewards in UI
    // caculates claimable rewards
    function calcClaim (address _user, uint256 _stakeIndex) external view returns (uint256) {
      if (stakes[_user][_stakeIndex].stakeTime == 0){
        return 0;
      }
      // value 11574074074074 gives 1 ether per day as multiplier!
      uint256 multiplier = (block.timestamp - stakes[_user][_stakeIndex].lastUpdate).mul(weiPerSfor1perDay);

      if (multiplier.mul(stakes[_user][_stakeIndex].amount).div(100 ether).add(stakes[_user][_stakeIndex].collected) >
        stakes[_user][_stakeIndex].amount.mul(200).div(100)){
        return(stakes[_user][_stakeIndex].amount.mul(200).div(100).sub(stakes[_user][_stakeIndex].claimed));
      }
      return stakes[_user][_stakeIndex].amount.mul(multiplier).div(100 ether).add(stakes[_user][_stakeIndex].collected)
      .sub(stakes[_user][_stakeIndex].claimed);
    }

    // calculate the Fee in to pe paid to be able to claim the rewards
    function calcClaimFee (address _user, uint256 _stakeIndex) public view returns (uint256) {
      if (stakes[_user][_stakeIndex].stakeTime == 0 || stakes[_user][_stakeIndex].freeClaiming == true) {
        return 0;
      }
      uint256 weeksOfStake = (block.timestamp - stakes[_user][_stakeIndex].stakeTime) / oneWeek;
      uint256 additionalClaimFee = weeksOfStake.mul(feePerWeek);
      uint256 totalClaimFee = stakes[_user][_stakeIndex].claimingStartFee.add(additionalClaimFee);
      // if stakeInt is older than 29 weeks, fee will be 2 * 29 - feePaid.
      if (totalClaimFee > maxTotalFee) {
        return maxTotalFee.sub(stakes[_user][_stakeIndex].feePaid);
      }
      return stakes[_user][_stakeIndex].claimingStartFee.add(additionalClaimFee).sub(stakes[_user][_stakeIndex].feePaid);
    }

    // function to update the collected rewards to user stakeInt collected value and update the last updated value
    function _collect (address _user, uint256 _stakeIndex) internal {
      stakes[_user][_stakeIndex].collected = stakes[_user][_stakeIndex].collected.add(calcReward(_user, _stakeIndex));
      stakes[_user][_stakeIndex].lastUpdate = block.timestamp;
    }

    // function for users to claim rewards and also pay claim fee
    function claimRewards (uint256 _stakeIndex) external {
       uint256 feeToPay = calcClaimFee(msg.sender,_stakeIndex);
      // if fee for staking has to be paid AND there is fee to be paid
      if (feeToPay > 0) {
        require(IERC20(feeTokenAddr).allowance(msg.sender, contrAddr) >= feeToPay, "Approval to spend fee Token is needed!");
        require(IERC20(feeTokenAddr).balanceOf(msg.sender) >= feeToPay, "Not enough fee Token in wallet!");
        IERC20(feeTokenAddr).transferFrom(msg.sender, feeTokenRecipient, feeToPay);
        stakes[msg.sender][_stakeIndex].feePaid = stakes[msg.sender][_stakeIndex].feePaid.add(feeToPay);        
      }

      _collect(msg.sender, _stakeIndex);
      uint256 reward = stakes[msg.sender][_stakeIndex].collected.sub(stakes[msg.sender][_stakeIndex].claimed);
      stakes[msg.sender][_stakeIndex].claimed = stakes[msg.sender][_stakeIndex].collected;
      _mint(msg.sender, reward);
      overallCollectedDividends += reward;

      emit ClaimRewards (msg.sender, reward, block.timestamp);
    }

    // function for users to create a new stakeInt from earnings of another stakeInt
    function reinvest(uint256 _stakeIndex) external {
      uint256 feeToPay = calcClaimFee(msg.sender,_stakeIndex);
      // if fee for staking has to be paid AND there is fee to be paid
      if (feeToPay > 0) {
        require(IERC20(feeTokenAddr).allowance(msg.sender, contrAddr) >= feeToPay, "Approval to spend fee Token is needed!");
        require(IERC20(feeTokenAddr).balanceOf(msg.sender) >= feeToPay, "Not enough fee Token in wallet!");
        IERC20(feeTokenAddr).transferFrom(msg.sender, feeTokenRecipient, feeToPay);
        stakes[msg.sender][_stakeIndex].feePaid = stakes[msg.sender][_stakeIndex].feePaid.add(feeToPay);        
      }

      _collect(msg.sender, _stakeIndex); // collected amount and lastUpdate gets updated
      // calculate Reward = _amount
      uint256 _amount = stakes[msg.sender][_stakeIndex].collected.sub(stakes[msg.sender][_stakeIndex].claimed);
      
      // new stakeInt is opened with reward = _amount of "old" stakeInt!
      stakeInt(_amount);
      overallCollectedDividends += _amount;
      // the the "old" stakeInt of which the rewards were reinvested in a new stakeInt gets updated!
      stakes[msg.sender][_stakeIndex].claimed = stakes[msg.sender][_stakeIndex].collected;

      if(myRef[msg.sender] != address(0)){
        _mint(_dev, _amount.mul(5).div(100)); // 5% for dev
        // eared ref token are accounted for the next day so be sure ref can claim all past days token at once
        mapRefData[myRef[msg.sender]][currentDay + 1].refEarnedTokens += _amount.mul(5).div(100); // 5% for referrer
      }
      else{
        _mint(_dev, _amount.mul(5).div(100)); // 5% for dev
      }

      updateDaily();
      emit ClaimRewards (msg.sender, _amount, block.timestamp);
    }

}