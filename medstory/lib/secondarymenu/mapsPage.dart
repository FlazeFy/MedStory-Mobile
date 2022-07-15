

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key key, this.passNamaFaskes, this.passIdFaskes ,this.passCoordinateLat, this.passCoordinateLng, this.passAlamat, this.passFasilitas, this.passKontak, this.passPoliklinik}) : super(key: key);

  final String passNamaFaskes;
  final String passIdFaskes;
  final String passAlamat;
  final String passKontak;
  final String passFasilitas;
  final String passPoliklinik;
  final double passCoordinateLat;
  final double passCoordinateLng;

  @override
  _MapsPageState createState() => _MapsPageState(passIdFaskes);
}
class _MapsPageState extends State<MapsPage> with SingleTickerProviderStateMixin {
  _MapsPageState(passIdFakses);
  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final _initialCameraPosition = CameraPosition(
      target: LatLng(widget.passCoordinateLat, widget.passCoordinateLng), //Bandung
      zoom: 14, 
    );
    return Scaffold(     
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: Color(0xFF4169E1),
            size: 35.0,
          ),
          title: Text(widget.passNamaFaskes, 
          style: const TextStyle(
            color: Color(0xFF4169E1),
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        //Transparent setting.
        backgroundColor: const Color(0x44FFFFFF),
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Flexible(      
              child: GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) => _googleMapController = controller,
                markers: {
                  if (_origin != null) _origin,
                  Marker(
                    markerId: MarkerId(widget.passNamaFaskes),
                    infoWindow: InfoWindow(title: widget.passNamaFaskes),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    position: LatLng(widget.passCoordinateLat, widget.passCoordinateLng),
                  )
                },
                onLongPress: _addMarker,
              ),
            ), 
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          'assets/images/${widget.passNamaFaskes}.jpeg', width: 120, height: 80),
                        ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(                     
                            widget.passNamaFaskes,
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
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width*0.6,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: Icon(Icons.location_on, size: 14),
                                  ),
                                  TextSpan(                   
                                    text:widget.passAlamat,
                                    style: const TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 13,
                                    ),
                                  ),
                                ]
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,   
                            )
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
                                  text:widget.passKontak,
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
                  ]
                )
              ]
            ),
            Column(
              children: <Widget>[
                ExpansionTile(
                  initiallyExpanded: true,
                  leading: IconButton(
                    iconSize: 25,
                    icon: const Icon(Icons.info,
                    color: Color(0xFF414141)),
                    onPressed: () {},
                  ),
                  title: const Text(
                    "Detail",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: ListView(
                        children:[ 
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
                                widget.passFasilitas,
                                style: const TextStyle(
                                  color: Color(0xFF6B6B6B),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
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
                                widget.passPoliklinik,
                                style: const TextStyle(
                                  color: Color(0xFF6B6B6B),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
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
                                'Praktik Dokter',
                                style: TextStyle(
                                  color: Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )
                              ),   
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height*0.3,
                              child: GetDokter(idFaskes: widget.passIdFaskes),
                            )
                          ),
                          const SizedBox(height: 10)
                        ]
                      )
                    )
                  ]
                )
              ]
            ),
          ],
        )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF1F9F2F),
          foregroundColor: Colors.white,
          onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition),
          ),
          child: const Icon(Icons.center_focus_strong),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop
    );
  }
  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
        // Reset destination
        _destination = null;
      });
    } 
  }
}

class GetDokter extends StatefulWidget {
  const GetDokter({Key key, this.idFaskes}) : super(key: key);
  final String idFaskes;

  @override
    _GetDokterState createState() => _GetDokterState();
}

class _GetDokterState extends State<GetDokter> {
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
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_faskes'] == widget.idFaskes){
              i++;
              return Card(
                child:Container(
                  width: 150,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        child: Image.asset(
                        'assets/images/dokter/${data['namaDokter']}.jpg', width: MediaQuery.of(context).size.width),
                      ),
                      Container(
                        padding: const EdgeInsets.all(7.0),
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