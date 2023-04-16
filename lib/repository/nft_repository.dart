import 'dart:convert';
import 'dart:developer';

import 'package:Sol_Swap/models/claim_model.dart';
import 'package:Sol_Swap/models/nft.dart';
import 'package:Sol_Swap/utils/logger.dart';
import 'package:http/http.dart' as http;

const String url = 'http://192.168.0.102:3000/';

Future<claim_model> claimNFT({required String walletAddress}) async {
  log(walletAddress);
  final response = await http.get(
    Uri.parse("${url}claim?address=${walletAddress}"),
  );
  logger.wtf(response.statusCode);
  logger.wtf(response.body);
  if (response.statusCode == 200) {
    return claim_model.fromJson(json.decode(response.body));
  }
  throw UnimplementedError();
}

Future<NFT_response> getNFT({required String contractAddress}) async {
  final response =
      await http.get(Uri.parse("${url}nft?address=${contractAddress}"));
  logger.wtf(response.body);

  if (response.statusCode == 200) {
    return NFT_response.fromJson(json.decode(response.body));
  }
  throw UnimplementedError();
}
