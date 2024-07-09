// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PackedUserOperation} from "kernel/src/interfaces/PackedUserOperation.sol";
import {IValidator} from "kernel/src/interfaces/IERC7579Modules.sol";

import {
  SIG_VALIDATION_FAILED_UINT,
  SIG_VALIDATION_SUCCESS_UINT,
  ERC1271_MAGICVALUE,
  MODULE_TYPE_VALIDATOR
} from "kernel/src/types/Constants.sol";

contract AnkhValidatorModule is IValidator {

  // ERC1271_MAGICVALUE = 0x1626ba7e;
  address walletOwner;

  /**
    * @dev This function is called by the smart account during installation of the module
  * @param data arbitrary data that may be required on the module during `onInstall` initialization
  *
    * MUST revert on error (e.g. if module is already enabled)
  */
  function onInstall(bytes calldata data) override payable external {
    (walletOwner) = abi.decode(data, (address));
  }

  /**
    * @dev This function is called by the smart account during uninstallation of the module
  * @param data arbitrary data that may be required on the module during `onUninstall` de-initialization
  *
    * MUST revert on error
  */
  function onUninstall(bytes calldata data) override payable external {
    walletOwner = address(0);
  }

  /**
    * @dev Validates a UserOperation
  * @param userOp the ERC-4337 PackedUserOperation
  * @param userOpHash the hash of the ERC-4337 PackedUserOperation
  *
    * MUST validate that the signature is a valid signature of the userOpHash
  * SHOULD return ERC-4337's SIG_VALIDATION_FAILED (and not revert) on signature mismatch
  */
  function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash) override payable external returns (uint256) {

    return SIG_VALIDATION_SUCCESS_UINT;
    // return SIG_VALIDATION_FAILED_UINT;
  }

  /**
    * @dev Validates a signature using ERC-1271
  * @param sender the address that sent the ERC-1271 request to the smart account
  * @param hash the hash of the ERC-1271 request
  * @param signature the signature of the ERC-1271 request
  *
    * MUST return the ERC-1271 `ERC1271_MAGICVALUE` if the signature is valid
  * MUST NOT modify state
  */
  function isValidSignatureWithSender(address sender, bytes32 hash, bytes calldata signature) override external view returns (bytes4) {

    return ERC1271_MAGICVALUE;
  }

  /**
    * @dev Returns boolean value if module is a certain type
  * @param moduleTypeId uint256 the module type ID according the ERC-7578 spec
  *
    * MUST return true if the module is of the given type and false otherwise
  */
  function isModuleType(uint256 moduleTypeId) override  external view returns(bool) {
    if ( moduleTypeId == MODULE_TYPE_VALIDATOR ) {
      return true;
    }

    return false;
  }

  /**
    * @dev Returns if the module was already initialized for a provided smartaccount
  */
  function isInitialized(address smartAccount) external view returns (bool) {
    return (walletOwner) == smartAccount;
  }
}


