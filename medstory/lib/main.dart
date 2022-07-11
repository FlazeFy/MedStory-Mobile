import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:medstory/newsItem.dart';
import 'package:medstory/secondarymenu/asupanTerfavorit.dart';
import 'package:medstory/secondarymenu/editAccPage.dart';
import 'package:medstory/secondarymenu/faskes&praktek.dart';
import 'package:medstory/secondarymenu/myDiskusiPage.dart';
import 'package:medstory/widgets/sideNav.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:table_calendar/table_calendar.dart';
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

class ForumPage extends StatefulWidget {
  const ForumPage({Key key, this.passUsername, this.passIdUser}) : super(key: key);

  final String passUsername;
  final String passIdUser;

  @override

  _ForumPage createState() => _ForumPage();
}

class _ForumPage extends State<ForumPage> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(passUsername: widget.passUsername),
      body: ListView(
        children:[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("  Informasi Kesehatan",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                      )         
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                  height: 210.0,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      indexNews = index;
                    });
                  },
                ),
                items: imageSliders
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(imgList, (index, url) {
                  return Container(
                    width: 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: indexNews == index ? const Color(0xFF28CF36) : Colors.grey,
                    ),
                  );
                }),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("  Forum Diskusi",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                        )         
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                        child: const DropDown(),
                      )
                    ),
                    Container(
                      transform: Matrix4.translationValues(15.0, 0.0, 0.0),
                      child: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.add),
                              title: const Text('Pertanyaan Ku'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyDiscussionPage(passUsername: passUsername)),
                                );
                              },
                            ),
                          ),
                          const PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.auto_graph),
                              title: Text('Statistik'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
              Flexible(
                child: GetDiskusi(),
              )
              ], 
              
            )
          ),
        ]
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

