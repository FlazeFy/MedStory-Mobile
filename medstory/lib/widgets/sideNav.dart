import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import '../main.dart';

int kebutuhan = 0;
int checkCal = 0;

class NavDrawer extends StatelessWidget{
  var passUsername = "";
  var passIdUserNav = "";
  int passCalorie = 0;

  NavDrawer({Key key, this.passUsername, this.passIdUserNav}) : super(key: key);

  Widget getButtonCalorie(BuildContext context){
    CollectionReference kebutuhanCal = FirebaseFirestore.instance.collection('kebutuhankalori');
    if(checkCal != 0){
      return Container(
        height: 46,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: const BorderSide(width: 2.0, color: Color(0xFF22A7F0))
          ),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Row(
                children: const [
                  Text(                     
                    'Asupan Hari Ini',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    )
                  ),
                  SizedBox(width:5),
                  DropDown()
                ],
              ),
              content: Container(
                transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                height: MediaQuery.of(context).size.height*0.55,
                child: Column(
                  children: [
                    AutocompleteBasicExample(),
                    SizedBox(   
                      height: MediaQuery.of(context).size.height*0.48,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: const Flexible(
                        child: GetAllAsupan()
                      ),
                    )
                  ]               
                )
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Batal', style: TextStyle(color: Color(0xFFd9534f))),
                ),
                ElevatedButton(
                  onPressed: () {
                
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
          icon: const Icon(Icons.add, size: 18, color: Color(0xFF22A7F0)),
          label: const Text("Tambah Asupan", style: TextStyle(color: Color(0xFF22A7F0), fontSize: 15)),
        ),
      );
    } else {
      return Container(
        height: 46,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF22A7F0),
          ),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Kebutuhan Kalori'),
              content: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                height: 50,
                child: SpinBox(
                  min: 800, max: 3000,
                  value: 1800,
                  spacing: 1,
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                  ),
                  onChanged: (value) => passCalorie = value.toInt(),
                  decoration: const InputDecoration(labelText: 'Kalori (Cal)'),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    
                    return kebutuhanCal
                    .add({
                      'id_user': passIdUser,
                      'kalori': passCalorie,
                      'date': DateTime.tryParse(DateTime.now().toIso8601String()),
                    })
                    .then((value) => Navigator.pop(context))
                    .catchError((error) => print("Failed to add kaloris: $error"));
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Tambah'),
                ),
              ],
            ),
          ),
          icon: const Icon(Icons.add, size: 18),
          label: const Text("Tambah Kalori", style: TextStyle(fontSize: 15)),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Flexible(
              child: DrawerHeader(
                child: Column(
                  children: [
                    const Text(
                      'Kebutuhan Kalori',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height:5),
                    Row(
                      children: [
                        const GetBeratTinggi(),
                        Column(
                          children: [
                            const Text(
                              'Hari Ini',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            //Kalori grafik
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.08,
                              width: MediaQuery.of(context).size.width*0.37,
                              child: const GetKebutuhanKalori()
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ), 
                decoration: const BoxDecoration(
                  color: Color(0xFF4183D7),
                ),
              ),
              
            ),
            Column(
              children: [
                Row(
                  children: [
                    getButtonCalorie(context),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: IconButton(
                        icon: const Icon(Icons.calendar_month),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.blue,
                      ) 
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child:IconButton(
                        icon: const Icon(Icons.refresh),
                        color: Colors.white,
                        onPressed: () {
                        //
                        },
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.green,
                      ) 
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    const Text(
                      'Total: ',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.25),
                    const Text(
                      'Sisa: ',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 25,
                        )),
                  ),
                  const Text(
                    "Hari ini", 
                    style: TextStyle(color: Colors.grey, fontSize: 14)
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 25,
                      )
                    ),
                  ),
                ]),
              ],
            ),
            Expanded(
              child:GetAsupanDayById(passDocumentId: passIdUserNav)
            )    
          ],
        ),
      )
    );
  }
}

class GetKebutuhanKalori extends StatefulWidget {
  const GetKebutuhanKalori({Key key}) : super(key: key);

  @override
    _GetKebutuhanKaloriState createState() => _GetKebutuhanKaloriState();
}

class _GetKebutuhanKaloriState extends State<GetKebutuhanKalori> {
  final Stream<QuerySnapshot> _kebutuhan = FirebaseFirestore.instance.collection('kebutuhankalori').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _kebutuhan,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

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
            
            if((formattedDate == formattedNow)&&(data['id_user'] == passIdUser)){
              checkCal = data['kalori'];
              return Text("${data['kalori'].toString()} Cal", style: const TextStyle(color: Colors.white)); 
            } 
            return const SizedBox(height: 0);
          }).toList(),
        );
      },
    );
  }
}

class GetBeratTinggi extends StatelessWidget {
  const GetBeratTinggi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('pengguna');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(passIdUser).get(),
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
          return Column(
            children: [
              const Text(
                'Detail',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tinggi Badan: ',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                data['tinggiBadan'].toString(),
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Berat Badan: ',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                data['beratBadan'].toString(),
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          );
        }

        return const Center( 
          child: CircularProgressIndicator()
        );
      },
    );
  }
}

