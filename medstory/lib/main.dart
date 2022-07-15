import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/mainMenu/daruratPage.dart';
import 'package:medstory/mainMenu/datakuPage.dart';
import 'package:medstory/mainMenu/forumPage.dart';
import 'package:medstory/mainMenu/profilePage.dart';
import 'package:medstory/mainMenu/smartdocPage.dart';
import 'package:medstory/secondarymenu/myDiskusiPage.dart';
import 'package:medstory/widgets/custombg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'landing.dart';

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
    return GetMaterialApp(
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
            child: Image.asset('assets/images/User.jpg', fit: BoxFit.cover),
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

class GetDiskusi extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('diskusi').snapshots();

  GetDiskusi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _diskusi,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        return ListView(
          padding: const EdgeInsets.all(3.0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: Column(
                children: [
                  Align(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [ 
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/User.jpg', width: 40),
                              ),
                          ),
                                  
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Column (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(                     
                                    data['namaPengguna'],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    )
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(                     
                                    "${data['kategori']} ~ ${DateFormat('dd MMM | hh:mm a').format((data['datetime'] as Timestamp).toDate()).toString()}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    )
                                  ),
                                )                          
                              ]
                            ),
                          ),
                          ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/verified.png', width: 30),
                          ),
                        ]
                      )    
                    )                   
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(                     
                        data['pertanyaan'],
                        style: const TextStyle(
                          color: Color(0xFF6B6B6B),
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),   
                    ),
                  ),
                  Row(
                    children: [            
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => DiscussionPage(documentId: document.id),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
                                final curvedAnimation = CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.ease,
                                );

                                return SlideTransition(
                                  position: tween.animate(curvedAnimation),
                                  child: child,
                                );
                              }
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_drop_down, size: 14),
                        label: const Text("Lihat komentar (3)"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.2,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          //
                        },
                        icon: const Icon(Icons.arrow_upward, size: 14),
                        label: Text(data['up'].toString()),
                      ),
                      TextButton.icon(
                        onPressed: () {
                            // Respond to button press
                        },
                        icon: const Icon(Icons.remove_red_eye, size: 14),
                        label: Text(data['view'].toString()),
                      ),
                    ]
                  ),       
                ]

                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), 
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
            );

          }).toList(),
        );
      },
    );
  }
}

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key key, this.documentId}) : super(key: key);
  final String documentId;

  @override

  _DiscussionPage createState() => _DiscussionPage(documentId);
}

class _DiscussionPage extends State<DiscussionPage> with SingleTickerProviderStateMixin{
  _DiscussionPage(documentId);
  final _isiCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference diskusi = FirebaseFirestore.instance.collection('diskusi');
    CollectionReference balasan = FirebaseFirestore.instance.collection('balasan');

    Future<void> replyDiscussion() {
      return balasan
        .add({
          'id_diskusi': widget.documentId, 
          'datetime': DateTime.tryParse(DateTime.now().toIso8601String()),
          'imageURL': 'null', //initial user for now
          'isi': _isiCtrl.text,
          'pengirim': passUsername,
          'status': 'null',
        })
        .then((value) => print("Balasan terkirim"))
        .catchError((error) => print("Failed to add user: $error"));
    }

