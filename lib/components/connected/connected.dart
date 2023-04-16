import 'package:Sol_Swap/Bloc/Asset/asset_bloc.dart';
import 'package:Sol_Swap/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sol_Swap/Bloc/Accounts/account_bloc.dart';
import 'package:Sol_Swap/components/screens/create_contact.dart';
import 'package:Sol_Swap/components/screens/screens.dart';
import 'package:Sol_Swap/components/screens/sign_and_send_transaction/sign_and_send_tx.dart';
import 'package:Sol_Swap/components/screens/sign_in_message/sign_in_message.dart';
import 'package:Sol_Swap/components/screens/sign_transaction/sign_tx.dart';
import 'package:Sol_Swap/providers/screen_provider.dart';
import 'package:Sol_Swap/providers/wallet_state_provider.dart';
import 'package:Sol_Swap/resources/ui_helpers.dart';
import 'package:phantom_connect/phantom_connect.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:url_launcher/url_launcher.dart';

class Connected extends StatefulWidget {
  final PhantomConnect phantomConnectInstance;
  const Connected({super.key, required this.phantomConnectInstance});

  @override
  State<Connected> createState() => _ConnectedState();
}

class _ConnectedState extends State<Connected> {
  @override
  void initState() {
    BlocProvider.of<AccountBloc>(context).add(
        getBalanceEvent(pubkey: widget.phantomConnectInstance.userPublicKey));
    storage.write("pKey", widget.phantomConnectInstance.userPublicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scrrenProvider = Provider.of<ScreenProvider>(context, listen: true);

    return Container(
        color: Colors.black, child: _buildScreen(scrrenProvider.currentScreen));
  }

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

    var launchUri = widget.phantomConnectInstance
        .generateSignAndSendTransactionUri(
            transaction: tx, redirect: '/signAndSendTransaction');
    await launchUrl(
      launchUri,
      mode: LaunchMode.externalApplication,
    );
  }

  Widget _buildScreen(Screens screen) {
    switch (screen) {
      case Screens.send:
        return SignAndSendTransactionScreen(
            phantomConnectInstance: widget.phantomConnectInstance);
      case Screens.message:
        return SignInMessageScreen(
            phantomConnectInstance: widget.phantomConnectInstance);
      case Screens.sign:
        return SignTransactionScreen(
            phantomConnectInstance: widget.phantomConnectInstance);
      case Screens.contacts:
        return CreateContactScreen(
          phantomConnectInstance: widget.phantomConnectInstance,
        );
      default:
        return Center(
            child: BlocListener<AssetBloc, AssetState>(
          listener: (context, state) {
            if (state is RequestAirdropSuccess) {
              BlocProvider.of<AccountBloc>(context).add(getBalanceEvent(
                  pubkey: widget.phantomConnectInstance.userPublicKey));
            }
          },
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is balanceLoading) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              } else if (state is balanceSuccess) {
                var amount = state.model.result!.value!.lamports;
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.1, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vSpaceMedium,
                      Text(
                        "My Address",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      vSpaceSmall,
                      Container(
                        child: Text(
                          widget.phantomConnectInstance.userPublicKey,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      vSpaceMedium,
                      vSpaceMedium,
                      Text(
                        "Total Balance",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
                        child: Text(
                          (amount! / lamportsPerSol)
                                  .toString()
                                  .substring(0, 6) +
                              " Sol",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                      vSpaceMedium,
                      Text(
                        "rentEpoch",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      vSpaceSmall,
                      Text(
                          "(It is fee for the resource consumption on network.)",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Container(
                        child: Text(
                          state.model.result!.value!.rentEpoch.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                      vSpaceMedium,
                      Text(
                        "Executable",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
                        child: Text(
                          state.model.result!.value!.executable.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                      vSpaceMedium,
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AssetBloc>(context).add(
                                RequestAirDropEvent(
                                    pubKey: widget
                                        .phantomConnectInstance.userPublicKey));
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(screenWidth(context) * 0.5, 50), backgroundColor: Colors.white),
                          child: const Text(
                            "Air Drop 1 Sol",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ));
    }
  }
}
