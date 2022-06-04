import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medstory/widgets/sideNav.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:table_calendar/table_calendar.dart';

bool shouldUseFirestoreEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF6F7F9)),
      title: "Leonardho R Sitanggang-1302194041",
      home: const NavBar(), //Navbar
    );
  }
}
class NavBar extends StatefulWidget {
  const NavBar({Key key, this.pass_usernameNav}) : super(key: key);
  final String pass_usernameNav;
  
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      ForumPage(pass_username: widget.pass_usernameNav),
      SmartDocPage(pass_username: widget.pass_usernameNav),
      DataKuPage(pass_username: widget.pass_usernameNav),
      DaruratPage(pass_username: widget.pass_usernameNav),
    ];
  
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.forum),
              label: 'Forum',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: 'SmartDoc',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'DataKu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Darurat',
            ),
          ],
          //Selected menu style.
          showUnselectedLabels: true,
          selectedItemColor: const Color(0xFF4183D7),
          unselectedItemColor: const Color(0xFF414141),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          
        ),
    );
  }
}

class ForumPage extends StatefulWidget {
  const ForumPage({Key key, this.pass_username}) : super(key: key);

  final String pass_username;

  @override

  _ForumPage createState() => _ForumPage();
}

class _ForumPage extends State<ForumPage> {
  int _currentIndex=0;

  List cardList=[
    const Item1(),
    const Item2(),
    const Item3(),
    const Item4()
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('diskusi');

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: Color(0xFF4183D7),
            size: 35.0,
          ),
        title: Text("Welcome, ${widget.pass_username}", 
        style: const TextStyle(
          color: Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      
      actions: [
        IconButton(
          icon: Image.asset('assets/images/User.jpg'),
          iconSize: 50,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AccountPage(pass_username: widget.pass_username)),
            // );
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("  Informasi Kesehatan",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500
                )         
              ),
            ),
            CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: cardList.map((card){
              return Builder(
                builder:(BuildContext context){
                  return Container(
                    height: MediaQuery.of(context).size.height*0.30,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: const Color(0xff22A7F0),
                      child: card,
                    ),
                    decoration: BoxDecoration(
                      borderRadius : BorderRadius.circular(10),
                    )
                  );
                }
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(cardList, (index, url) {
              return Container(
                width: 6.0,
                height: 6.0,
                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? const Color(0xFF28CF36) : Colors.grey,
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
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                    )         
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.1,
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
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.add),
                          title: Text('Pertanyaan Ku'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyDiscussionPage(pass_username: 'flazefy')),
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyDiscussionPage extends StatefulWidget {
  const MyDiscussionPage({Key key, this.pass_username}) : super(key: key);
  final String pass_username;

  @override

  _MyDiscussionPage createState() => _MyDiscussionPage();
}

class _MyDiscussionPage extends State<MyDiscussionPage> {
  var _pertanyaanCtrl = TextEditingController();
  String kategori = 'Mata';

  @override
  Widget build(BuildContext context) {
    CollectionReference disc = FirebaseFirestore.instance.collection('diskusi');

    Future<void> addDiskusi() {
      // Call the user's CollectionReference to add a new user
      return disc
        .add({
          'kategori': kategori,
          'namaPengguna': widget.pass_username, 
          'pertanyaan': _pertanyaanCtrl.text,
          'datetime': DateTime.tryParse(DateTime.now().toIso8601String()),
          'imageURL': 'null', //initial user for now
          'view': 0,
          'up': 0, //initial user for now
        })
        .then((value) => print("Diskusi berhasil ditambah"))
        .catchError((error) => print("Failed to add user: $error"));
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: Color(0xFF4183D7),
            size: 35.0,
          ),
        title: Text("Pertanyaan Ku", 
        style: const TextStyle(
          color: Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.home, color: Color(0xFF4183D7)),
          iconSize: 40,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar(pass_usernameNav: widget.pass_username)),
            );
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
        width: MediaQuery.of(context).size.width,
        child: Flexible(            
          child : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                
                ExpansionTile(
                  initiallyExpanded: true,
                  leading: IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.add,
                    color: Color(0xFF808080)),
                    onPressed: () {},
                  ),
                  title: const Text(
                    "Tambah Pertanyaan",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  children: <Widget>[                     
                    SingleChildScrollView(               
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("  Kategori",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500
                              )         
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: DropDown2()
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("  Pertanyaan",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500
                              )         
                            ),
                          ),
                          Align(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextField(
                                controller: _pertanyaanCtrl,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF4169E1), width: 2.0),
                                  ),
                              
                                  hintText: "Ketikkan pertanyaan Anda disini",
                                ),
                              ),
                            )
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton.icon(
                            onPressed: () {
                              addDiskusi();
                            },
                            color: Colors.green,
                            label: Text("Unggah Pertanyaan", style: TextStyle(color: Colors.white),),
                            icon: Icon(Icons.send, color: Colors.white),
                          )
                        ]
                      )
                    )
                  ]
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children:[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("  Pertanyaan",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                          )         
                        ),
                      ),
                      SizedBox(height: 10),
                      Flexible(
                        child: GetMyDiskusi(pass_username: widget.pass_username)
                      )
                    ]
                  )
                )
              ]
            )
          )
        )
      ),
    );
  }
}

