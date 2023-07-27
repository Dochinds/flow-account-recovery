#allowAccountLinking
import AccountRecovery from "../../contracts/account-recovery.cdc"
import BasicAccountRecovery from "../../contracts/basic-account-recovery.cdc"

transaction() {
  prepare(account: AuthAccount) {
    if !account.getCapability<&AuthAccount>(BasicAccountRecovery.BasicAccountRecoveryLinkedAccountPrivatePath).check() {
        account.unlink(BasicAccountRecovery.BasicAccountRecoveryLinkedAccountPrivatePath)
        
        var accountCap: Capability<&AuthAccount> = account.linkAccount(BasicAccountRecovery.BasicAccountRecoveryLinkedAccountPrivatePath)!

        var accountRecoveryManager <- BasicAccountRecovery.createBasicRecoveryManager(acct: accountCap)
        account.save(<-accountRecoveryManager, to: BasicAccountRecovery.BasicAccountRecoveryManagerStoragePath)

        account.link<&BasicAccountRecovery.BasicRecoveryManager{AccountRecovery.RecoveryManagerPublic}>(
            BasicAccountRecovery.BasicAccountRecoveryManagerPublicPath,
            target: BasicAccountRecovery.BasicAccountRecoveryManagerStoragePath
        )
    }
  }
}