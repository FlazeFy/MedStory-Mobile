import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/firebase/countUp.dart';
import 'package:medstory/main.dart';

class GetVoteButton extends StatefulWidget {
  @override
  const GetVoteButton({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _GetVoteButtonState createState() => _GetVoteButtonState();
}

class _GetVoteButtonState extends State<GetVoteButton> {

  @override
  Widget build(BuildContext context) {
    CollectionReference up = FirebaseFirestore.instance.collection('up');

    Future<void> upQuestion(String id) {
      return up
        .add({
          'id_context': id, 
          'id_user': passIdUser, 
        })
        .then((value) => print("Successfully up question"))
        .catchError((error) => print("Failed up question: $error"));
    }

    Future<void> downQuestion() {
      String id_up;

      FirebaseFirestore.instance
      .collection('up')
      .get()
      .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if((doc["id_user"] == passIdUser)&&(doc["id_context"] == widget.passDocumentId)){
            id_up = doc.id;
          }
        });

        return up
          .doc(id_up)
          .delete()
          .then((value) => print("Successfully re-up question"))
          .catchError((error) => print("Failed to re-up question: $error"));
      });
    }

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('up').snapshots();

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
            if(document['id_context'] == widget.passDocumentId){
              if(data['id_user'] == passIdUser){
                i++;
                count++;
              } else {
                i++;
              }
            } else {
              i++;
            }

            if(i == max){
              if(count > 0){
                return TextButton.icon(
                  onPressed: () async {
                    downQuestion();
                  },
                  icon: const Icon(Icons.arrow_upward, size: 16, color: Colors.green),
                  label: CountUp(passDocumentId: widget.passDocumentId, textColor: Colors.green)
                );
              } else if(count == 0) {
                return TextButton.icon(
                  onPressed: () async {
                    upQuestion(widget.passDocumentId);
                  },
                  icon: const Icon(Icons.arrow_upward, size: 16),
                  label: CountUp(passDocumentId: widget.passDocumentId, textColor: Colors.blue)
                );
              }
            } else {
              return SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}