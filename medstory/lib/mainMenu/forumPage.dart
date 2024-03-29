

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medstory/firebase/forum/getDiskusi.dart';
import 'package:medstory/main.dart';
import 'package:medstory/secondaryMenu/newsItem.dart';
import 'package:medstory/secondaryMenu/myDiskusiPage.dart';
import 'package:medstory/secondaryMenu/statisticPage.dart';
import 'package:medstory/widgets/custombg.dart';
import 'package:medstory/widgets/sideNav.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key key, this.passUsername, this.passIdUser}) : super(key: key);

  final String passUsername;
  final String passIdUser;

  @override

  _ForumPage createState() => _ForumPage();
}

class _ForumPage extends State<ForumPage> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: NavDrawer(passUsername: widget.passUsername),
      body: CustomPaint(
        painter : CurvedPainter2(),
        child : SizedBox(
          height: MediaQuery.of(context).size.height,   
          child: ListView(
            padding: EdgeInsets.only(top: fullHeight*0.05),
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  Informasi Kesehatan",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )         
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                height: 210.0,
                enlargeCenterPage: true,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    indexNews = index;
                  });
                },
              ),
              items: imageSliders
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(imgList, (index, url) {
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: indexNews == index ? const Color(0xFF28CF36) : Colors.grey,
                  ),
                );
              }),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("  Forum Diskusi",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                      )         
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                      child: const DropDown(),
                    )
                  ),
                  Container(
                    transform: Matrix4.translationValues(15.0, 0.0, 0.0),
                    child: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.add),
                            title: const Text('Pertanyaan Ku'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyDiscussionPage(passUsername: passUsername)),
                              );
                            },
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.auto_graph),
                            title: const Text('Statistik'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const StatisticsPage()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ),
            ),
            Flexible(
              child: GetDiskusi(),
            )
          ],  
        )
        ),
      )
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
  String dropdownValue = 'Semua';

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
      items: <String>['Semua', 'Penyakit Dalam', 'Penyakit Menular', 'Vaksin & Imunisasi', 'Kulit & Kelamin', 'Otot & Saraf', 'THT & Mata', 'Penyakit Lansia', 'Obat-Obatan', 'Gaya Hidup Sehat', 'Kandungan & Bedah', 'Gigi', 'Anak']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