//Dropdown kategori
class DropDown extends StatefulWidget {
  const DropDown({Key key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = 'Semua';

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
      items: <String>['Semua', 'Penyakit Dalam', 'Penyakit Menular', 'Vaksin & Imunisasi', 'Kulit & Kelamin', 'Otot & Saraf', 'THT & Mata', 'Penyakit Lansia', 'Obat-Obatan', 'Gaya Hidup Sehat', 'Kandungan & Bedah', 'Gigi', 'Anak']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
//Dropdown kategori untuk buat pertanyaan
class DropDown2 extends StatefulWidget {
  const DropDown2({Key key}) : super(key: key);

  @override
  State<DropDown2> createState() => _DropDown2State();
}

class _DropDown2State extends State<DropDown2> {
  String dropdownValue = 'Penyakit Dalam';

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
          passKategori = dropdownValue;
        });
      },
      items: <String>['Penyakit Dalam', 'Penyakit Menular', 'Vaksin & Imunisasi', 'Kulit & Kelamin', 'Otot & Saraf', 'THT & Mata', 'Penyakit Lansia', 'Obat-Obatan', 'Gaya Hidup Sehat', 'Kandungan & Bedah', 'Gigi', 'Anak']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
              appBar: AppBar(
                automaticallyImplyLeading: false,
                iconTheme: 
                  const IconThemeData(
                    color: Color(0xFF4183D7),
                    size: 35.0,
                  ),
                title: const Text("Lihat Balasan", 
                style: TextStyle(
                  color: Color(0xFF4183D7),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              
              actions: [
                IconButton(
                  icon: const Icon(Icons.home, color: Color(0xFF4183D7)),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],

                //Transparent setting.
                backgroundColor: const Color(0x44FFFFFF),
                elevation: 0,
              ),

              //Body.
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Align(
                      child: Container(
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
                            fontWeight: FontWeight.bold
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

                  ], 

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

class SmartDocPage extends StatefulWidget {
  const SmartDocPage({Key key, this.passUsername, this.passIdUser}) : super(key: key);

  final String passUsername;
  final String passIdUser;

  @override

  _SmartDocPage createState() => _SmartDocPage();
}

class _SmartDocPage extends State<SmartDocPage> {
  int passBeratBMI;
  int passTinggiBMI;

  int passTinggiCal;
  int passBeratCal;
  int passUsiaCal;
  int passGenderCal;
  int passAktvCal;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("  SmartDoc",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600
                  )         
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: const Text(
                        "Kalkulator BMI", 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        "Body Mass Index (BMI) atau Indeks Massa Tubuh (IMT) adalah angka yang menjadi penilaian standar untuk menentukan apakah berat badan Anda tergolong normal, kurang, berlebih, atau obesitas.", 
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B6B6B)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width:120,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 220,
                            value: 1,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),

                            onChanged: (value) => passTinggiBMI = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Tinggi Badan (Cm)'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width:120,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 160,
                            value: 1,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            onChanged: (value) => passBeratBMI = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Berat Badan (Kg)'),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () async {
                              double tinggi = passTinggiBMI/100;
                              int berat = passBeratBMI;
                              double bmi = berat / (tinggi * tinggi);
		
                              if (bmi < 18.6) {
                                //Thin Body
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Kurus :(', style: TextStyle(fontWeight: FontWeight.bold)),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            ClipRRect(
                                              child: Image.asset(
                                                'assets/icon/Thin.png', width: 100),
                                            ),
                                            const Text('Tambah asupan makanan, kurangi stres, dan istirahat yang cukup'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Oke, siap'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (bmi >= 18.6 && bmi < 29.9) {
                                //Normal Body
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Normal :)', style: TextStyle(fontWeight: FontWeight.bold)),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            ClipRRect(
                                              child: Image.asset(
                                                'assets/icon/Normal.png', width: 100),
                                            ),
                                            const Text('Tetap jaga pola makan Anda. Dan jangan lengah sampai terlena ya'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Oke, siap'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else { 
                                //Obesity Body
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Obesitas :(', style: TextStyle(fontWeight: FontWeight.bold)),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            ClipRRect(
                                              child: Image.asset(
                                                'assets/icon/Big.png', width: 100),
                                            ),
                                            const Text('Ayo kurangi makan dan perbanyak olahraga'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Oke, siap'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text("Hitung"),
                          )
                        )
                      ],
                    )
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: const Text(
                        "RoboDoc", 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        "RoboDoc adalah fitur yang dapat mendukung Anda untuk mengetahui penyakit yang Anda derita dengan cepat dan tanpa perlu diagnosa lansung dengan dokter. Anda cukup memberitahukan gejala yang Anda derita kepada RoboDoc. Dan kami akan menampilkan daftar kemungkinan penyakit yang Anda derita.", 
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B6B6B)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        const Flexible(
                          // child: TextField(
                          //   maxLines: 3, //or null 
                          //   decoration: InputDecoration(hintText: "Sertakan tanda ',' untuk menambahkan gejala lainnya", labelText: "Gejala"),
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //   )
                          // ),
                          child: AutocompleteBasicExample(),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              //
                            },
                            child: const Text("Hitung"),
                          )
                        )
                      ],
                    )
                  ), 
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: const Text(
                        "Kalkulator Kalori", 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        "Dengan alat ini Anda mengetahui berapa asupan kalori yang dibutuhkan. Hasil perhitungannya dapat Anda gunakan sebagai salah satu acuan untuk mengontrol asupan kalori per hari.", 
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B6B6B)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width:110,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 220,
                            value: 1,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            onChanged: (value) => passTinggiCal = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Tinggi Badan (Cm)'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width:110,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 160,
                            value: 1,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            onChanged: (value) => passBeratCal = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Berat Badan (Kg)'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width:100,
                          height: 50,
                          child: SpinBox(
                            min: 10, max: 110,
                            value:10,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            onChanged: (value) => passUsiaCal = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Umur'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children:[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Jenis Kelamin", 
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF808080)
                                ),
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(-5.0, 0.0, 0.0),
                              child: const DropDownJK()
                            )
                          ]
                        ),
                        Column(
                          children:[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Aktivitas Fisik / Olahraga", 
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF808080)
                                ),
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(25.0, 0.0, 0.0),
                              child: const DropDownAktv()
                            )
                          ]
                        ),
                      ],
                    )
                  ),
                  Container(
                    height: 45,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        //Not
                        int tinggi = passTinggiCal;
                        int berat = passBeratCal;
                        int usia = 21;
                        double aktivitas = 1; //for testing
                        int jKelamin = 1; //for testing
                        double total;

                        if(aktivitas==1){
                          aktivitas = 1.2;
                        } else if(aktivitas==2){
                          aktivitas = 1.4;
                        } else if(aktivitas==3){
                          aktivitas = 1.6;
                        } else if(aktivitas==4){
                          aktivitas = 1.8;
                        } else {
                          aktivitas = 2;
                        }
                        
                        if(jKelamin == 1){
                          total = (((88.4 + 13.4 * berat) + (4.8 * tinggi) - (5.68 * usia)) * aktivitas);
                        } else if(jKelamin == 2){
                          total = (((447.6 + 9.25 * berat) + (3.10 * tinggi) - (4.33 * usia)) * aktivitas);
                        }

                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Informasi', style: TextStyle(fontWeight: FontWeight.bold)),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.asset(
                                        'assets/icon/Calorie.png', width: 100),
                                    ),
                                    Text('Kebutuhan harian Anda sebesar:'+ total.toStringAsFixed(2) +" cal"),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Oke, siap'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Hitung"),
                    )
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
            ),


          ], 

        )
      )
      
    );
  }
}