class GetMyDiskusi extends StatefulWidget {
  const GetMyDiskusi({Key key, this.pass_username}) : super(key: key);
  final String pass_username;

  @override
    _GetMyDiskusiState createState() => _GetMyDiskusiState();
}

class _GetMyDiskusiState extends State<GetMyDiskusi> {
  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('diskusi').where('namaPengguna', isEqualTo: 'flazefy').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _diskusi,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
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
                                    child: Container(
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
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(                     
                                        "${data['kategori']} ~ ${DateFormat('dd MMM | hh:mm a').format((data['datetime'] as Timestamp).toDate()).toString()}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        )
                                      ),   
                                    ),
                                  )                          
                                ]
                              ),
                            ),
                            Container(
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/verified.png', width: 30),
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
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),   
                      ),
                    ),
                    Container(
                      child: Row(
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
                      ) 
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

class GetDiskusi extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('diskusi').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _diskusi,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
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
                                    child: Container(
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
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(                     
                                        "${data['kategori']} ~ ${DateFormat('dd MMM | hh:mm a').format((data['datetime'] as Timestamp).toDate()).toString()}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        )
                                      ),   
                                    ),
                                  )                          
                                ]
                              ),
                            ),
                            Container(
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/verified.png', width: 30),
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
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),   
                      ),
                    ),
                    Container(
                      child: Row(
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
                      ) 
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
  var _isiCtrl = TextEditingController();

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
          'pengirim': 'flazefy', //initial user for now
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
                      child: GetBalasanById(pass_documentId: widget.documentId)
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
                                decoration: InputDecoration(
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
        return Scaffold(
          body: Align(
            alignment: Alignment.center,
            child: Container(
              transform: Matrix4.translationValues(0.0, 400.0, 0.0),
              child: Column(
                children:const [
                  //Error
                  // SpinKitFoldingCube(
                  //   color: Color(0xFF4183D7),
                  //   controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 3000)),
                  // ),
                  Text(                     
                    "Loading...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )
                  ),
                ]
              )   
            ),
          ),
          
        );

      },
    );
  }
}
class GetBalasanById extends StatefulWidget {
  const GetBalasanById({Key key, this.pass_documentId}) : super(key: key);
  final String pass_documentId;

  @override

  _GetBalasanById createState() => _GetBalasanById();
}

