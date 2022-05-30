import 'package:flutter/material.dart';
import '../main.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Rose Monde',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF4183D7),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background1.png')
              )
            ),
          ),
          ListTile(
            leading: const Icon(Icons.app_settings_alt, color: Color(0xFF4183D7)),
            title: const Text('Pengaturan'),
            textColor: const Color(0xFF4183D7),
            onTap: () {
              // Navigator.push(
              //   context, MaterialPageRoute(
              //     builder: (context) => const SettingPage(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_center, color: Color(0xFF4183D7)),
            title: const Text('Bantuan'),
            textColor: const Color(0xFF4183D7),
            onTap: () {
              // Navigator.push(
              //   context, MaterialPageRoute(
              //     builder: (context) => const HelpPage(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Color(0xFF4183D7)),
            title: const Text('Tentang Kami'),
            textColor: const Color(0xFF4183D7),
            onTap: () {
              // Navigator.push(
              //   context, MaterialPageRoute(
              //     builder: (context) => const AboutPage(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.rule, color: Color(0xFF4183D7)),
            title: const Text('Kebijakan & Privasi'),
            textColor: const Color(0xFF4183D7),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Expanded(
            child: Align(
            alignment: Alignment.bottomLeft,
              child: ListTile(
                tileColor: const Color(0xFFe14141),
                leading: const Icon(Icons.exit_to_app, color: Colors.white),
                title: const Text('Ganti Akun'),  
                textColor: Colors.white,
                onTap: () {
                  // Navigator.push(
                  //   context, MaterialPageRoute(
                  //     builder: (context) => const LoginPage(),
                  //   ),
                  // );
                },
              ),
           ),
          ),
        ],
      ),
    );
  }
}