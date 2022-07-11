import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/main.dart';

class GetTopAsupan extends StatefulWidget {
  const GetTopAsupan({Key key, this.passIdAsupan}) : super(key: key);
  final String passIdAsupan;

  @override
  _GetTopAsupan createState() => _GetTopAsupan();
}

class _GetTopAsupan extends State<GetTopAsupan> {
  final Stream<QuerySnapshot> _jadwalAsupan = FirebaseFirestore.instance.collection('jadwalkalori').limit(5).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _jadwalAsupan,
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
            return Container(
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(10), 
                    //   child:Image.asset("assets/asupan/${data['nama']}.jpg", width: 70, height: 65),
                    // ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "data['nama']", 
                          style: const TextStyle(color: Colors.blue, fontSize: 14)
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "data['kategori']", 
                          style: const TextStyle(color: Colors.grey, fontSize: 13)
                        ),
                        Text(
                          "data['kalori']".toString(), 
                          style: const TextStyle(color: Color(0xFF808080), fontSize: 13)
                        ),
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 40.0),
                    child:const Text("2x", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                  )
                ],
              ),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8),
                border: const Border(
                  left: BorderSide(width: 4.0, color: Colors.orange),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff414141).withOpacity(0.4),
                    blurRadius: 10.0, 
                    spreadRadius: 0.0,
                    offset: const Offset(5.0, 5.0),
                  )
                ],
              ),              
            );
            
          }).toList(),
        );
      },
    );
  }
}

class CountKebutuhanHarian extends StatefulWidget {
  const CountKebutuhanHarian({Key key, this.passIdAsupan}) : super(key: key);
  final String passIdAsupan;

  @override
  _CountKebutuhanHarian createState() => _CountKebutuhanHarian();
}

class _CountKebutuhanHarian extends State<CountKebutuhanHarian> {
  final Stream<QuerySnapshot> _jadwalAsupan = FirebaseFirestore.instance.collection('kebutuhankalori').where('id_user', isEqualTo: passIdUser).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _jadwalAsupan,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator()
          );
        }

        int hari = 0;
        int i = 0;
        int item = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            //Count calorie needed per day.
            hari += data['kalori'];
            i++;

            //Count average if come to the last item.
            if(i == item){
              double avg = hari / item;
              return Text("Kebutuhan Harian : ${avg.toString()}");
            } else {
              return const SizedBox();
            }     
          }).toList(),
        );
      },
    );
  }
}