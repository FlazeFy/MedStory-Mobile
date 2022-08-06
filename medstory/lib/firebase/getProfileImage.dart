import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetProfileImage extends StatelessWidget {
  final String documentId;

  GetProfileImage(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('pengguna');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
          return Image.network(data['url'], width: 40);
        }

        return const Center(child: const CircularProgressIndicator());
      },
    );
  }
}