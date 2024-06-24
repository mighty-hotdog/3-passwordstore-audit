[H-1] Storing the password in-the-clear in an onchain variable `PasswordStore::s_password` makes it visible to anyone
Description: The (unencrypted, unhashed) password stored in the `PasswordStore::s_password` variable is intended to be accessible only by the owner. But since it is a variable stored onchain, it is actually visible to anyone.

Impact: The password stored by the owner is not private. Anyone can see it. This severely breaks the intended functionality of this contract.

Proof of Concept:
Step #1 - Start up Anvil
```
make anvil
```

Step #2 - Deploy PasswordStore contract onto Anvil
```
make deploy
```

Step #3 - Use `cast storage` and `cast parse-bytes32-string` to view the password
```
cast storage <address of deployed contract> 1 --rpc-url http://127.0.0.1:8545
```
Note:
    - `1` is the storage slot of `PasswordStore::s_password`
    - `http://127.0.0.1:8545` is the rpc-url of the Anvil local chain
    - <address of deployed contract> may be obtained from the Anvil console printout upon deployment

Output looks like this:
```
0x123e423wecmfwq43c4fmwfj
```

Use `cast parse-bytes32-string` to view the password in human-readable form.
```
cast parse-bytes32-string 0x123e423wecmfwq43c4fmwfj
```

Output obtained:
```
myPassword
```

Recommended Mitigation: This protocol design is unsuitable for storing private passwords onchain such as to be inaccessible to anyone other than the owner. A possible alternative is for the `PasswordStore::setPassword` function to encrypt the password with the owner's private key before storing the encrypted hash onchain. The owner may then call the `PasswordStore::getPassword` function with her private key to retrieve the password in its unencrypted form.


[H-2] Missing access controls: the `PasswordStore::setPassword` function allows anyone, not just the owner, to be able to set a new password
Description: The `PasswordStore::setPassword` function lacks the necessary access control to restrict caller access to only the owner. This makes it possible for anyone to call this function and set the password.

Impact: Anyone can set a password, or change the password set by the owner. This severely breaks the intended functionality of this contract.

Proof of Concept:
Add the following test to `PasswordStore.t.sol` and run it. This test will pass.
```javascript
    function test_nonowner_can_set_password(address randomUser) public {
        vm.assume(randomUser != owner)
        string memory expectedPassword = "myNewPassword";
        vm.prank(randomUser);
        passwordStore.setPassword(expectedPassword);
        vm.prank(owner);
        string memory actualPassword = passwordStore.getPassword();
        assertEq(actualPassword, expectedPassword);
    }
```

Recommended Mitigation: Add the necessary access controls to the `PasswordStore::setPassword` function to restrict access to only the owner.
```javascript
    function setPassword(string memory newPassword) external {
        ////////////////////////////////////////////////////////////////
        // add this line for access control
        ////////////////////////////////////////////////////////////////
        if (msg.sender != s_owner) {revert PasswordStore__NotOwner();}
        ////////////////////////////////////////////////////////////////
        s_password = newPassword;
        emit SetNetPassword();
    }
```


[I-1] Natspec-to-code mismatch: the `PasswordStore::getPassword` function does not accept a `newPassword` input parameter as the function natspec says it does
Description: As per title.

Impact: Informational.

Proof of Concept: NA

Recommended Mitigation: The code correctly implements the intended functionality of the function. Correct the natspec to align it to the code.