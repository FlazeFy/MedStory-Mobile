
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/firebase/getUsername.dart';
import 'package:medstory/firebase/getVoteButton.dart';
import 'package:medstory/main.dart';

class GetBalasanById extends StatefulWidget {
  const GetBalasanById({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override

  _GetBalasanById createState() => _GetBalasanById();
}

class _GetBalasanById extends State<GetBalasanById> {
  // GetBalasanById(this.documentId);
  final Stream<QuerySnapshot> _balasan = FirebaseFirestore.instance.collection('balasan').orderBy('datetime', descending: true).snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _balasan,
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
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['pengirim'] == passUsername){
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
                return const SizedBox();
              }
            }

            Widget getImage(){
              if(data['type'] == "text"){
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text("${data['isi']}", 
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
                        child: Text("${data['isi']}", 
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

            if(widget.passDocumentId == data['id_diskusi']){
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
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Column (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GetUsername(passDocumentId: data['id_user']),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(                     
                                      "${DateFormat('dd MMM | hh:mm a').format((data['datetime'] as Timestamp).toDate()).toString()}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      )
                                    ),
                                  )                          
                                ]
                              ),
                            ),
                            const Spacer(),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: getVerifiedAnswer(),
                            )
                          ]
                        )    
                      )                   
                    ),
                    getImage(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GetVoteButton(passDocumentId: document.id),
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
                      blurRadius: 10.0, 
                      spreadRadius: 0.0, 
                      offset: const Offset(5.0, 5.0),
                    )
                  ],
                ),
              );
            } //Empty message still duplicate. even if count = 0 method still error 
            if(widget.passDocumentId != data['id_diskusi']) {
              return const SizedBox();
            }

          }).toList(),
        );
      },
    );
  }
}