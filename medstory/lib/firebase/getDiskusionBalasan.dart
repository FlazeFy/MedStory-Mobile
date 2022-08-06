import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/firebase/getUsername.dart';
import 'package:medstory/firebase/getVoteButton.dart';

class GetDiskusiOnBalasan extends StatefulWidget {
  @override
  GetDiskusiOnBalasan({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _GetDiskusiOnBalasanState createState() => _GetDiskusiOnBalasanState();
}

class _GetDiskusiOnBalasanState extends State<GetDiskusiOnBalasan> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('diskusi').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            Widget getImage(){
              if(data['type'] == "text"){
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text("${data['pertanyaan']}", 
                  style: const TextStyle(
                    color: Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
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
                          color: Color(0xFF6B6B6B),
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
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

            if(document.id == widget.passDocumentId){
              return Align(
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
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
                        ),                
                        getImage(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [            
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