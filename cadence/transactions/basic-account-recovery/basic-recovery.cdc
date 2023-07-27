#allowAccountLinking
import AccountRecovery from "../../contracts/account-recovery.cdc"
import BasicAccountRecovery from "../../contracts/basic-account-recovery.cdc"

transaction(
  account: Address,
  newPublicKey: String,
  newPublicKeySigAlgorithm: UInt8,
  newPublicKeyHashAlgorithm: UInt8
) {

  let recoveryManagerRef: &{AccountRecovery.RecoveryManagerPublic}

  prepare() {
    let targetAccount = getAccount(account)

    let accountRecoveryCap = targetAccount.getCapability<&{AccountRecovery.RecoveryManagerPublic}>(BasicAccountRecovery.BasicAccountRecoveryManagerPublicPath)

    self.recoveryManagerRef = accountRecoveryCap.borrow()!
  }

  execute {
    self.recoveryManagerRef.recover(
      newPublicKey: newPublicKey,
      newPublicKeySigAlgorithm: newPublicKeySigAlgorithm,
      newPublicKeyHashAlgorithm: newPublicKeyHashAlgorithm,
      data: nil
    )
  }
}