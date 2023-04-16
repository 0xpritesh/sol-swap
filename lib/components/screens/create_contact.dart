import 'package:Sol_Swap/components/screens/sign_and_send_transaction/sign_and_send_tx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Sol_Swap/resources/ui_helpers.dart';
import 'package:phantom_connect/phantom_connect.dart';

class CreateContactScreen extends StatefulWidget {
  final PhantomConnect phantomConnectInstance;

  CreateContactScreen({super.key, required this.phantomConnectInstance});

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController pubkeyController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  List contacts = [];
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  // ignore: body_might_complete_normally_nullable
  Future<DocumentReference<Object?>?> adduser(
      {required String name, required String pubKey}) async {
    await users
        .add({
          'name': name,
          'pubKey': pubKey,
        })
        .then((documentReference) {
          print(documentReference.id);
          showInfoMessage(
              message: "Contact added successfully", title: "Success");
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SignAndSendTransactionScreen(phantomConnectInstance: widget.phantomConnectInstance)), (route) => false);
        })
        .catchError((e) {
          print("My Error is $e");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "Sol Swap",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                vSpaceMedium,
                TextFormField(
                    controller: pubkeyController,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        showInfoMessage(
                            message: "Please submit required fields",
                            title: "Error");
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: "Enter PubKey to add in contact",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    )),
                vSpaceMedium,
                TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        showInfoMessage(
                            message: "Please submit required fields",
                            title: "Error");
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: "Enter Name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    )),
                vSpaceLarge,
                vSpaceLarge,
                vSpaceLarge,
                vSpaceLarge,
                vSpaceLarge,
                ElevatedButton(
                    onPressed: () {
                      adduser(
                          name: nameController.text,
                          pubKey: pubkeyController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(screenWidth(context), 50), backgroundColor: Colors.white,
                        elevation: 4),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
