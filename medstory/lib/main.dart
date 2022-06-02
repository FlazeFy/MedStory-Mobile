import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/widgets/sideNav.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


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
                  width: MediaQuery.of(context).size.width*0.3,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                    child: const DropDown(),
                  )
                )
              ]
            ),
          ),
          Flexible(
            child: GetDiskusi(),
          )
          ], 

        )
      )
      
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
                            color: Color(0xFF808080),
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
      icon: const Icon(Icons.arrow_downward),
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

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key key, this.documentId}) : super(key: key);
  final String documentId;

  @override

  _DiscussionPage createState() => _DiscussionPage(documentId);
}

class _DiscussionPage extends State<DiscussionPage> with SingleTickerProviderStateMixin{
  _DiscussionPage(documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('diskusi');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
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
                          height: 162,
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
                                      color: Color(0xFF808080),
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
                                child: const TextField(
                                  //controller: _messageTextCtrl,
                                  decoration: InputDecoration(
                                    hintText: "Ketik balasan Anda...",
                                    hintStyle: TextStyle(color: Color(0xFF808080)),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              FloatingActionButton(
                                onPressed: () async{
                                 //Send message
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
          
            if((widget.pass_documentId == data['id_diskusi'])&&(data['status'] == 'verified')){
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                height: 162,
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
                          data['isi'],
                          style: TextStyle(
                            color: Color(0xFF808080),
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
            } else if((widget.pass_documentId == data['id_diskusi'])&&(data['status'] != 'verified')){
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                height: 162,
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
                            color: Color(0xFF808080),
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
            } else if(widget.pass_documentId != data['id_diskusi']) {
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
          child: Column(
            children: [
              
          ], 

        )
      )
      
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
            children: const [
              
          ], 

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
                      width: 120,
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
                      width: 120,
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
                              width: MediaQuery.of(context).size.width*0.46,
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
                                          fontSize: 14,
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
                                          fontSize: 14,
                                        )
                                      ),   
                                    ),
                                  )                          
                                ]
                              ),
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
                                  )
                                ),   
                              ],
                            )
                            
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
                            color: Color(0xFF808080),
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
                            color: Color(0xFF808080),
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
                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilder(
                              //     pageBuilder: (c, a1, a2) => MapsPage(),
                              //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              //       final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
                              //       final curvedAnimation = CurvedAnimation(
                              //         parent: animation,
                              //         curve: Curves.ease,
                              //       );

                              //       return SlideTransition(
                              //         position: tween.animate(curvedAnimation),
                              //         child: child,
                              //       );
                              //     }
                              //   ),
                              // );
                            },
                            icon: const Icon(Icons.gps_fixed, size: 14),
                            label: const Text("Lihat Lokasi"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1F9F2F)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilder(
                              //     pageBuilder: (c, a1, a2) => MapsPage(),
                              //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              //       final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
                              //       final curvedAnimation = CurvedAnimation(
                              //         parent: animation,
                              //         curve: Curves.ease,
                              //       );

                              //       return SlideTransition(
                              //         position: tween.animate(curvedAnimation),
                              //         child: child,
                              //       );
                              //     }
                              //   ),
                              // );
                            },
                            icon: const Icon(Icons.remove_red_eye, size: 14),
                            label: const Text("Dokter"),
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