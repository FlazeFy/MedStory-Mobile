import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/firebase/countUp.dart';
import 'package:medstory/firebase/getUsername.dart';
import 'package:medstory/firebase/getVoteButton.dart';
import 'package:medstory/secondaryMenu/balasanPage.dart';

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
            Widget getImage(){
              if(data['type'] == "text"){
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text("${data['pertanyaan']}", 
                  style: const TextStyle(
                    color: Color(0xFF212121),
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  )
                );
              } else if (data['type'] == "image"){
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    children:[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(data['url']),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 5),
                        child: Text("${data['pertanyaan']}", 
                        style: const TextStyle(
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        )
                      )
                    ]
                  )
                );
              }
            }
            
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
                          // ClipRRect(
                          // borderRadius: BorderRadius.circular(20),
                          // child: Image.asset(
                          //   'assets/images/verified.png', width: 30),
                          // ),
                        ]
                      )    
                    )                   
                  ),
                  getImage(),
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
                      GetVoteButton(passDocumentId: document.id),
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