    return FutureBuilder<DocumentSnapshot>(
      future: diskusi.doc(widget.documentId).get(),
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
            //Body.
            body: CustomPaint(
              painter : CurvedPainter3(),
              child : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Align(
                      child: Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                        child:ElevatedButton.icon(
                          icon: const Icon(Icons.close, size: 30),
                          label: const Text("Kembali", style: TextStyle(fontSize: 16)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.5)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                            )
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      )
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children:[
                            Align(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Card(
                                  child: Column(
                                  children: [
                                    Align(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Row(
                                          children: [ 
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: Image.asset(
                                                  'assets/images/User.jpg', width: 40),
                                                ),
                                            ),
                                                  
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.73,
                                              child: Column (
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(                     
                                                      data['namaPengguna'],
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                      )
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(                     
                                                      "${data['kategori']} ~ ${DateFormat('yyyy-MM-dd | hh:mm a').format((data['datetime'] as Timestamp).toDate()).toString()}",
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13,
                                                      )
                                                    ),
                                                  )                          
                                                ]
                                              ),
                                            ),
                                          ]
                                        )    
                                      )                   
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(                     
                                          data['pertanyaan'],
                                          style: const TextStyle(
                                            color: Color(0xFF6B6B6B),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          )
                                        ),   
                                      ),
                                    ),
                                    Row(
                                      children: [            
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width*0.6,
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                              // Respond to button press
                                          },
                                          icon: const Icon(Icons.arrow_upward, size: 14),
                                          label: Text(data['up'].toString()),
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                              // Respond to button press
                                          },
                                          icon: const Icon(Icons.remove_red_eye, size: 14),
                                          label: Text(data['view'].toString()),
                                        ),
                                      ]
                                    ),       
                                  ]

                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 10.0),
                                transform: Matrix4.translationValues(0.0, 5.0, 0.0),
                                child: const Text("  Balasan (3)",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4183D7)
                                  )         
                                ),
                              )
                            ),
                            Flexible(
                              child: GetBalasanById(passDocumentId: widget.documentId)
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                                margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                                height: 60,
                                width: double.infinity,
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: const Icon(Icons.image, color: Colors.white, size: 20, ),
                                      ),
                                    ),
                                    const SizedBox(width: 15,),
                                    Expanded(
                                      child: TextField(
                                        controller: _isiCtrl,
                                        decoration: const InputDecoration(
                                          hintText: "Ketik balasan Anda...",
                                          hintStyle: TextStyle(color: Color(0xFF6B6B6B)),
                                          border: InputBorder.none
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15,),
                                    FloatingActionButton(
                                      onPressed: () async{
                                        replyDiscussion();
                                      },
                                      child: const Icon(Icons.send,color: Colors.white,size: 18,),
                                      backgroundColor: Colors.green,
                                      elevation: 0,
                                    ),
                                  ],
                                  
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white, 
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
                            ),
                          ]
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        )
                      ),
                    )
                  ], 

                )
              )
            )
          );
        }

        //Loading
        return const Center( 
          child: CircularProgressIndicator()
        );

      },
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

class GetCountDiskusi extends StatefulWidget {
  const GetCountDiskusi({Key key}) : super(key: key);

  @override
    _GetCountDiskusiState createState() => _GetCountDiskusiState();
}

class _GetCountDiskusiState extends State<GetCountDiskusi> {
  final Stream<QuerySnapshot> _myDiskusiCount = FirebaseFirestore.instance.collection('diskusi').where('namaPengguna', isEqualTo: passUsername).snapshots();
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _myDiskusiCount,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }
        
        return Column(
          children:  [
            const Text(                     
              'Diskusi',
              style: TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )
            ),
            Text(                     
              snapshot.data.size.toString(),
              style: const TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )
            ),    
          ],  
        );

      },
    );
  }
}

class GetCountBalasan extends StatefulWidget {
  const GetCountBalasan({Key key}) : super(key: key);

  @override
    _GetCountBalasanState createState() => _GetCountBalasanState();
}

class _GetCountBalasanState extends State<GetCountBalasan> {
  final Stream<QuerySnapshot> _myBalasanCount = FirebaseFirestore.instance.collection('balasan').where('pengirim', isEqualTo: passUsername).snapshots();
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _myBalasanCount,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }
        
        return Column(
          children:  [
            const Text(                     
              'Balasan',
              style: TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )
            ),
            Text(                     
              snapshot.data.size.toString(),
              style: const TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )
            ),    
          ],  
        );

      },
    );
  }
}

class GetCountVerified extends StatefulWidget {
  const GetCountVerified({Key key}) : super(key: key);

  @override
    _GetCountVerifiedState createState() => _GetCountVerifiedState();
}

class _GetCountVerifiedState extends State<GetCountVerified> {
  final Stream<QuerySnapshot> _myBalasanCount = FirebaseFirestore.instance.collection('balasan').where('pengirim', isEqualTo: passUsername).where('status', isEqualTo: "verified").snapshots();
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _myBalasanCount,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }
        
        return Column(
          children:  [
            const Text(                     
              'Terjawab',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )
            ),
            Text(                     
              snapshot.data.size.toString(),
              style: const TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )
            ),    
          ],  
        );

      },
    );
  }
}
