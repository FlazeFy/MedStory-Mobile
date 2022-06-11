import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class NavDrawer extends StatelessWidget {
  var pass_username;
  var pass_id_userNav;

  NavDrawer({Key key, this.pass_username, this.pass_id_userNav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Text(
                  'Kebutuhan Kalori',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height:10),
                Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Detail',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Tinggi Badan: ',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            '180',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Berat Badan: ',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            '65',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.08),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Hari Ini',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          //Kalori grafik
                        ],
                      )
                    ),
                  ],
                )
              ],
            ), 
            decoration: BoxDecoration(
              color: Color(0xFF4183D7),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 46,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(width: 2.0, color: Color(0xFF22A7F0))
                      ),
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Row(
                            children: [
                              Text(                     
                                'Asupan Hari Ini',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                )
                              ),
                              SizedBox(width:5),
                              DropDown()
                            ],
                          ),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height*0.6,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //Sayuran
                                    Container(
                                      child: IconButton(
                                        icon: const Icon(Icons.info),
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.blue,
                                      ) 
                                    ),
                                    SizedBox(width: 5),
                                    //Buah-Buahan
                                    Container(
                                      child: IconButton(
                                        icon: const Icon(Icons.apple),
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.blue,
                                      ) 
                                    ),
                                    SizedBox(width: 5),
                                    //Daging
                                    Container(
                                      child: IconButton(
                                        icon: const Icon(Icons.info),
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.blue,
                                      ) 
                                    ),
                                    SizedBox(width: 5),
                                    //Seafood
                                    Container(
                                      child: IconButton(
                                        icon: const Icon(Icons.info),
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.blue,
                                      ) 
                                    ),
                                    SizedBox(width: 5),
                                    //Lainnya
                                    Container(
                                      child: IconButton(
                                        icon: const Icon(Icons.rice_bowl),
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.blue,
                                      ) 
                                    ),
                                  ]
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(                     
                                    'Menampilkan ... item Sayuran',
                                    style: const TextStyle(
                                      color: Color(0xFF808080),
                                      fontSize: 12,
                                    )
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.50,
                                  width: MediaQuery.of(context).size.width*1.2,
                                  child: Flexible(
                                    child: GetAllAsupan(pass_kategori: "Lainnya")
                                  )
                                )
                              ]
                            ),                          
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Batal', style: TextStyle(color: Color(0xFFd9534f))),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                  // Respond to button press
                              },
                              child: Text('Simpan'),
                            ),
                          ],
                        ),
                      ),
                      icon: Icon(Icons.add, size: 18, color: Color(0xFF22A7F0)),
                      label: Text("Tambah Asupan", style: TextStyle(color: Color(0xFF22A7F0), fontSize: 15)),
                    ),
                  ),
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
                      onPressed: () {},
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.green,
                    ) 
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text(
                    'Total: ',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.25),
                  Text(
                    'Sisa: ',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 25,
                      )),
                ),
                Text(
                  "Hari ini", 
                  style: TextStyle(color: Colors.grey, fontSize: 14)
                ),
                Expanded(
                  child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 25,
                    )
                  ),
                ),
              ]),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.width*0.74,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: GetAsupanDayById(pass_documentId: pass_id_userNav)
                ),
              ],
            )
          ),
          Expanded(
            child: Align(
            alignment: Alignment.bottomLeft,
              child: ListTile(
                tileColor: const Color(0xFF4183D7),
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text('Pengaturan'),  
                textColor: Colors.white,
                onTap: () {
                  // Navigator.push(
                  //   context, MaterialPageRoute(
                  //     builder: (context) => const LoginPage(),
                  //   ),
                  // );
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
            alignment: Alignment.bottomLeft,
              child: ListTile(
                tileColor: const Color(0xFFe14141),
                leading: const Icon(Icons.exit_to_app, color: Colors.white),
                title: const Text('Ganti Akun'),  
                textColor: Colors.white,
                onTap: () {
                  // Navigator.push(
                  //   context, MaterialPageRoute(
                  //     builder: (context) => const LoginPage(),
                  //   ),
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GetAsupanDayById extends StatefulWidget {
  const GetAsupanDayById({Key key, this.pass_documentId}) : super(key: key);
  final String pass_documentId;

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
          return const CircularProgressIndicator();
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return GetAsupanDetailById(pass_id_asupan: data['id_asupan']);
          }).toList(),
        );
      },
    );
  }
}

class GetAsupanDetailById extends StatefulWidget {
  const GetAsupanDetailById({Key key, this.pass_id_asupan}) : super(key: key);
  final String pass_id_asupan;

  @override
  _GetAsupanDetailById createState() => _GetAsupanDetailById();
}

class _GetAsupanDetailById extends State<GetAsupanDetailById> {
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
          return const CircularProgressIndicator();
        }

        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(document.id == widget.pass_id_asupan){
              return Container(
                height: 70,
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
                            style: TextStyle(color: Colors.blue, fontSize: 14)
                          ),
                          SizedBox(height: 2),
                          Text(
                            data['kategori'], 
                            style: TextStyle(color: Colors.grey, fontSize: 13)
                          ),
                          Text(
                            data['kalori'].toString(), 
                            style: TextStyle(color: Color(0xFF808080), fontSize: 13)
                          ),
                        ],
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child:IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.white,
                        onPressed: () {},
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
                  border: Border(
                    left: BorderSide(width: 4.0, color: Colors.orange),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff414141).withOpacity(0.4),
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
            } else {
              return SizedBox(height: 0);
            }
          }).toList(),
        );
      },
    );
  }
}

class GetAllAsupan extends StatefulWidget {
  const GetAllAsupan({Key key, this.pass_kategori}) : super(key: key);
  final String pass_kategori;

  @override
  _GetAllAsupan createState() => _GetAllAsupan();
}

class _GetAllAsupan extends State<GetAllAsupan> {
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
          return const CircularProgressIndicator();
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['kategori'] == widget.pass_kategori){
              return Container(
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
                            style: TextStyle(color: Colors.blue, fontSize: 14)
                          ),
                          SizedBox(height: 2),
                          Text(
                            data['kategori'], 
                            style: TextStyle(color: Colors.grey, fontSize: 13)
                          ),
                          Text(
                            data['kalori'].toString(), 
                            style: TextStyle(color: Color(0xFF808080), fontSize: 13)
                          ),
                        ],
                      )
                    ),
                    Container(
                      child: Chechbox(),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(8),
                  border: Border(
                    left: BorderSide(width: 4.0, color: Colors.orange),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff414141).withOpacity(0.4),
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: const Offset(
                        5.0, // Move to right 10  horizontally
                        5.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                )
              );   
            } else {
              return SizedBox(height: 0);
            }       
              
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

class Chechbox extends StatefulWidget {
  const Chechbox({Key key}) : super(key: key);

  @override
  State<Chechbox> createState() => _ChechboxState();
}

class _ChechboxState extends State<Chechbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Color(0xFF808080);
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}