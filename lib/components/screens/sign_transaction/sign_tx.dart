import 'package:Sol_Swap/resources/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:Sol_Swap/components/styled_text_feild.dart';
import 'package:Sol_Swap/providers/wallet_state_provider.dart';
import 'package:phantom_connect/phantom_connect.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:url_launcher/url_launcher.dart';

class SignTransactionScreen extends StatefulWidget {
  final PhantomConnect phantomConnectInstance;
  const SignTransactionScreen(
      {super.key, required this.phantomConnectInstance});

  @override
  State<SignTransactionScreen> createState() => _SignTransactionScreenState();
}

class _SignTransactionScreenState extends State<SignTransactionScreen> {
  // User input
  TextEditingController walletAddressController = TextEditingController();
  TextEditingController solAmountController = TextEditingController();

  signAndSendTransaction(WalletStateProvider walletStateProvider) async {
    int amount =
        ((double.parse(solAmountController.text)) * lamportsPerSol).toInt();
    final transferIx = SystemInstruction.transfer(
        fundingAccount: Ed25519HDPublicKey.fromBase58(
            widget.phantomConnectInstance.userPublicKey),
        recipientAccount:
            Ed25519HDPublicKey.fromBase58(walletAddressController.text),
        lamports: amount);
    final message = Message.only(transferIx);
    final blockhash = await RpcClient('https://api.devnet.solana.com')
        .getRecentBlockhash()
        .then((b) => b.blockhash);
    final compiled = message.compile(recentBlockhash: blockhash);

    final tx = SignedTx(
      messageBytes: compiled.data,
      signatures: [
        Signature(
          List.filled(64, 0),
          publicKey: Ed25519HDPublicKey.fromBase58(
              widget.phantomConnectInstance.userPublicKey),
        )
      ],
    ).encode();

    var launchUri = widget.phantomConnectInstance.generateSignTransactionUri(
        transaction: tx, redirect: '/signTransaction');
    await launchUrl(
      launchUri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final walletState =
        Provider.of<WalletStateProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) * 0.05),
                child: Column(
                  children: [
                    vSpaceMedium,
                    styledTextFeild(
                        walletAddressController,
                        "User Wallet Address",
                        TextInputType.name,
                        false,
                        Icons.wallet),
                    const SizedBox(height: 10),
                    styledTextFeild(solAmountController, "Enter Amount in Sol",
                        TextInputType.number, false, Icons.money),
                    const SizedBox(height: 10),
                    vSpaceMassive,
                    vSpaceMassive,
                    vSpaceMassive,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(screenWidth(context), 50), backgroundColor: Colors.white),
                      onPressed: () {
                        signAndSendTransaction(walletState);
                      },
                      child: const Text(
                        "Sign Transaction",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
