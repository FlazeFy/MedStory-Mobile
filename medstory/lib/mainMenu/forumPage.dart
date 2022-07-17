

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/main.dart';
import 'package:medstory/secondaryMenu/balasanPage.dart';
import 'package:medstory/secondaryMenu/newsItem.dart';
import 'package:medstory/secondaryMenu/myDiskusiPage.dart';
import 'package:medstory/secondaryMenu/statisticPage.dart';
import 'package:medstory/widgets/custombg.dart';
import 'package:medstory/widgets/sideNav.dart';

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
      body: CustomPaint(
        painter : CurvedPainter2(),
        child : ListView(
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
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
                            PopupMenuItem(
                              child: ListTile(
                                leading: const Icon(Icons.auto_graph),
                                title: const Text('Statistik'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const StatisticsPage()),
                                  );
                                },
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
      )
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

class GetDiskusi extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('diskusi').orderBy('datetime', descending: true).snapshots();

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
                      Spacer(),
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