//Autocomplete still no data passing
class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({Key key}) : super(key: key);

  static final List<String> _kOptions = <String>[
    GetDiskusi().toString()
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}

class GetGejala extends StatefulWidget {
  const GetGejala({Key key}) : super(key: key);

  @override
    _GetGejalaState createState() => _GetGejalaState();
}

class _GetGejalaState extends State<GetGejala> {
 
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('gejala').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        // return ListView(
        //   children: snapshot.data.docs.map((DocumentSnapshot document) {
        //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        //     return ListTile(
        //       title: Text(data['full_name']),
        //       subtitle: Text(data['company']),
        //     );
        //   }).toList(),
        // );
        snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          return data['nama_gejala'].toString();
        }).toList();
        
        
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

class DataKuPage extends StatefulWidget {
  const DataKuPage({Key key, this.passUsername, this.passIdUser}) : super(key: key);

  final String passUsername;
  final String passIdUser;

  @override

  _DataKuPage createState() => _DataKuPage();
}

class _DataKuPage extends State<DataKuPage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("  DataKu",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                        )         
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: const Text(
                        "Kalender Asupan", 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TableCalendar(
                      focusedDay: selectedDay,
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2050),
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          selectedDay = selectDay;
                          focusedDay = focusDay;
                        });
                        print(focusedDay);
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        selectedDecoration: BoxDecoration(
                          color: const Color(0xFF4183D7),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(6), 
                        ),
                        todayDecoration: BoxDecoration(
                          color: const Color(0xFF62C2F5),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(6), 
                        ),
                        defaultDecoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        weekendDecoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        selectedTextStyle: const TextStyle(color: Colors.white),
                      )
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: const Text(
                        "Detail Asupan", 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)
                        ),
                      ),
                    ),
                  ),
                ]
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: const Text(
                        "Statistik Kebutuhan Kalori", 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: const Text(
                        "Grafik Harian", 
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF363636)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: const Text(
                        "Rata-Rata", 
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF363636)
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: const CountKebutuhanHarian()
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: const Text(
                        "Asupan Terfavorit", 
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF363636)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const GetTopAsupan()
                  )
                ]
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
            )
          ]
        )
        
      )
      
    );
  }
}

class DaruratPage extends StatefulWidget {
  const DaruratPage({Key key, this.passUsername, this.passIdUser}) : super(key: key);

  final String passUsername;
  final String passIdUser;

  @override

  _DaruratPage createState() => _DaruratPage();
}

class _DaruratPage extends State<DaruratPage> { 
  @override
  void initState(){
    super.initState();
  }

  getActiveList(){
    if(active == "Faskes"){
      return GetFaskes();
    } else if(active == "Praktek"){
      return GetPraktek();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("  Nomor Darurat",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                      )         
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Row(
                    children:[
                      Container(
                        width: 130,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF4183D7)),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.local_hospital,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                  "FasKes",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            active = "Faskes";
                            setState(() {});
                            getActiveList();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF4183D7)),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.medical_services,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                  "Praktek Dokter",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async{
                            active = "Praktek";
                            setState(() {});
                            getActiveList();
                          },
                        ),
                      ),
                    ]
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
                ),
                Flexible(
                  child: getActiveList()
                )
              ], 
            )
          )
        ]
      )
    );
  }
}

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
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.44,
                      child: ListView(
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
