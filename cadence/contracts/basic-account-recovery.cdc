import AccountRecovery from "./account-recovery.cdc"

pub contract BasicAccountRecovery {
  pub let BasicAccountRecoveryLinkedAccountPrivatePath: PrivatePath
  pub let BasicAccountRecoveryManagerStoragePath: StoragePath
  pub let BasicAccountRecoveryManagerPublicPath: PublicPath

  pub resource BasicRecoveryManager: AccountRecovery.RecoveryManagerPublic {
    /// AuthAccount capability
    access(self) var acct: Capability<&AuthAccount>

    pub fun recover(newPublicKey: String, newPublicKeySigAlgorithm: UInt8, newPublicKeyHashAlgorithm: UInt8, data: AnyStruct?) {
      // Do Recovery
      var pk = PublicKey(
          publicKey: newPublicKey.decodeHex(),
          signatureAlgorithm: SignatureAlgorithm(rawValue: newPublicKeySigAlgorithm)!
      )

      self.acct.borrow()!.keys.add(
        publicKey: pk,
        hashAlgorithm: HashAlgorithm(rawValue: newPublicKeyHashAlgorithm)!,
        weight: 1000.0
      )

    }

    init(acct: Capability<&AuthAccount>) {
      self.acct = acct
    }
  }

  pub fun createBasicRecoveryManager(acct: Capability<&AuthAccount>): @BasicAccountRecovery.BasicRecoveryManager {
    return <- create BasicRecoveryManager(acct: acct)
  }

  init() {
    self.BasicAccountRecoveryLinkedAccountPrivatePath = PrivatePath(identifier: "BasicAccountRecoveryLinkedAccountPrivatePath")!
    self.BasicAccountRecoveryManagerStoragePath = StoragePath(identifier: "BasicAccountRecoveryManagerStoragePath")!
    self.BasicAccountRecoveryManagerPublicPath = PublicPath(identifier: "BasicAccountRecoveryManagerPublicPath")!
  }
}