class GetAsupanDayById extends StatefulWidget {
  const GetAsupanDayById({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _GetAsupanDayById createState() => _GetAsupanDayById();
}

class _GetAsupanDayById extends State<GetAsupanDayById> {
  // GetAsupanDayById(this.documentId);
  final Stream<QuerySnapshot> _jadwalasupan = FirebaseFirestore.instance.collection('jadwalkalori').snapshots();

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

        return ListView(
          padding: const EdgeInsets.only(top: 0),
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
            
            if((formattedDate == formattedNow)&&(data['id_user'] == passIdUser)){
              return GetAsupanDetailById(passIdAsupan: data['id_asupan'], passIdJadwal: document.id);
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}

class GetAsupanDetailById extends StatefulWidget {
  const GetAsupanDetailById({Key key, this.passIdAsupan, this.passIdJadwal}) : super(key: key);
  final String passIdAsupan;
  final String passIdJadwal;

  @override
  _GetAsupanDetailById createState() => _GetAsupanDetailById();
}

class _GetAsupanDetailById extends State<GetAsupanDetailById> {
  // GetAsupanDayById(this.documentId);
  final Stream<QuerySnapshot> _detailasupan = FirebaseFirestore.instance.collection('asupan').snapshots();

  CollectionReference jadwalAsupan = FirebaseFirestore.instance.collection('jadwalkalori');

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
            if(document.id == widget.passIdAsupan){
              return Container(
                height: 80,
                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10), 
                        child:Image.asset("assets/asupan/${data['nama']}.jpg", width: 70, height: 65),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['nama'], 
                            style: const TextStyle(color: Colors.blue, fontSize: 14)
                          ),
                          const SizedBox(height: 2),
                          Text(
                            data['kategori'], 
                            style: const TextStyle(color: Colors.grey, fontSize: 13)
                          ),
                          Text(
                            data['kalori'].toString(), 
                            style: const TextStyle(color: Color(0xFF808080), fontSize: 13)
                          ),
                        ],
                      )
                    ),
                    Container(
                      child:IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.white,
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Apakah Anda yakin?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  return jadwalAsupan
                                    .doc(widget.passIdJadwal)
                                    .delete()
                                    .then((value) => print("Asupan Deleted"))
                                    .catchError((error) => print("Gagal menghapus asupan: $error"));
                                },
                                child: const Text('Ya'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.red,
                      ) 
                    ),
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
            } else {
              return const SizedBox(height: 0);
            }
          }).toList(),
        );
      },
    );
  }
}

class GetAllAsupan extends StatefulWidget {
  const GetAllAsupan({Key key}) : super(key: key);

  @override
  _GetAllAsupan createState() => _GetAllAsupan();
}

class _GetAllAsupan extends State<GetAllAsupan> {
  // GetAsupanDayById(this.documentId);
  final Stream<QuerySnapshot> _detailasupan = FirebaseFirestore.instance.collection('asupan').snapshots();

  @override
  Widget build(BuildContext context) {
    CollectionReference calday = FirebaseFirestore.instance.collection('jadwalkalori');

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

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            
            return GestureDetector(
              onTap: (){
                // print(document.id);
              },
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width*0.6,
                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10), 
                        child:Image.asset("assets/asupan/${data['nama']}.jpg", width: 60, height: 55),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.26,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['nama'], 
                            style: const TextStyle(color: Colors.blue, fontSize: 14)
                          ),
                          const SizedBox(height: 2),
                          Text(
                            data['kategori'], 
                            style: const TextStyle(color: Colors.grey, fontSize: 13)
                          ),
                          Text(
                            data['kalori'].toString(), 
                            style: const TextStyle(color: Color(0xFF808080), fontSize: 13)
                          ),
                        ],
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child:IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () async {
                          return calday
                          .add({
                            'id_asupan': document.id,
                            'id_user': passIdUser, 
                            'waktu': passWaktu,
                            'date': DateTime.tryParse(DateTime.now().toIso8601String()),
                          })
                          .then((value) => print("Asupan berhasil ditambah"))
                          .catchError((error) => print("Failed to add user: $error"));
                        },
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.green,
                      ) 
                    ),
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
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: const Offset(
                        5.0, // Move to right 10  horizontally
                        5.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                )
              )
            );   
       
              
          }).toList(),
        );
      },
    );
  }
}

//Dropdown kategori
class DropDown extends StatefulWidget {
  const DropDown({Key key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = 'Pagi';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Color(0xFF212121)),
      underline: Container(
        height: 2,
        color: const Color(0xFF4183D7),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          passWaktu = dropdownValue;
        });
      },
      items: <String>['Pagi', 'Siang', 'Malam']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  AutocompleteBasicExample({Key key}) : super(key: key);
  final Stream<QuerySnapshot> _detailasupan = FirebaseFirestore.instance.collection('asupan').snapshots();

  static final List<String> _kOptions = <String>[
    'Nasi', 'Capcay', 'Rendang sapi'
  ];
  //Cant convert querysnapshot to string list

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}