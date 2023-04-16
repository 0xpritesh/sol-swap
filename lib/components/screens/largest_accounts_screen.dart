import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sol_Swap/Bloc/Accounts/account_bloc.dart';
import 'package:Sol_Swap/resources/ui_helpers.dart';
import 'package:solana/solana.dart';

class LargestAccountScreen extends StatefulWidget {
  const LargestAccountScreen({super.key});

  @override
  State<LargestAccountScreen> createState() => _LargestAccountScreenState();
}

class _LargestAccountScreenState extends State<LargestAccountScreen> {
  @override
  void initState() {
    BlocProvider.of<AccountBloc>(context).add(TotalSupplyEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Largest Holding Accounts"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is LargestAccuntLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LargestAccountSuccess) {
                // BlocProvider.of<AccountBloc>(context).add(TotalSupplyEvent());
                var data = state.model.result?.value;
                return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vSpaceMedium,
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: (data!.elementAt(index).lamports! /
                                            lamportsPerSol)
                                        .toString()
                                        .substring(0, 7),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                TextSpan(
                                    text: ' Sol',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                TextSpan(text: ' world!'),
                              ],
                            ),
                          ),
                          vSpaceTiny,
                          Text((data.elementAt(index).address).toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      );
                    });
              } else if (state is TotalSupplySuccess) {
                return Container(
                  child: Text(
                      state.model.result?.value?.circulating.toString() ?? "",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
