import 'package:Sol_Swap/resources/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:Sol_Swap/providers/wallet_state_provider.dart';
import 'package:Sol_Swap/utils/logger.dart';
import 'package:phantom_connect/phantom_connect.dart';
import 'package:provider/provider.dart';

class SignatureVerifyScreen extends StatefulWidget {
  final String signature;
  final PhantomConnect phantomConnectInstance;
  const SignatureVerifyScreen(
      {super.key,
      required this.signature,
      required this.phantomConnectInstance});

  @override
  State<SignatureVerifyScreen> createState() => _SignatureVerifyScreenState();
}

class _SignatureVerifyScreenState extends State<SignatureVerifyScreen> {
  //state variables
  bool isVerfied = false;
  bool isVerifying = true;

  @override
  void initState() {
    _verifySignature(context);
    super.initState();
  }

  _verifySignature(BuildContext context) async {
    final walletState =
        Provider.of<WalletStateProvider>(context, listen: false);
    // var nonce = walletState.generateNoce();

    bool verify = await widget.phantomConnectInstance
        .isValidSignature(widget.signature, walletState.getNonce);
    logger.i(verify);
    setState(() {
      isVerifying = false;
      isVerfied = verify;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature Verification'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isVerifying
              ? [
                  const Text("Verifying signature..."),
                  TextButton(
                    onPressed: () {
                      _verifySignature(context);
                    },
                    child: const Text("Cancel"),
                  )
                ]
              : !isVerfied
                  ? [
                      const Text(
                        "Signature verification failed. \nPlease try again.",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ]
                  : [
                       Text(
                        "Signature verified",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    
                      Image.asset(solana)
                    ],
        ),
      ),
    );
  }
}
