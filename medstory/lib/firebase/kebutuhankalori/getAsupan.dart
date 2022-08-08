import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/firebase/kebutuhankalori/getJadwal.dart';

int totalItem1;
int totalCalorieFF = 0;

class CountCalorieFF extends StatefulWidget {
  @override
  CountCalorieFF({Key key, this.passDocumentId, this.passTotal}) : super(key: key);
  final String passDocumentId;
  final int passTotal;

  @override
  _CountCalorieFFState createState() => _CountCalorieFFState();
}

class _CountCalorieFFState extends State<CountCalorieFF> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('asupan').snapshots();

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
        
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if((document.id == widget.passDocumentId)&&(i <= 3)){
              i++;
              totalCalorieFF += data['kalori'];
            } else {
              i++;
            }

            if(i == widget.passTotal){
              return Text(totalCalorieFF.toString());
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}