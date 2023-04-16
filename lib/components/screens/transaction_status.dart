import 'package:Sol_Swap/components/screens/nft_page.dart';
import 'package:Sol_Swap/main.dart';
import 'package:Sol_Swap/repository/nft_repository.dart';
import 'package:Sol_Swap/resources/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:Sol_Swap/utils/helpers.dart';
import 'package:Sol_Swap/utils/logger.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionStatus extends StatefulWidget {
  final String signature;
  const TransactionStatus({super.key, required this.signature});

  @override
  State<TransactionStatus> createState() => _TransactionStatusState();
}

class _TransactionStatusState extends State<TransactionStatus> {
  //
  SignatureStatus? _transactionStatus;
  bool isConfirmed = false;
  String wallet = storage.read("pKey");

  RpcClient rpcClient = RpcClient("https://api.devnet.solana.com");
  TextStyle textStyle = const TextStyle(
      color: Colors.green, fontSize: 22, fontWeight: FontWeight.w900);

  getTransactionStatus() async {
    logger.wtf("Hello Status ${widget.signature}");
    while (!isConfirmed) {
      List<SignatureStatus?> status =
          await rpcClient.getSignatureStatuses([widget.signature]);
      try {
        logger.e(status);
        setState(() {
          _transactionStatus = status[0]!;
        });
        logger.i(_transactionStatus?.confirmations);
        logger.i(_transactionStatus?.confirmationStatus);

        if (_transactionStatus?.confirmationStatus == Commitment.finalized) {
          setState(() {
            isConfirmed = true;
            return;
          });
        }
      } catch (e) {
        logger.e(e);
      }
      await delay(100);
    }
  }

  @override
  void initState() {
    getTransactionStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Signature Status'),
          centerTitle: true,
        ),
        body: !isConfirmed
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Confirmations In: ${_transactionStatus?.confirmations ?? 0} Seconds",
                        style: textStyle,
                      ),
                    ]),
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight(context) * 0.1),
                  child: Column(
                    children: [
                      Text(
                        "Status: ${_transactionStatus?.confirmationStatus}",
                        style: textStyle,
                      ),
                      vSpaceSmall,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(screenWidth(context) * 0.5, 50), backgroundColor: Colors.white),
                        onPressed: () {
                          launchUrl(
                              Uri.parse(
                                  "https://explorer.solana.com/tx/${widget.signature}?cluster=devnet"),
                              mode: LaunchMode.externalApplication);
                        },
                        child: const Text(
                          "View it on Solana Explorer",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      vSpaceSmall,
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async {
                            // claimNFT(walletAddress: wallet).then((value) {
                            //   if (value.claimedAddresses != null) {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => NFT(
                            //                 nft_address: value.claimedAddresses
                            //                     .toString())));
                            //   }
                            // });
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> NFT(nft_address: "")), (route) => false);
                          },
                          child: Text("Check Rewards")),
                    ],
                  ),
                ),
              ));
  }
}
