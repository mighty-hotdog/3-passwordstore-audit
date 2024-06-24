// SPDX-License-Identifier: MIT
pragma solidity 0.8.18; // @qn is this correct version of Solidity

/*
 * @author not-so-secure-dev
 * @title PasswordStore
 * @notice This contract allows you to store a private password that others won't be able to see. 
 * You can update your password at any time.
 */
contract PasswordStore {
    error PasswordStore__NotOwner();

    // @audit all onchain variables are visible no matter their visibility in Solidity
    address private s_owner;    // @info storage slot 0
    string private s_password;  // @info storage slot 1

    event SetNetPassword();

    constructor() {
        s_owner = msg.sender;
    }

    /*
     * @notice This function allows only the owner to set a new password.
     * @param newPassword The new password to set.
     */
    // @audit missing access control: anyone can set a new password
    function setPassword(string memory newPassword) external {
        s_password = newPassword;
        emit SetNetPassword();
    }

    /*
     * @notice This allows only the owner to retrieve the password.
     * @param newPassword The new password to set.
     */
    // @audit natspec-code mismatch: function does not accept input parameter `newPassword` 
    //  as described in the natspec
    function getPassword() external view returns (string memory) {
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        return s_password;
    }
}
