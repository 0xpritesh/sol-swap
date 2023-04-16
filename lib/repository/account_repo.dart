import 'dart:convert';

import 'package:Sol_Swap/models/air_drop_response.dart';
import 'package:Sol_Swap/models/all_assets.dart';
import 'package:Sol_Swap/models/asset_chart.dart';
import 'package:Sol_Swap/models/asset_response.dart';
import 'package:Sol_Swap/models/balance_response.dart';
import 'package:Sol_Swap/models/largest_account_response.dart';
import 'package:Sol_Swap/models/total_supply_response.dart';
import 'package:http/http.dart' as http;

abstract class AccountRepo {
  Future<BalanceResponse> getBalance({required String pubKey});
  Future<largetsAccountResponse> getLargestAccount();
  Future<TotalSupplyResponse> getTotalSupply();
  Future<AssetPriceResponse> getChart({required String coinName});
  Future<AllAssets> getAllAssets();
  Future<AirDropResponse> requestAirDrop({required String pubKey});
}

class AccountIMPL extends AccountRepo {
  @override
  Future<BalanceResponse> getBalance({required String pubKey}) async {
    var data = json.encode({
      "jsonrpc": "2.0",
      "id": 1,
      "method": "getAccountInfo",
      "params": [
        pubKey,
      ]
    });
    final response = await http.post(Uri.parse("https://api.devnet.solana.com"),
        headers: {'Content-Type': 'application/json'}, body: data);
    print(">>>>>>>>>>>>>>>>${response.statusCode}");
    print(">>>>>>>>>>>>>>>>${data}");
    print(">>>>>>>>>>>>>>>>${response.body}");
    if (response.statusCode == 200) {
      return BalanceResponse.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  @override
  Future<largetsAccountResponse> getLargestAccount() async {
    var data = json
        .encode({"jsonrpc": "2.0", "id": 1, "method": "getLargestAccounts"});
    final response = await http.post(
        Uri.parse("https://api.mainnet-beta.solana.com"),
        headers: {'Content-Type': 'application/json'},
        body: data);
    print(">>>>>>>>>>>>>>>>${response.statusCode}");
    print(">>>>>>>>>>>>>>>>${data}");
    print(">>>>>>>>>>>>>>>>${response.body}");
    if (response.statusCode == 200) {
      return largetsAccountResponse.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  @override
  Future<TotalSupplyResponse> getTotalSupply() async {
    var data = json.encode({"jsonrpc": "2.0", "id": 1, "method": "getSupply"});
    final response = await http.post(
        Uri.parse("https://api.mainnet-beta.solana.com"),
        headers: {'Content-Type': 'application/json'},
        body: data);
    print(">>>>>>>>>>>>>>>>${response.statusCode}");
    print(">>>>>>>>>>>>>>>>${data}");
    print(">>>>>>>>>>>>>>>>${response.body}");
    if (response.statusCode == 200) {
      return TotalSupplyResponse.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  @override
  Future<AssetPriceResponse> getChart({required String coinName}) async {
    final response = await http
        .get(Uri.parse("https://api.coincap.io/v2/assets/$coinName"), headers: {
      "Content-Type": "application/json",
    });
    print(">>>>>>>>>>>>>>>>>>${"https://api.coincap.io/v2/assets/$coinName"}");
    print(">>>>>>>>>>>>>>>>>>${response.request?.method}");
    print(">>>>>>>>>>>>>>>>>>Request-body$coinName");
    print(">>>>>>>>>>>>>>>>>>${response.statusCode}");
    print(">>>>>>>>>>>>>>>>>>Response_body${response.body}");
    if (response.statusCode == 200) {
      print(response.body);
      return AssetPriceResponse.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  @override
  Future<AllAssets> getAllAssets() async {
    final response =
        await http.get(Uri.parse("https://api.coincap.io/v2/assets"), headers: {
      "Content-Type": "application/json",
    });
    print(">>>>>>>>>>>>>>>>>>${"https://api.coincap.io/v2/assets"}");
    print(">>>>>>>>>>>>>>>>>>${response.request?.method}");
    print(">>>>>>>>>>>>>>>>>>${response.statusCode}");
    print(">>>>>>>>>>>>>>>>>>Response_body${response.body}");
    if (response.statusCode == 200) {
      print(response.body);
      return AllAssets.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  @override
  Future<AirDropResponse> requestAirDrop({required String pubKey}) async {
    var data = json.encode({
      "jsonrpc": "2.0",
      "id": 1,
      "method": "requestAirdrop",
      "params": [pubKey, 1000000000]
    });
    final response = await http
        .post(Uri.parse("https://api.devnet.solana.com"), body: data, headers: {
      "Content-Type": "application/json",
    });
    print(">>>>>>>>>>>>>>>>>>${"https://api.devnet.solana.com"}");
    print(">>>>>>>>>>>>>>>>>>${response.request?.method}");
    print(">>>>>>>>>>>>>>>>>>${response.statusCode}");
    print(">>>>>>>>>>>>>>>>>>Response_body${response.body}");
    if (response.statusCode == 200) {
      print(response.body);
      return AirDropResponse.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }
}

Future<AssetResponse> getCurrentPrice() async {
  final response = await http
      .get(Uri.parse("https://api.coincap.io/v2/assets/solana"), headers: {
    "Content-Type": "application/json",
  });
  print(">>>>>>>>>>>>>>>>>>${"https://api.coincap.io/v2/assets/solana"}");
  print(">>>>>>>>>>>>>>>>>>${response.request?.method}");
  print(">>>>>>>>>>>>>>>>>>${response.statusCode}");
  print(">>>>>>>>>>>>>>>>>>Response_body${response.body}");
  if (response.statusCode == 200) {
    print(response.body);
    return AssetResponse.fromJson(jsonDecode(response.body));
  }
  throw UnimplementedError();
}
