import 'package:flutter/material.dart';
import 'package:medstory/mainMenu/faskes&praktek/tabDokter.dart';
import 'package:medstory/mainMenu/faskes&praktek/tabFaskes.dart';
import 'package:medstory/widgets/sideNav.dart';

class DaruratPage extends StatefulWidget {
  const DaruratPage({Key key, this.passUsername, this.passIdUser}) : super(key: key);

  final String passUsername;
  final String passIdUser;

  @override

  _DaruratPage createState() => _DaruratPage();
}

class _DaruratPage extends State<DaruratPage> { 
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: NavDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: fullHeight*0.05),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("  Nomor Darurat",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600
                  )         
                ),
              ),
            ),
            DefaultTabController(
              length: 2,
              child: Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      constraints: const BoxConstraints(maxHeight: 150.0),
                      child: const Material(
                        color: Colors.transparent,
                        child: TabBar(
                          indicatorColor: Colors.transparent,
                          tabs: [
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Fasilitas Kesehatan"),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Dokter Praktek"),
                              ),
                            ),
                          ],
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            color: Color.fromARGB(255, 166, 204, 242),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                          children: [
                            GetFaskes(),
                            GetPraktek(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),  
          ], 
        )
      )
    );
  }
}
