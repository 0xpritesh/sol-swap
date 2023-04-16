import 'dart:convert';

import 'package:bs58/bs58.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Sol_Swap/components/screens/transaction_status.dart';
import 'package:Sol_Swap/utils/logger.dart';
import 'package:solana/solana.dart';

class SendTxScreen extends StatefulWidget {
  final String transaction;
  const SendTxScreen({super.key, required this.transaction});

  @override
  State<SendTxScreen> createState() => _SendTxScreenState();
}

class _SendTxScreenState extends State<SendTxScreen> {
  final rcpClient = RpcClient('https://api.devnet.solana.com');

  _sendTransactionToBlockchain(String tx, BuildContext context) async {
    var transaction = base64.encode(
      Uint8List.fromList(
        base58.decode(tx),
      ),
    );
    logger.e(transaction);

    final TransactionId signature = await rcpClient.sendTransaction(
      transaction,
      preflightCommitment: Commitment.processed,
    );

    logger.e("Signature was $signature");
    if (!mounted) return;

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionStatus(
          signature: signature,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Transaction"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              _sendTransactionToBlockchain(widget.transaction, context);
            },
            child: const Text("Send Transaction")),
      ),
    );
  }
}