class _GetBalasanById extends State<GetBalasanById> {
  // GetBalasanById(this.documentId);
  final Stream<QuerySnapshot> _balasan = FirebaseFirestore.instance.collection('balasan').snapshots();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _balasan,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['pengirim'] == 'flazefy'){
              data['pengirim'] = 'Anda';
            }
            Widget getVerifiedAnswer() {
              if(data['status'] == 'verified'){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/verified.png', width: 30),
                );
              } else {
                return SizedBox();
              }
            }
            if(widget.pass_documentId == data['id_diskusi']){
              count++;
              return Container(
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
                                      data['pengirim'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      )
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(                     
                                      "${DateFormat('dd MMM | hh:mm a').format((data['datetime'] as Timestamp).toDate()).toString()}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      )
                                    ),
                                  )                          
                                ]
                              ),
                            ),
                            getVerifiedAnswer(),
                          ]
                        )    
                      )                   
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(                     
                          data['isi'],
                          style: TextStyle(
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          )
                        ),   
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton.icon(
                        onPressed: () {
                            // Respond to button press
                        },
                        icon: const Icon(Icons.arrow_upward, size: 14),
                        label: const Text("2"),
                      ),
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
            } //Empty message still duplicate. even if count = 0 method still error 
            if(widget.pass_documentId != data['id_diskusi']) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Image.asset('assets/images/EmptyError.png'),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                        child: const Text(
                          "Maaf, pertanyaan ini belum dijawab...", 
                          style: TextStyle(
                            fontSize: 15,
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
              );
            }

          }).toList(),
        );
      },
    );
  }
}


class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News1.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Resmi! Kasus Aktif Covid-19 di Indonesia Kalahkan India",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-1");
      },
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News2.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Menkes: Vaksin Moderna untuk Nakes karena Stok Terbatas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-2");
      },
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News3.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Susul Moderna, Vaksin Pfizer Sebentar Lagi Dapat Izin di RI",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-3");
      },
    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News4.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Cara mengatasi penyakit maag agar tidak kambuh lagi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-4");
      },
    );
  }
}

class SmartDocPage extends StatefulWidget {
  const SmartDocPage({Key key, this.pass_username}) : super(key: key);

  final String pass_username;

  @override

  _SmartDocPage createState() => _SmartDocPage();
}

class _SmartDocPage extends State<SmartDocPage> {
  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: Color(0xFF4183D7),
            size: 35.0,
          ),
        title: Text("Welcome, ${widget.pass_username}", 
        style: const TextStyle(
          color: Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      
      actions: [
        IconButton(
          icon: Image.asset('assets/images/User.jpg'),
          iconSize: 50,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AccountPage(pass_username: widget.pass_username)),
            // );
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
        child: ListView(
          children: [
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
                        Container(
                          width:120,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 220,
                            value: 170,
                            spacing: 1,
                            textStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(labelText: 'Tinggi Badan (Cm)'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width:120,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 160,
                            value: 65,
                            spacing: 1,
                            textStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(labelText: 'Berat Badan (Kg)'),
                          ),
                        ),
                        Container(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              
                            },
                            child: Text("Hitung"),
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
                        Flexible(
                          // child: TextField(
                          //   maxLines: 3, //or null 
                          //   decoration: InputDecoration(hintText: "Sertakan tanda ',' untuk menambahkan gejala lainnya", labelText: "Gejala"),
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //   )
                          // ),
                          child: AutocompleteBasicExample(),
                        ),
                        Container(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                                // Respond to button press
                            },
                            child: Text("Hitung"),
                          )
                        )
                      ],
                    )
                  ), 
                  SizedBox(
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
                        Container(
                          width:110,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 220,
                            value: 170,
                            spacing: 1,
                            textStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(labelText: 'Tinggi Badan (Cm)'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width:110,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 160,
                            value: 65,
                            spacing: 1,
                            textStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(labelText: 'Berat Badan (Kg)'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width:100,
                          height: 50,
                          child: SpinBox(
                            min: 10, max: 110,
                            value: 25,
                            spacing: 1,
                            textStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(labelText: 'Umur'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            children:[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: const Text(
                                    "Jenis Kelamin", 
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF808080)
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                transform: Matrix4.translationValues(-5.0, 0.0, 0.0),
                                child: DropDownJK()
                              )
                            ]
                          ),
                        ),
                        Container(
                          child: Column(
                            children:[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: const Text(
                                    "Aktivitas Fisik / Olahraga", 
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF808080)
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                transform: Matrix4.translationValues(25.0, 0.0, 0.0),
                                child: DropDownAktv()
                              )
                            ]
                          ),
                        ),
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


          ], 

        )
      )
      
    );
  }
}

