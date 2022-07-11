import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/main.dart';

//Initial variable.
int item = 0;

double asupanFinal = 0; //To store final value of count total of asupan's calorie.
int asupanNew = 0; //Count total asupan's calorie

int x = 0; //Check if asupan's looping same as jadwal's looping
int jadwalCount = 0; //Count user's asupan

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
                        const Text(
                          "data['nama']", 
                          style: TextStyle(color: Colors.blue, fontSize: 14)
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "data['kategori']", 
                          style: TextStyle(color: Colors.grey, fontSize: 13)
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
        item = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            //Count calorie needed per day.
            hari += data['kalori'];
            i++;

            //Count average if come to the last item.
            if(i == item){
              double avg = hari / item;
              return Text("Kebutuhan Harian : ${double.parse((avg).toStringAsFixed(2)).toString()} Cal");
            } else {
              return const SizedBox();
            }     
          }).toList(),
        );
      },
    );
  }
}

class CountTerpenuhiHarian extends StatefulWidget {
  const CountTerpenuhiHarian({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _CountTerpenuhiHarian createState() => _CountTerpenuhiHarian();
}

class _CountTerpenuhiHarian extends State<CountTerpenuhiHarian> {
  final Stream<QuerySnapshot> _jadwalasupan = FirebaseFirestore.instance.collection('jadwalkalori').where('id_user', isEqualTo: passIdUser).snapshots();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _jadwalasupan,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator()
          );
        }

        int asupanCal = 0;
        int i = 0;
        jadwalCount = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            i++;

            //Count average if come to the last item.
            if(i == jadwalCount){
              asupanFinal = asupanFinal / item;
              return Text("Terpenuhi Harian : ${double.parse((asupanFinal).toStringAsFixed(2)).toString()} Cal");
            } else {
              return GetMyAsupanDetailById(passIdAsupan: data['id_asupan']);
            }    
          }).toList(),
        );
      },
    );
  }
}

class GetMyAsupanDetailById extends StatefulWidget {
  const GetMyAsupanDetailById({Key key, this.passIdAsupan}) : super(key: key);
  final String passIdAsupan;

  @override
  _GetMyAsupanDetailById createState() => _GetMyAsupanDetailById();
}

class _GetMyAsupanDetailById extends State<GetMyAsupanDetailById> {
  // GetAsupanDayById(this.documentId);
  final Stream<QuerySnapshot> _detailasupan = FirebaseFirestore.instance.collection('asupan').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _detailasupan,
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
            if(x < jadwalCount){
              
              if(document.id == widget.passIdAsupan){
                //Count caloire of each asupan.
                x++;
                asupanNew += data['kalori'];
                return const SizedBox();
              } 
              return const SizedBox();  
            } else {
              asupanFinal = asupanNew.toDouble();
              return const SizedBox(); 
            }
          }).toList(),
        );
      },
    );
  }
}