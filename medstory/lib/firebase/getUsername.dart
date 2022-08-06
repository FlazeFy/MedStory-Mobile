import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/main.dart';

class GetUsername extends StatefulWidget {
  @override
  GetUsername({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _GetUsernameState createState() => _GetUsernameState();
}

class _GetUsernameState extends State<GetUsername> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('pengguna').snapshots();

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
            getname(){
              if(document.id == passIdUser){
                return "You";
              } else {
                return data['namaPengguna'];
              }
            }

            if(document.id == widget.passDocumentId){
              return Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(                     
                    text: getname(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )
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