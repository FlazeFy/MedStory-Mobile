import 'package:flutter/material.dart';
import 'package:medstory/firebase/getProfileImage.dart';
import 'package:medstory/mainMenu/daruratPage.dart';
import 'package:medstory/mainMenu/datakuPage.dart';
import 'package:medstory/mainMenu/forumPage.dart';
import 'package:medstory/mainMenu/profilePage.dart';
import 'package:medstory/mainMenu/smartdocPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'mainMenu/loginPage.dart';

bool shouldUseFirestoreEmulator = false;

//Initial global variable.
String passIdAsupan;
String passWaktu = "Pagi";
String passIdUser;
String passUsername;
String passKategori;
String active = "Faskes";

//Setting switch.
bool pembaruan = false;
bool aktivitas = false;
bool pesan = false;
bool mode = false;
bool bahasa = false;

//Carousel news Index. 
int indexNews=0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF6F7F9)),
      title: "Leonardho R Sitanggang-1302194041",
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login()
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key key}) : super(key: key);
  
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      ForumPage(passUsername: passUsername, passIdUser: passIdUser),
      SmartDocPage(passUsername: passUsername, passIdUser: passIdUser),
      DataKuPage(passUsername: passUsername, passIdUser: passIdUser),
      DaruratPage(passUsername: passUsername, passIdUser: passIdUser),
      ProfilePage(passUsername: passUsername, passDocumentId:passIdUser)
    ];
    return Scaffold(
    bottomNavigationBar: CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: <Widget>[
        const Icon(Icons.forum, size: 30, color: Colors.white),
        const Icon(Icons.medical_services, size: 30, color: Colors.white),
        const Icon(Icons.book, size: 30, color: Colors.white),
        const Icon(Icons.local_hospital, size: 30, color: Colors.white),
        ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(18), // Image radius
            child: GetProfileImage(passIdUser)
          ),
        )
      ],
      color: const Color(0xFF4183D7),
      buttonBackgroundColor: const Color(0xFF22A7F0),
      backgroundColor: Colors.white.withOpacity(0),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
      letIndexChange: (index) => true,
    ),
    body: _widgetOptions.elementAt(_page)
    );
  }
}

//Dropdown Jenis Kelamin
class DropDownJK extends StatefulWidget {
  const DropDownJK({Key key}) : super(key: key);

  @override
  State<DropDownJK> createState() => _DropDownJKState();
}

class _DropDownJKState extends State<DropDownJK> {
  String dropdownValue = 'Pria';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Color(0xFF212121)),
      underline: Container(
        height: 2,
        color: const Color(0xFF4183D7),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Pria', 'Wanita']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//Dropdown Jenis Kelamin
class DropDownAktv extends StatefulWidget {
  const DropDownAktv({Key key}) : super(key: key);

  @override
  State<DropDownAktv> createState() => _DropDownAktvState();
}

class _DropDownAktvState extends State<DropDownAktv> {
  String dropdownValue = 'Tidak berolahraga';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Color(0xFF212121)),
      underline: Container(
        height: 2,
        color: const Color(0xFF4183D7),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Tidak berolahraga', '1-3 kali dalam seminggu', '3-5 kali dalam seminggu', '6-7 kali dalam seminggu', 'Setiap hari / Pekerjaan fisik']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}