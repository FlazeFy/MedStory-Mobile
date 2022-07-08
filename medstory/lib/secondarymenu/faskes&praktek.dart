import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medstory/secondarymenu/mapsPage.dart';

class GetFaskes extends StatelessWidget {
  GetFaskes({Key key}) : super(key: key);

  final Stream<QuerySnapshot> _faskes = FirebaseFirestore.instance.collection('faskes').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _faskes,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  child: Column(
                  children: [
                    Align(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [ 
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/images/${data['namaFaskes']}.jpeg', width: 120, height: 80),
                              ),
                            ),
                                    
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.55,
                              child: Column (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(                     
                                      data['namaFaskes'],
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(Icons.location_on, size: 14),
                                          ),
                                          TextSpan(                   
                                            text:data['alamat'],
                                            style: const TextStyle(
                                              color: Color(0xFF212121),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ]
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,   
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(Icons.call_sharp, size: 14),
                                          ),
                                          TextSpan(                   
                                            text:data['kontak'],
                                            style: const TextStyle(
                                              color: Color(0xFF212121),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ]
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,   
                                    ),
                                  )                          
                                ]
                              ),
                            ),
                            
                          ]
                        )    
                      )                   
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const Text(                     
                          'Fasilitas',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )
                        ),   
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(                     
                          data['fasilitas'],
                          style: const TextStyle(
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),   
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const Text(                     
                          'Poliklinik',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )
                        ),   
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(                     
                          data['poliklinik'],
                          style: const TextStyle(
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),   
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical:5),
                      child: Row(
                        children: [            
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => MapsPage(passNamaFaskes: data['namaFaskes'], passCoordinateLat: double.tryParse(data['lat']), passCoordinateLng: double.tryParse(data['lng']), 
                                    passAlamat: data['alamat'], passKontak: data['kontak'], passFasilitas: data['fasilitas'], passPoliklinik: data['poliklinik'], passIdFaskes: document.id),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
                                    final curvedAnimation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.ease,
                                    );

                                    return SlideTransition(
                                      position: tween.animate(curvedAnimation),
                                      child: child,
                                    );
                                  }
                                ),
                              );
                            },
                            icon: const Icon(Icons.info, size: 14),
                            label: const Text("Detail"),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1F9F2F)),
                            ),

                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton.icon(
                            onPressed: () {
                              var contact= data['lat']+", "+data['lng'];
                              Clipboard.setData(ClipboardData(text: contact));         
                            },
                            icon: const Icon(Icons.copy, size: 14),
                            label: const Text("Kordinat"),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.3,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                              child: Image.asset(
                                'assets/images/Rating.png', width: 20),
                              ),
                              Text(                     
                                data['rating'].toString(),
                                style: const TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )
                              ),   
                            ],
                          )
                        ]
                      ) 
                    ),       
                  ]

                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: const Offset(
                        5.0, // Move to right 10  horizontally
                        5.0, // Move to bottom 10 Vertically
                      ),
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

class GetPraktek extends StatelessWidget {
  GetPraktek({Key key}) : super(key: key);

  final Stream<QuerySnapshot> _faskes = FirebaseFirestore.instance.collection('dokterpraktik').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _faskes,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        return ListView(
          children: [
            Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  leading: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(25), // Image radius
                      child: Image.asset('assets/icon/Doctor.png', fit: BoxFit.cover),
                    ),
                  ),
                  title: const Text('Umum'),
                  subtitle: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: TextStyle(color: Colors.grey)),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: const Flexible(        
                        child: GetDokterSpesialis(spesialis: "Umum"),
                      )
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: ExpansionTile(
                  leading: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(25), // Image radius
                      child: Image.asset('assets/icon/DAnak.png', fit: BoxFit.cover),
                    ),
                  ),
                  title: const Text('Anak'),
                  subtitle: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: TextStyle(color: Colors.grey)),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: const Flexible(        
                        child: GetDokterSpesialis(spesialis: "Anak"),
                      )
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: ExpansionTile(
                  leading: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(25), // Image radius
                      child: Image.asset('assets/icon/DGigi.png', fit: BoxFit.cover),
                    ),
                  ),
                  title: const Text('Gigi'),
                  subtitle: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: TextStyle(color: Colors.grey)),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: const Flexible(        
                        child: GetDokterSpesialis(spesialis: "Gigi"),
                      )
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: ExpansionTile(
                  leading: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(25), // Image radius
                      child: Image.asset('assets/icon/DMata.png', fit: BoxFit.cover),
                    ),
                  ),
                  title: const Text('Mata'),
                  subtitle: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: TextStyle(color: Colors.grey)),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: const Flexible(        
                        child: GetDokterSpesialis(spesialis: "Mata"),
                      )
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: ExpansionTile(
                  leading: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(25), // Image radius
                      child: Image.asset('assets/icon/DKulit.png', fit: BoxFit.cover),
                    ),
                  ),
                  title: const Text('Kulit & Kelamin'),
                  subtitle: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: TextStyle(color: Colors.grey)),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: const Flexible(        
                        child: GetDokterSpesialis(spesialis: "Kulit & Kelamin"),
                      )
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: ExpansionTile(
                  leading: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(25), // Image radius
                      child: Image.asset('assets/icon/DOrtopedi.png', fit: BoxFit.cover),
                    ),
                  ),
                  title: const Text('Ortopedi'),
                  subtitle: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: TextStyle(color: Colors.grey)),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: const Flexible(        
                        child: GetDokterSpesialis(spesialis: "Ortopedi"),
                      )
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: ExpansionTile(
                  leading: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(25), // Image radius
                      child: Image.asset('assets/icon/DTHT.png', fit: BoxFit.cover),
                    ),
                  ),
                  title: const Text('THT'),
                  subtitle: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: TextStyle(color: Colors.grey)),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: const Flexible(        
                        child: GetDokterSpesialis(spesialis: "THT"),
                      )
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        );
          
      },
    );
  }
}

class GetDokterSpesialis extends StatefulWidget {
  const GetDokterSpesialis({Key key, this.spesialis}) : super(key: key);
  final String spesialis;

  @override
    _GetDokterSpesialisState createState() => _GetDokterSpesialisState();
}

class _GetDokterSpesialisState extends State<GetDokterSpesialis> {
  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('dokterpraktik').snapshots();
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _diskusi,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        return ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['spesialis'] == widget.spesialis){
              i++;
              return Card(
                child:Container(
                  width: 150,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: const Radius.circular(10), topRight: const Radius.circular(10)),
                        child: Image.asset(
                        'assets/images/dokter/${data['namaDokter']}.jpg', width: MediaQuery.of(context).size.width),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(                     
                                data['namaDokter'],
                                style: const TextStyle(
                                  color: Color(0xFF4285D2),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(                     
                                "Dokter ${data['spesialis']}",
                                style: const TextStyle(
                                  color: Color(0xFFFC46AA),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(                     
                                data['hariPraktik'],
                                style: const TextStyle(
                                  color: Color(0xFF808080),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(                     
                                "Pukul ${data['jamMulai'].substring(0, 5)}-${data['jamSelesai'].substring(0, 5)}",
                                style: const TextStyle(
                                  color: Color(0xFF696969),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFbbd4ec), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: const Offset(
                          5.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                )
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