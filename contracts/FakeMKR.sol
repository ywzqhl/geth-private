pragma solidity ^0.4.4;

contract FakeMKR {
    function assert(bool condition) internal {
        if (!condition) throw;
    }

    uint                                            public  totalSupply;
    mapping (address => uint)                       public  balanceOf;
    mapping (address => mapping (address => uint))  public  allowance;

    event Transfer(
        address  indexed  owner,
        address  indexed  recipient,
        uint              value
    );

    event Approval(
        address  indexed  owner,
        address  indexed  spender,
        uint              value
    );

	function FakeMKR() {
		totalSupply = 100000000000000000000;
		balanceOf[msg.sender] = totalSupply;
	}

    function transfer(address recipient, uint value) returns (bool) {
        assert(balanceOf[msg.sender] >= value);
        balanceOf[msg.sender] -= value;
        balanceOf[recipient] += value;
        Transfer(msg.sender, recipient, value);
        return true;
    }

    function transferFrom(
        address owner, address recipient, uint value
    ) returns (bool) {
        assert(balanceOf[owner] >= value);
        assert(allowance[owner][msg.sender] >= value);
        allowance[owner][msg.sender] -= value;
        balanceOf[owner] -= value;
        balanceOf[recipient] += value;
        Transfer(owner, recipient, value);
        return true;
    }

    function approve(address spender, uint value) returns (bool) {
        allowance[msg.sender][spender] = value;
        Approval(msg.sender, spender, value);
        return true;
    }
}