//Autocomplete still no data passing
class AutocompleteBasicExample extends StatelessWidget {
  AutocompleteBasicExample({Key key}) : super(key: key);

  static List<String> _kOptions = <String>[
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
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
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
  const DataKuPage({Key key, this.pass_username}) : super(key: key);

  final String pass_username;

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
      drawer: const NavDrawer(),
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: Color(0xFF4183D7),
            size: 35.0,
          ),
        title: Text("Welcome, ${widget.pass_username}", 
        style: const TextStyle(
          color: Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      
      actions: [
        IconButton(
          icon: Image.asset('assets/images/User.jpg'),
          iconSize: 50,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AccountPage(pass_username: widget.pass_username)),
            // );
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
        child: ListView(
          children: [
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
                    child: Container(
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
                            color: Color(0xFF4183D7),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(6), 
                          ),
                          todayDecoration: BoxDecoration(
                            color: Color(0xFF62C2F5),
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
                          selectedTextStyle: TextStyle(color: Colors.white),
                        )
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
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
  const DaruratPage({Key key, this.pass_username}) : super(key: key);

  final String pass_username;

  @override

  _DaruratPage createState() => _DaruratPage();
}

class _DaruratPage extends State<DaruratPage> {
  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: Color(0xFF4183D7),
            size: 35.0,
          ),
        title: Text("Welcome, ${widget.pass_username}", 
        style: const TextStyle(
          color: Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      
      actions: [
        IconButton(
          icon: Image.asset('assets/images/User.jpg'),
          iconSize: 50,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AccountPage(pass_username: widget.pass_username)),
            // );
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
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Row(
                children:[
                  Container(
                    width: 130,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: RaisedButton(
                      color: Color(0xFF4183D7),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.local_hospital,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
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
                      onPressed: () {
                        //Collapse
                      },
                    ),
                  ),
                  Container(
                    width: 130,
                    // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: RaisedButton(
                      color: Color(0xFF4183D7),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.medical_services,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
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
                      onPressed: () {
                        //Collapse
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
              child: GetFaskes(),
            )
          ], 

        )
      )
      
    );
  }
}

class GetFaskes extends StatelessWidget {

  final Stream<QuerySnapshot> _faskes = FirebaseFirestore.instance.collection('faskes').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _faskes,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
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
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/images/${data['namaFaskes']}.jpeg', width: 120, height: 80),
                                ),
                            ),
                                    
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.55,
                              child: Column (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(                     
                                        data['namaFaskes'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),   
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(                     
                                        data['alamat'],
                                        style: const TextStyle(
                                          color: Color(0xFF212121),
                                          fontSize: 13,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),   
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(                     
                                        data['kontak'],
                                        style: const TextStyle(
                                          color: Color(0xFF212121),
                                          fontSize: 13,
                                        )
                                      ),   
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
                          'Fasilitas',
                          style: const TextStyle(
                            color: Color(0xFF212121),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )
                        ),   
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(                     
                          data['fasilitas'],
                          style: const TextStyle(
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),   
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(                     
                          'Poliklinik',
                          style: const TextStyle(
                            color: Color(0xFF212121),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )
                        ),   
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(                     
                          data['poliklinik'],
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical:5),
                      child: Row(
                        children: [            
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => MapsPage(pass_namafaskes: data['namaFaskes'], pass_coordinate_lat: double.tryParse(data['lat']), pass_coordinate_lng: double.tryParse(data['lng']), 
                                    pass_alamat: data['alamat'], pass_kontak: data['kontak'], pass_fasilitas: data['fasilitas'], pass_poliklinik: data['poliklinik']),
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
                            icon: const Icon(Icons.info, size: 14),
                            label: const Text("Detail"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1F9F2F)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton.icon(
                            onPressed: () {
                              //
                            },
                            icon: const Icon(Icons.copy, size: 14),
                            label: const Text("Kordinat"),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.3,
                          ),
                          Row(
                            children: [
                              Container(
                                child: ClipRRect(
                                child: Image.asset(
                                  'assets/images/Rating.png', width: 20),
                                ),
                              ),
                              Text(                     
                                data['rating'].toString(),
                                style: const TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )
                              ),   
                            ],
                          )
                        ]
                      ) 
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

class MapsPage extends StatefulWidget {
  MapsPage({Key key, this.pass_namafaskes, this.pass_coordinate_lat, this.pass_coordinate_lng, this.pass_alamat, this.pass_fasilitas, this.pass_kontak, this.pass_poliklinik}) : super(key: key);

  final String pass_namafaskes;
  final String pass_alamat;
  final String pass_kontak;
  final String pass_fasilitas;
  final String pass_poliklinik;
  final double pass_coordinate_lat;
  final double pass_coordinate_lng;

  @override
  _MapsPageState createState() => _MapsPageState();
}
class _MapsPageState extends State<MapsPage> {
  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final _initialCameraPosition = CameraPosition(
      target: LatLng(widget.pass_coordinate_lat, widget.pass_coordinate_lng), //Bandung
      zoom: 14, 
    );
    return Scaffold(     
      appBar: AppBar(
        iconTheme: 
          IconThemeData(
            color: Color(0xFF4169E1),
            size: 35.0,
          ),
          title: Text("${widget.pass_namafaskes}", 
          style: TextStyle(
            color: Color(0xFF4169E1),
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        //Transparent setting.
        backgroundColor: Color(0x44FFFFFF),
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Flexible(      
              child: GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) => _googleMapController = controller,
                markers: {
                  if (_origin != null) _origin,
                  Marker(
                    markerId: MarkerId('destination'),
                    infoWindow: const InfoWindow(title: 'Destination'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    position: LatLng(widget.pass_coordinate_lat, widget.pass_coordinate_lng),
                  )
                },
                onLongPress: _addMarker,
              ),
            ), 
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          'assets/images/${widget.pass_namafaskes}.jpeg', width: 120, height: 80),
                        ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(                     
                              widget.pass_namafaskes,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),   
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.6,
                            child: Text(                     
                              widget.pass_alamat,
                              style: const TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),   
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(                     
                              widget.pass_kontak,
                              style: const TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 13,
                              )
                            ),   
                          ),
                        )                          
                      ]
                    ),
                  ]
                )
              ]
            ),
            Column(
              children: <Widget>[
                ExpansionTile(
                  initiallyExpanded: true,
                  leading: IconButton(
                    iconSize: 25,
                    icon: Icon(Icons.info,
                    color: Color(0xFF414141)),
                    onPressed: () {},
                  ),
                  title: const Text(
                    "Detail",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: ListView(
                        children:[ 
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(                     
                                'Fasilitas',
                                style: const TextStyle(
                                  color: Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )
                              ),   
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(                     
                                widget.pass_fasilitas,
                                style: const TextStyle(
                                  color: Color(0xFF6B6B6B),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),   
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(                     
                                'Poliklinik',
                                style: const TextStyle(
                                  color: Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )
                              ),   
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(                     
                                widget.pass_poliklinik,
                                style: const TextStyle(
                                  color: Color(0xFF6B6B6B),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),   
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(                     
                                'Praktik Dokter',
                                style: const TextStyle(
                                  color: Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )
                              ),   
                            ),
                          ),
                          SizedBox(height: 10)
                        ]
                      )
                    )
                  ]
                )
              ]
            ),
          ],
        )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF1F9F2F),
          foregroundColor: Colors.white,
          onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition),
          ),
          child: Icon(Icons.center_focus_strong),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop
    );
  }
  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
        // Reset destination
        _destination = null;
      });
    } 
  }
}