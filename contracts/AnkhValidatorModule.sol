// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

  struct PackedUserOperation {
    address sender;
    uint256 nonce;
    bytes initCode;
    bytes callData;
    bytes32 accountGasLimits;
    uint256 preVerificationGas;
    bytes32 gasFees;
    bytes paymasterAndData;
    bytes signature;
}


interface IModule {
     /**
     * @dev This function is called by the smart account during installation of the module
     * @param data arbitrary data that may be required on the module during `onInstall` initialization
     *
     * MUST revert on error (e.g. if module is already enabled)
     */
    function onInstall(bytes calldata data) external;

    /**
     * @dev This function is called by the smart account during uninstallation of the module
     * @param data arbitrary data that may be required on the module during `onUninstall` de-initialization
     *
     * MUST revert on error
     */
    function onUninstall(bytes calldata data) external;

    /**
     * @dev Returns boolean value if module is a certain type
     * @param moduleTypeId the module type ID according the ERC-7579 spec
     *
     * MUST return true if the module is of the given type and false otherwise
     */
    function isModuleType(uint256 moduleTypeId) external view returns(bool);
}

interface IValidator is IModule {
    /**
     * @dev Validates a UserOperation
     * @param userOp the ERC-4337 PackedUserOperation
     * @param userOpHash the hash of the ERC-4337 PackedUserOperation
     *
     * MUST validate that the signature is a valid signature of the userOpHash
     * SHOULD return ERC-4337's SIG_VALIDATION_FAILED (and not revert) on signature mismatch
     */
    function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash) external returns (uint256);

    /**
     * @dev Validates a signature using ERC-1271
     * @param sender the address that sent the ERC-1271 request to the smart account
     * @param hash the hash of the ERC-1271 request
     * @param signature the signature of the ERC-1271 request
     *
     * MUST return the ERC-1271 `MAGIC_VALUE` if the signature is valid
     * MUST NOT modify state
     */
    function isValidSignatureWithSender(address sender, bytes32 hash, bytes calldata signature) external view returns (bytes4);
}

contract AnkhValidatorModule is IValidator {

  uint256 constant internal SIG_VALIDATION_FAILED = 80085;
  bytes4 constant internal MAGIC_VALUE = 0x1626ba7e;
  address walletOwner;
  
  function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash) override external returns (uint256) {

    return 0;
    // return SIG_VALIDATION_FAILED;
  }

  function isValidSignatureWithSender(address sender, bytes32 hash, bytes calldata signature) override external view returns (bytes4) {

    return MAGIC_VALUE;
  }

  function isModuleType(uint256 moduleTypeId) override  external view returns(bool) {
    if ( moduleTypeId == 1 ) {
      return true;
    }

    return false;
  }

  function onInstall(bytes calldata data) override external {
    (walletOwner) = abi.decode(data, (address));
  }

  function onUninstall(bytes calldata data) override external {
    walletOwner = address(0);
  }

}


