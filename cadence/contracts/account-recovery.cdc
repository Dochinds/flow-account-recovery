pub contract AccountRecovery {
  pub resource interface RecoveryManagerPublic {
     pub fun recover(newPublicKey: String, newPublicKeySigAlgorithm: UInt8, newPublicKeyHashAlgorithm: UInt8, data: AnyStruct?)
  }
 
  init() {
  }
}