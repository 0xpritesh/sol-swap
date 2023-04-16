import 'package:Sol_Swap/Bloc/Asset/asset_bloc.dart';
import 'package:Sol_Swap/repository/account_repo.dart';
import 'package:flutter/material.dart';
import 'package:Sol_Swap/resources/ui_helpers.dart';
import 'package:Sol_Swap/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phantom_connect/phantom_connect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotConnected extends StatefulWidget {
  final PhantomConnect phantomConnectInstance;
  const NotConnected({super.key, required this.phantomConnectInstance});

  @override
  State<NotConnected> createState() => _NotConnectedState();
}

class _NotConnectedState extends State<NotConnected> {
  connectWallet() async {
    Uri launchUri = widget.phantomConnectInstance
        .generateConnectUri(cluster: 'devnet', redirect: '/connected');
    logger.d(launchUri);
    await launchUrl(
      launchUri,
      mode: LaunchMode.externalApplication,
    );
  }

  List<FaIcon> icons = [
    FaIcon(
      FontAwesomeIcons.bitcoin,
      color: Colors.white,
      size: 30,
    ),
    FaIcon(
      FontAwesomeIcons.ethereum,
      color: Colors.white,
      size: 30,
    ),
    FaIcon(
      FontAwesomeIcons.circleDollarToSlot,
      color: Colors.white,
      size: 30,
    ),
    FaIcon(
      FontAwesomeIcons.b,
      color: Colors.white,
      size: 30,
    ),
    FaIcon(
      FontAwesomeIcons.dollarSign,
      color: Colors.white,
      size: 30,
    ),
  ];

  String? marketCap, dayvolume, Solsway, change24h, priceUSD, vWap24h;

  getSolana() async {
    await getCurrentPrice().then((value) {
      marketCap = value.data?.marketCapUsd.toString();
      dayvolume = value.data?.volumeUsd24Hr.toString();
      Solsway = value.data?.supply.toString();
      change24h = value.data?.changePercent24Hr.toString();
      priceUSD = value.data?.priceUsd.toString();
      vWap24h = value.data?.vwap24Hr.toString();
    });
  }

  @override
  void initState() {
    getSolana();
    BlocProvider.of<AssetBloc>(context).add(GetAllAssets());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          connectWallet();
        },
        child: Icon(
          Icons.wallet_rounded,
          size: 30,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Sol Swap'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          if (state is AllAssetsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is AllAssetsSuccess) {
            var data = state.model.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: deviceHeight(context) * 0.02,
                        bottom: deviceHeight(context) * 0.015),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Market Cap',
                            style: TextStyle(
                              color: Colors.grey[500],
                              //Color(0xff3a3841),
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            '24h Volume',
                            style: TextStyle(
                              color: Colors.grey[500],
                              //Color(0xff3a3841),
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            'SOL Sway ',
                            style: TextStyle(
                              color: Colors.grey[500],
                              //Color(0xff3a3841),
                              fontSize: 17,
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: deviceHeight(context) * 0.018,
                        bottom: deviceHeight(context) * 0.015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "\$${marketCap?.substring(0, 1) ?? "5"} B",
                              style: TextStyle(
                                  color: Color(0xffd0d1d2), fontSize: 25),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "\$${dayvolume?.substring(0, 1)} B",
                              style: TextStyle(
                                  color: Color(0xffd0d1d2), fontSize: 25),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "\$${Solsway?.substring(0, 1)} B",
                              style: TextStyle(
                                  color: Color(0xffd0d1d2), fontSize: 25),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight(context) * 0.018,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.candlestick_chart,
                            color: double.parse(change24h ?? "0") >= 0
                                ? Color(0xff189f59)
                                : Colors.red,
                            size: 18,
                          ),
                          Text(
                            '${change24h?.substring(0, 4)}%',
                            style: TextStyle(
                              color: double.parse(change24h ?? "5.0") >= 0
                                  ? Color(0xff189f59)
                                  : Colors.red,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.candlestick_chart,
                            color: double.parse(priceUSD ?? "10") >= 0
                                ? Color(0xff189f59)
                                : Colors.red,
                            size: 18,
                          ),
                          Text(
                            '${priceUSD.toString().substring(0, 2)}%',
                            style: TextStyle(
                              color: double.parse(priceUSD ?? "10") >= 0
                                  ? Color(0xff189f59)
                                  : Colors.red,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.candlestick_chart,
                            color: double.parse(vWap24h ?? "-2") >= 0
                                ? Color(0xff189f59)
                                : Colors.red,
                            size: 18,
                          ),
                          Text(
                            '${vWap24h?.substring(0, 2)}%',
                            style: TextStyle(
                              color: double.parse(vWap24h ?? "5") >= 0
                                  ? Color(0xff189f59)
                                  : Colors.red,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: deviceWidth(context) * 0.8,
                    child: const Divider(
                      height: 80,
                      thickness: 2,
                      color: Color(0xffd0d1d2),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => ChartPage(
                          //           coinName: data.elementAt(index).name,
                          //         )));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth(context) * 0.02,
                              vertical: deviceHeight(context) * 0.015),
                          child: Row(children: [
                            CircleAvatar(
                                radius: deviceHeight(context) * 0.04,
                                backgroundColor: Colors.black,
                                child: icons.elementAt(index)),
                            Container(
                              width: deviceWidth(context) * 0.27,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    data?.elementAt(index).name.toString() ??
                                        "",
                                    style: TextStyle(
                                        color: Color(0xffd0d1d2), fontSize: 18),
                                  ),
                                  Text(
                                    data?.elementAt(index).symbol.toString() ??
                                        "",
                                    style: TextStyle(
                                        color: Color(0xff5a5b62), fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: deviceWidth(context) * 0.27,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "\$${data?.elementAt(index).priceUsd?.substring(0, 7)}",
                                  style: TextStyle(
                                      color: Color(0xffd0d1d2), fontSize: 18),
                                ),
                                Text(
                                  '${data?.elementAt(index).changePercent24Hr?.substring(0, 5)}%',
                                  style: TextStyle(
                                    color: double.parse(data
                                                    ?.elementAt(index)
                                                    .changePercent24Hr
                                                    .toString() ??
                                                "") >=
                                            0
                                        ? Color(0xff189f59)
                                        : Colors.red,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
