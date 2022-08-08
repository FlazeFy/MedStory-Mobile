import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/secondaryMenu/balasanPage.dart';

class CountDoctorFaskes extends StatefulWidget {
  @override
  const CountDoctorFaskes({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _CountDoctorFaskesState createState() => _CountDoctorFaskesState();
}

class _CountDoctorFaskesState extends State<CountDoctorFaskes> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('dokterpraktik').snapshots();

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
            if(data['id_faskes'] == widget.passDocumentId){
              i++;
              count++;
            } else {
              i++;
            }

            if(i == max){
              if(count > 0){
                return Text(                     
                  count.toString(),
                  style: const TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )
                );  
              } else if(count == 0) {
                return Text(                     
                  "0",
                  style: const TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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