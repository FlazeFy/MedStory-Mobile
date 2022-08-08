import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/secondaryMenu/balasanPage.dart';

class CountKomentar extends StatefulWidget {
  @override
  const CountKomentar({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _CountKomentarState createState() => _CountKomentarState();
}

class _CountKomentarState extends State<CountKomentar> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('balasan').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        int i = 0;
        int count = 0;
        int max = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_diskusi'] == widget.passDocumentId){
              i++;
              count++;
            } else {
              i++;
            }

            if(i == max){
              if(count > 0){
                return TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => DiscussionPage(documentId: widget.passDocumentId),
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
                  label: Text("Lihat komentar (${count.toString()})"),
                );
              } else if(count == 0) {
                return TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => DiscussionPage(documentId: widget.passDocumentId),
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
                  label: const Text("Lihat komentar (0)"),
                );
              }
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}

class CountKomentar2 extends StatefulWidget {
  @override
  const CountKomentar2({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _CountKomentar2State createState() => _CountKomentar2State();
}

class _CountKomentar2State extends State<CountKomentar2> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('balasan').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        int i = 0;
        int count = 0;
        int max = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_diskusi'] == widget.passDocumentId){
              i++;
              count++;
            } else {
              i++;
            }

            if(i == max){
              if(count > 0){
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    transform: Matrix4.translationValues(0.0, 5.0, 0.0),
                    child: Text("  Balasan (${count.toString()})",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4183D7)
                      )         
                    ),
                  )
                );
              } else if(count == 0) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    transform: Matrix4.translationValues(0.0, 5.0, 0.0),
                    child: const Text("  Balasan (0)",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4183D7)
                      )         
                    ),
                  )
                );
              }
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}