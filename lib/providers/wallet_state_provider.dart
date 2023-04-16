import 'package:flutter/material.dart';
import 'package:pinenacl/ed25519.dart';

class WalletStateProvider extends ChangeNotifier {
  bool _connected = false;
  Uint8List? nonce;

  bool get isConnected => _connected;

  void updateConnection(bool state) {
    _connected = state;
    notifyListeners();
  }

  Uint8List generateNoce() {
    nonce = PineNaClUtils.randombytes(24);
    return nonce!;
  }

  Uint8List get getNonce => nonce!;
}
