import 'package:Sol_Swap/resources/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:Sol_Swap/components/screens/screens.dart';
import 'package:Sol_Swap/providers/screen_provider.dart';
import 'package:phantom_connect/phantom_connect.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sidebar extends StatelessWidget {
  final PhantomConnect phantomConnectInstance;
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const Sidebar({super.key, required this.phantomConnectInstance});
  @override
  Widget build(BuildContext context) {
    var walletAddrs = phantomConnectInstance.userPublicKey;

    return Drawer(
      child: Material(
        color: Colors.black87,
        child: ListView(
          children: <Widget>[
            buildHeader(walletAddress: walletAddrs),
            const Divider(color: Colors.white70),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSideBarButton(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () =>
                        selectedItem(context, 0, phantomConnectInstance),
                  ),
                  // const SizedBox(height: 16),
                  // buildSideBarButton(
                  //   text: 'Add Contact',
                  //   icon: Icons.contact_mail,
                  //   onClicked: () =>
                  //       selectedItem(context, 5, phantomConnectInstance),
                  // ),
                  const SizedBox(height: 16),
                  buildSideBarButton(
                    text: 'Sign Message',
                    icon: Icons.message,
                    onClicked: () =>
                        selectedItem(context, 1, phantomConnectInstance),
                  ),
                  const SizedBox(height: 16),
                  buildSideBarButton(
                    text: 'Sign and Send Transaction',
                    icon: Icons.send_and_archive,
                    onClicked: () =>
                        selectedItem(context, 2, phantomConnectInstance),
                  ),
                  const SizedBox(height: 16),
                  buildSideBarButton(
                    text: 'Sign Transaction',
                    icon: Icons.edit,
                    onClicked: () =>
                        selectedItem(context, 3, phantomConnectInstance),
                  ),
                  const SizedBox(height: 16),
                  buildSideBarButton(
                    text: 'Disconnect',
                    icon: Icons.link_off,
                    onClicked: () =>
                        selectedItem(context, 4, phantomConnectInstance),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white70),
                  SizedBox(height: screenHeight(context) * 0.2),
                  const _buildSocialWidgets()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String walletAddress,
  }) =>
      InkWell(
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    toShortAddres(address: walletAddress),
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                splashColor: Colors.white12,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Icon(Icons.copy, color: Colors.white),
                  ),
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: walletAddress));
                },
              ),
            ],
          ),
        ),
      );

  String toShortAddres({required String address}) {
    return "${address.substring(0, 10)}...${address.substring(phantomConnectInstance.userPublicKey.length - 5, phantomConnectInstance.userPublicKey.length)}";
  }

  Widget buildSideBarButton({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index,
      PhantomConnect phantomConnectInstance) async {
    Navigator.pop(context);
    switch (index) {
      case 0:
        context.read<ScreenProvider>().changeScreen(Screens.home);
        break;
      case 1:
        context.read<ScreenProvider>().changeScreen(Screens.message);
        break;
      case 2:
        context.read<ScreenProvider>().changeScreen(Screens.send);
        break;
      case 3:
        context.read<ScreenProvider>().changeScreen(Screens.sign);
        break;
      case 4:
        Uri url = phantomConnectInstance.generateDisconnectUri(
            redirect: "/disconnect");
        await launchUrl(url, mode: LaunchMode.externalApplication);
        break;
      case 5:
        context.read<ScreenProvider>().changeScreen(Screens.contacts);
        break;
      default:
        context.read<ScreenProvider>().changeScreen(Screens.home);
        break;
    }
  }
}

class _buildSocialWidgets extends StatelessWidget {
  const _buildSocialWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.white,
          ),
          onPressed: () => launchUrl(
            Uri.parse('https://twitter.com/0xrahulk'),
            mode: LaunchMode.externalApplication,
          ),
        ),
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.github,
            color: Colors.white,
          ),
          onPressed: () => launchUrl(
            Uri.parse('https://github.com/rkmonarch/'),
            mode: LaunchMode.externalApplication,
          ),
        ),
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.linkedinIn,
            color: Colors.white,
          ),
          onPressed: () => launchUrl(
            Uri.parse('https://www.linkedin.com/in/rahul-kulkarni-398738218/'),
            mode: LaunchMode.externalApplication,
          ),
        ),
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.envelope,
            color: Colors.white,
          ),
          onPressed: () => launchUrl(
            Uri.parse('mailto:rkweb3.00@gmail.com'),
            mode: LaunchMode.externalApplication,
          ),
        ),
      ],
    );
  }
}
