import 'package:flutter/material.dart';
import 'package:medstory/widgets/sideNav.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() { runApp(const MyApp()); }

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Leonardho R Sitanggang-1302194041",
      home: const NavBar(), //Navbar
    );
  }
}
class NavBar extends StatefulWidget {
  const NavBar({Key key, this.pass_usernameNav}) : super(key: key);
  final String pass_usernameNav;
  
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static var _usernamePass;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      ForumPage(pass_username: widget.pass_usernameNav),
      SmartDocPage(pass_username: widget.pass_usernameNav),
      DataKuPage(pass_username: widget.pass_usernameNav),
      DaruratPage(pass_username: widget.pass_usernameNav),
    ];
  
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.forum),
              label: 'Forum',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: 'SmartDoc',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'DataKu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Darurat',
            ),
          ],
          //Selected menu style.
          showUnselectedLabels: true,
          selectedItemColor: const Color(0xFF4183D7),
          unselectedItemColor: const Color(0xFF414141),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          
        ),
    );
  }
}

class ForumPage extends StatefulWidget {
  const ForumPage({Key key, this.pass_username}) : super(key: key);

  final String pass_username;

  @override

  _ForumPage createState() => _ForumPage();
}

class _ForumPage extends State<ForumPage> {
  
  int _currentIndex=0;

  List cardList=[
    const Item1(),
    const Item2(),
    const Item3(),
    const Item4()
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: const Color(0xFF4183D7),
            size: 35.0,
          ),
        title: Text("Welcome, ${widget.pass_username}", 
        style: const TextStyle(
          color: Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      
      actions: [
        IconButton(
          icon: Image.asset('assets/images/User.jpg'),
          iconSize: 50,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AccountPage(pass_username: widget.pass_username)),
            // );
          },
        )
      ],

        //Transparent setting.
        backgroundColor: const Color(0x44FFFFFF),
        elevation: 0,
      ),

      //Body.
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("  Informasi Kesehatan",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )         
                ),
              ),
              CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: cardList.map((card){
                return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: const Color(0xff22A7F0),
                        child: card,
                      ),
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.circular(10),
                      )
                    );
                  }
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(cardList, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? const Color(0xFF28CF36) : Colors.grey,
                  ),
                );
              }),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("  Forum Diskusi",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500
                )         
              ),
            ),
            Flexible(
              // child: ListView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  height: 162,
                  child: Card(
                    child: Column(
                    children: [
                      Align(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [ 
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/images/User.jpg', width: 40),
                                  ),
                              ),
                                     
                              Container(
                                width: MediaQuery.of(context).size.width*0.73,
                                child: Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(                     
                                          "Penyakit Dalam",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          )
                                        ),   
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(                     
                                          "flazefy ~ yesterday at 09.00 pm",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          )
                                        ),   
                                      ),
                                    )                          
                                  ]
                                ),
                              ),
                              Container(
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/verified.png', width: 30),
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
                          child: Text(                     
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            )
                          ),   
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [            
                            TextButton.icon(
                              onPressed: () {
                                  // Respond to button press
                              },
                              icon: Icon(Icons.arrow_drop_down, size: 14),
                              label: Text("Lihat komentar (3)"),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.2,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                  // Respond to button press
                              },
                              icon: Icon(Icons.arrow_upward, size: 14),
                              label: Text("2"),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                  // Respond to button press
                              },
                              icon: Icon(Icons.remove_red_eye, size: 14),
                              label: Text("20"),
                            ),
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
                    borderRadius: BorderRadius.circular(80), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 20.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: const Offset(
                          5.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                )
                 
              )

            ], 

        )
      )
      
    );
  }
}

class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News1.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Resmi! Kasus Aktif Covid-19 di Indonesia Kalahkan India",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-1");
      },
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News2.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Menkes: Vaksin Moderna untuk Nakes karena Stok Terbatas",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-2");
      },
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News3.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Susul Moderna, Vaksin Pfizer Sebentar Lagi Dapat Izin di RI",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-3");
      },
    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News4.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Cara mengatasi penyakit maag agar tidak kambuh lagi",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-4");
      },
    );
  }
}

class SmartDocPage extends StatefulWidget {
  const SmartDocPage({Key key, this.pass_username}) : super(key: key);

  final String pass_username;

  @override

  _SmartDocPage createState() => _SmartDocPage();
}

class _SmartDocPage extends State<SmartDocPage> {
  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: const Color(0xFF4183D7),
            size: 35.0,
          ),
        title: Text("Welcome, ${widget.pass_username}", 
        style: const TextStyle(
          color: Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      
      actions: [
        IconButton(
          icon: Image.asset('assets/images/User.jpg'),
          iconSize: 50,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AccountPage(pass_username: widget.pass_username)),
            // );
          },
        )
      ],

        //Transparent setting.
        backgroundColor: const Color(0x44FFFFFF),
        elevation: 0,
      ),

      //Body.
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: const [
              
          ], 

        )
      )
      
    );
  }
}

class DataKuPage extends StatefulWidget {
  const DataKuPage({Key key, this.pass_username}) : super(key: key);

  final String pass_username;

  @override

  _DataKuPage createState() => _DataKuPage();
}

class _DataKuPage extends State<DataKuPage> {
  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: Color(0xFF4183D7),
            size: 35.0,
          ),
        title: Text("Welcome, ${widget.pass_username}", 
        style: const TextStyle(
          color: const Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      
      actions: [
        IconButton(
          icon: Image.asset('assets/images/User.jpg'),
          iconSize: 50,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AccountPage(pass_username: widget.pass_username)),
            // );
          },
        )
      ],

        //Transparent setting.
        backgroundColor: const Color(0x44FFFFFF),
        elevation: 0,
      ),

      //Body.
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: const [
              
          ], 

        )
      )
      
    );
  }
}

class DaruratPage extends StatefulWidget {
  const DaruratPage({Key key, this.pass_username}) : super(key: key);

  final String pass_username;

  @override

  _DaruratPage createState() => _DaruratPage();
}

class _DaruratPage extends State<DaruratPage> {
  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: Color(0xFF4183D7),
            size: 35.0,
          ),
        title: Text("Welcome, ${widget.pass_username}", 
        style: const TextStyle(
          color: const Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      
      actions: [
        IconButton(
          icon: Image.asset('assets/images/User.jpg'),
          iconSize: 50,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AccountPage(pass_username: widget.pass_username)),
            // );
          },
        )
      ],

        //Transparent setting.
        backgroundColor: const Color(0x44FFFFFF),
        elevation: 0,
      ),

      //Body.
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: const [
              
          ], 

        )
      )
      
    );
  }
}