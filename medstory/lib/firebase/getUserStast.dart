import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/main.dart';

class GetCountDiskusi extends StatefulWidget {
  const GetCountDiskusi({Key key}) : super(key: key);

  @override
    _GetCountDiskusiState createState() => _GetCountDiskusiState();
}

class _GetCountDiskusiState extends State<GetCountDiskusi> {
  final Stream<QuerySnapshot> _myDiskusiCount = FirebaseFirestore.instance.collection('diskusi').where('id_user', isEqualTo: passIdUser).snapshots();
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _myDiskusiCount,
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
          children:  [
            const Text(                     
              'Diskusi',
              style: TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )
            ),
            Text(                     
              snapshot.data.size.toString(),
              style: const TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )
            ),    
          ],  
        );

      },
    );
  }
}

class GetCountBalasan extends StatefulWidget {
  const GetCountBalasan({Key key}) : super(key: key);

  @override
    _GetCountBalasanState createState() => _GetCountBalasanState();
}

class _GetCountBalasanState extends State<GetCountBalasan> {
  final Stream<QuerySnapshot> _myBalasanCount = FirebaseFirestore.instance.collection('balasan').where('id_user', isEqualTo: passIdUser).snapshots();
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _myBalasanCount,
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
          children:  [
            const Text(                     
              'Balasan',
              style: TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )
            ),
            Text(                     
              snapshot.data.size.toString(),
              style: const TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )
            ),    
          ],  
        );

      },
    );
  }
}

class GetCountVerified extends StatefulWidget {
  const GetCountVerified({Key key}) : super(key: key);

  @override
    _GetCountVerifiedState createState() => _GetCountVerifiedState();
}

class _GetCountVerifiedState extends State<GetCountVerified> {
  final Stream<QuerySnapshot> _myBalasanCount = FirebaseFirestore.instance.collection('balasan').where('id_user', isEqualTo: passIdUser).where('status', isEqualTo: "verified").snapshots();
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _myBalasanCount,
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
          children:  [
            const Text(                     
              'Terjawab',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )
            ),
            Text(                     
              snapshot.data.size.toString(),
              style: const TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )
            ),    
          ],  
        );

      },
    );
  }
}
