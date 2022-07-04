// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


interface ERC20Interface { 
    
    function totalSupply() external view returns (uint256);

    function balanceOf(address tokenOwner) external view returns (uint256 balance);

    function transfer(address to, uint256 tokens) external returns (bool success);
    
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining);
    
    function approve(address spender, uint256 tokens) external returns (bool success);
    
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success);
    

    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint256 tokens);

}


contract ERC20Token is ERC20Interface {
    
    string public name; //name of the token
    string public symbol;   //token symbol
    uint8 public decimals;  //no. of digits after fraction allowed
    uint256 public _totalSupply;    //total supply of token
    mapping(address => uint256) public balances;    //mapping of address => token

    //2d hash map [addr1][addr2] = x token, addr1 has allowed addr2 to use x tokens from addr1
    mapping(address => mapping(address => uint256)) public allowed;

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply){
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        _totalSupply = _initialSupply;
        balances[msg.sender] = _totalSupply;
    }

    //// Transfer the balance from owner's account to another account
    function transfer(address to, uint256 tokens) public override returns (bool){

        require(balances[msg.sender] >= tokens, "insufficient balance");

        balances[msg.sender] -= tokens;
        balances[to] += tokens;

        //emit the event
        emit Transfer(msg.sender, to, tokens);

        return true;
    }

    // Send amount of tokens from address `from` to address `to`
    function transferFrom(address from, address to, uint256 tokens) public override returns (bool) {
        
        //check if token requested exceeds the allowance
        require(allowed[from][msg.sender] >= tokens, "allowance too low");
        require(balances[from] >= tokens, "token balance too low");
        
        allowed[from][msg.sender] -= tokens;
        balances[from] -= tokens;
        balances[to] += tokens;
        
        emit Transfer(from, to, tokens);
        return true;
    }


    // Approves the `spender` to withdraw from your account, multiple times, up to the `tokens` amount.
    // So the msg.sender is approving the spender to spend these many tokens
    // from msg.sender's account
    function approve(address spender, uint256 value) public override returns (bool){
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    //fetch the allowance beween owner and spender
    function allowance(address owner, address spender) public view override returns (uint256){
        return allowed[owner][spender];
    }

    //get balace of a address
    function balanceOf(address owner) public view override returns (uint256) {
        return balances[owner];
}
    //get total supply of coins
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
}
}