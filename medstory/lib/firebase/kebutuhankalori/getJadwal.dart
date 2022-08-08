import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/firebase/kebutuhankalori/getAsupan.dart';
import 'package:medstory/main.dart';
import 'package:medstory/widgets/sideNav.dart';

int finalCountFF = 0;

class GetJadwal extends StatefulWidget {
  @override
  GetJadwal({Key key, this.passTotal}) : super(key: key);
  int passTotal;

  @override
  _GetJadwalState createState() => _GetJadwalState();
}

class _GetJadwalState extends State<GetJadwal> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('jadwalkalori').where('id_user', isEqualTo: passIdUser).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        //Count fulfilled calorie
        int totalItem1 = 0;
        int totalCalorie1 = 0;

        //Count left calorie
        int totalItem2 = 0;
        int totalCalorie2 = 0;

        int i = 0;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            //Get jadwal kalori by date.
            var dt = DateTime.fromMicrosecondsSinceEpoch(data['date'].microsecondsSinceEpoch).toString();
            var date = DateTime.parse(dt);
            var formattedDate = "${date.day}-${date.month}-${date.year}";

            //Get today date.
            var now = DateTime.now().toString();
            var now2 = DateTime.parse(now);
            var formattedNow = "${now2.day}-${now2.month}-${now2.year}";
            
            if(formattedDate == formattedNow){
              i++;
              totalItem1++;
              return CountCalorieFF(passDocumentId: data['id_asupan']);
            } else {
              i++;
            }

            if(i == snapshot.data.size){
              if(totalItem1 > 0){
                finalCountFF = totalItem1;
                return CountCalorieFF(passDocumentId: data['id_asupan'], passTotal: totalItem1);
              } else if(totalItem1 == 0) {
                return const SizedBox();
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