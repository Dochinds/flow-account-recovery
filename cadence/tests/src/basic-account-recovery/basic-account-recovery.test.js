import path from "path";
import {
  init,
  emulator,
  shallPass,
  sendTransaction,
  getAccountAddress,
  deployContractByName,
  createAccount,
  executeScript,
} from "@onflow/flow-js-testing";

const CADENCE_PATH = "../../../";

const setupBasicRecoveryManagerTransactionName =
  "transactions/basic-account-recovery/setup-basic-recovery-manager";
const basicRecoveryTransactionName =
  "transactions/basic-account-recovery/basic-recovery";

describe("interactions - sendTransaction", () => {
  beforeEach(async () => {
    const basePath = path.resolve(__dirname, CADENCE_PATH);
    await init(basePath);
    await emulator.start();
    const to = await getAccountAddress("Alice");
    const accountRecoveryContractName = "AccountRecovery";
    const basicAccountRecoveryContractName = "BasicAccountRecovery";

    const [deploymentResult1, error1] = await deployContractByName({
      to,
      name: accountRecoveryContractName,
    });

    const [deploymentResult2, error2] = await deployContractByName({
      to,
      name: basicAccountRecoveryContractName,
    });
    return;
  });

  afterEach(async () => {
    await emulator.stop();
    return;
  });

  test("setup basic recovery manager", async () => {
    const Alice = await getAccountAddress("Alice");

    const [tx, error] = await shallPass(
      sendTransaction({
        name: setupBasicRecoveryManagerTransactionName,
        args: [],
        signers: [Alice],
      })
    );

    expect(true).toBe(true);
  });

  test("do basic recovery", async () => {
    const Alice = await getAccountAddress("Alice");

    const newPublicKey = "01b2"
    const newPublicKeySigAlgorithm = 0
    const newPublicKeyHashAlgorithm = 1

    const [tx, error] = await shallPass(
      sendTransaction({
        name: basicRecoveryTransactionName,
        args: [newPublicKey, newPublicKeySigAlgorithm, newPublicKeyHashAlgorithm],
        signers: [Alice],
      })
    );

    expect(true).toBe(true);
  });
});