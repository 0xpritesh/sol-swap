// ignore_for_file: must_be_immutable

import 'package:Sol_Swap/Bloc/NFT/nft_bloc.dart';
import 'package:Sol_Swap/main.dart';
import 'package:Sol_Swap/resources/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NFT extends StatefulWidget {
  String nft_address;
  NFT({super.key, required this.nft_address});

  @override
  State<NFT> createState() => _NFTState();
}

class _NFTState extends State<NFT> {
  var data;
  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await storage.remove("PKEY");
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Congratulations, You got an NFT",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: 
        Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                       "Reward NFT",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: screenHeight(context) * 0.3,
                      width: screenWidth(context) * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage("https://bafkreigfbgrconpiypingqjps5zd4kxoqawqpijandvju347gsqnyvisci.ipfs.nftstorage.link/"),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                       "This is the reward NFT to you for making transactions on Sol Swap applicatio enjoy:)",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
      ),
    );
  }
}
