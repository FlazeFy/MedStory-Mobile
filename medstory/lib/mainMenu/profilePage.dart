import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:medstory/main.dart';
import 'package:medstory/secondaryMenu/editAccPage.dart';
import 'package:medstory/widgets/custombg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, this.passUsername, this.passDocumentId}) : super(key: key);

  final String passUsername;
  final String passDocumentId;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('pengguna');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.passDocumentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
          return Scaffold(     
            body: CustomPaint(
              painter: WhitePainter(),
              child : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(  
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          transform: Matrix4.translationValues(0.0, 100.0, 0.0),
                          alignment: Alignment.topLeft,
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(2),
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.logout_rounded, size: 40),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                );
                              },
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xFFd9534f),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 190, 190, 190),            
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3)
                              )
                            ],
                          )
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.26),
                        Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.09),
                              alignment: Alignment.topRight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/images/User.jpg', width: 180),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100), 
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 10.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      5.0, // Move to right 10  horizontally
                                      5.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(120.0, MediaQuery.of(context).size.height*0.23, 0.0),                    
                              alignment: Alignment.bottomRight,
                              height: 60,
                              width: 60,
                              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                              child: ClipRRect(
                                child: IconButton(
                                  icon: const Icon(Icons.edit, size: 30),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditAccPage(passUsername: widget.passUsername, passDocumentId: widget.passDocumentId)),
                                    );
                                  },
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4183D7),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(100), 
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 10.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      5.0, // Move to right 10  horizontally
                                      5.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]
                        )
                      ]
                    ),
                      
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: MediaQuery.of(context).size.height*0.05),
                            height: MediaQuery.of(context).size.height*0.08,
                            child: Row(
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width*0.05),
                                InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                    height: MediaQuery.of(context).size.height*0.07,
                                    width: 65,
                                    child: const GetCountDiskusi()
                                  ),
                                  onTap: () { 
                                    //Method get diskusi
                                  },     
                                ),
                                InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                    height: MediaQuery.of(context).size.height*0.07,
                                    width: 65,
                                    child: const GetCountBalasan()
                                  ),
                                  onTap: () { 
                                    //Method get diskusi
                                  }, 
                                ),
                                InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                    height: MediaQuery.of(context).size.height*0.07,
                                    width: 80,
                                    child: const GetCountVerified()
                                  ),
                                  onTap: () { 
                                    //Method get diskusi
                                  }, 
                                )
                              ],
                            ),
                          ),
                          const Text(
                            "Pengaturan Umum", style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child:SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                          padding: const EdgeInsets.only(top: 0),
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Card(
                                child: const ExpansionTile(
                                  initiallyExpanded: false,
                                  leading: Icon(Icons.security, size: 30),
                                  title: Text('Keamanan'),
                                  subtitle: Text('Ganti Password, Ingat Saya', style: TextStyle(color: Colors.grey)),
                                  children: [
                                    //
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Card(
                                child: ExpansionTile(
                                  initiallyExpanded: false,
                                  leading: const Icon(Icons.settings, size: 30),
                                  title: const Text('Pengaturan'),
                                  subtitle: const Text('Warna Latar, Bahasa, Perbarui', style: TextStyle(color: Colors.grey)),
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(bottom: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Warna Latar",
                                                ),
                                                FlutterSwitch(
                                                  showOnOff: true,
                                                  height: 30,
                                                  activeTextFontWeight: FontWeight.w400,
                                                  inactiveTextFontWeight: FontWeight.w400,
                                                  activeTextColor: Colors.black,
                                                  inactiveTextColor: Colors.blue[50],
                                                  value: mode,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      mode = val;
                                                        //Change dark/light mode.
                                                        Get.isDarkMode
                                                        ? Get.changeTheme(ThemeData.light())
                                                        : Get.changeTheme(ThemeData.dark());
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(bottom: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Bahasa",
                                                ),
                                                FlutterSwitch(
                                                  showOnOff: true,
                                                  height: 30,
                                                  activeTextFontWeight: FontWeight.w400,
                                                  inactiveTextFontWeight: FontWeight.w400,
                                                  activeTextColor: Colors.black,
                                                  inactiveTextColor: Colors.blue[50],
                                                  value: bahasa,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      bahasa = val;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    )
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Card(
                                child: ExpansionTile(
                                  initiallyExpanded: false,
                                  leading: const Icon(Icons.notifications, size: 30),
                                  title: const Text('Notifikasi'),
                                  subtitle: const Text('Pembaruan, Aktivitas, Pesan', style: TextStyle(color: Colors.grey)),
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Pembaruan",
                                                ),
                                                FlutterSwitch(
                                                  showOnOff: true,
                                                  height: 30,
                                                  activeTextFontWeight: FontWeight.w400,
                                                  inactiveTextFontWeight: FontWeight.w400,
                                                  activeTextColor: Colors.black,
                                                  inactiveTextColor: Colors.blue[50],
                                                  value: pembaruan,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      pembaruan = val;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(bottom: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Aktivitas",
                                                ),
                                                FlutterSwitch(
                                                  showOnOff: true,
                                                  height: 30,
                                                  activeTextFontWeight: FontWeight.w400,
                                                  inactiveTextFontWeight: FontWeight.w400,
                                                  activeTextColor: Colors.black,
                                                  inactiveTextColor: Colors.blue[50],
                                                  value: aktivitas,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      aktivitas = val;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(bottom: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  "Pesan",
                                                ),
                                                FlutterSwitch(
                                                  showOnOff: true,
                                                  height: 30,
                                                  activeTextFontWeight: FontWeight.w400,
                                                  inactiveTextFontWeight: FontWeight.w400,
                                                  activeTextColor: Colors.black,
                                                  inactiveTextColor: Colors.blue[50],
                                                  value: pesan,
                                                  onToggle: (val) {
                                                    setState(() {
                                                      pesan = val;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    )
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Card(
                                child: ExpansionTile(
                                  initiallyExpanded: false,
                                  leading: const Icon(Icons.help_center, size: 30),
                                  title: const Text('Pusat Bantuan'),
                                  subtitle: const Text('Cara Penggunaan, Tentang, Kritik & Saran', style: TextStyle(color: Colors.grey)),
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height*0.3,
                                      
                                    )
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Card(
                                child: ExpansionTile(
                                  initiallyExpanded: false,
                                  leading: const Icon(Icons.rule, size: 30),
                                  title: const Text('Kebijakan & Privasi'),
                                  subtitle: const Text('Ketentuan, Layanan, Kebijakan', style: TextStyle(color: Colors.grey)),
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height*0.3,
                                      
                                    )
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ]
                        ),
                      )
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: const Text(                     
                          'Versi 1.0.0',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          )
                        ),   
                      ),
                    ),
                  ],
                )
              ),
            ),
          );  
        }

        return const Center( 
          child: CircularProgressIndicator()
        );
      },
    );
  }
  
}