import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/firebase/profile/getUsername.dart';
import 'package:medstory/main.dart';
import 'package:medstory/secondaryMenu/balasanPage.dart';

class GetMyDiskusi extends StatefulWidget {
  const GetMyDiskusi({Key key, this.passUsername}) : super(key: key);
  final String passUsername;

  @override
    _GetMyDiskusiState createState() => _GetMyDiskusiState();
}

class _GetMyDiskusiState extends State<GetMyDiskusi> {
  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('diskusi').orderBy('datetime', descending: true).snapshots();

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
          padding: const EdgeInsets.only(top: 0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_user'] == passIdUser){
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
                                  GetUsername(passDocumentId: data['id_user']),
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
                        const Spacer(),
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
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}