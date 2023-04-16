import 'package:Sol_Swap/Bloc/Asset/asset_bloc.dart';
import 'package:Sol_Swap/Bloc/NFT/nft_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sol_Swap/Bloc/Accounts/account_bloc.dart';
import 'package:Sol_Swap/providers/screen_provider.dart';
import 'package:Sol_Swap/providers/wallet_state_provider.dart';
import 'package:Sol_Swap/repository/account_repo.dart';
import 'package:Sol_Swap/views/home.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';

final storage = GetStorage();

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletStateProvider()),
        ChangeNotifierProvider(create: (_) => ScreenProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NftBloc(),
            child: Container(),
          ),
          BlocProvider(
              create: (context) => AccountBloc(accountRepo: AccountIMPL())),
          BlocProvider(
            create: (context) => AssetBloc(assetRepo: AccountIMPL()),
            child: Container(),
          )
        ],
        child: GetMaterialApp(
          title: 'Phantom Dart Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black,
          ),
          home: const Home(),
        ));
  }
}
