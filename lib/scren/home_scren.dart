import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myflutter_book/scren/login_scren.dart';
import 'package:myflutter_book/const/material_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showSearch = false;
  final CarouselController _carouselController = CarouselController();

  final List<String> images = [
    'asets/images/Image 2.png',
    'asets/images/Image 5.png',
    'asets/images/Mask Group.png',
  ];
  final List ktegori = [
    {
      'image': 'asets/images/i.webp',
      'name': 'fantasy',
    },
    {
      'image': 'asets/images/i.webp',
      'name': 'Ramantic',
    },
    {
      'image': 'asets/images/i.webp',
      'name': 'Multifilm',
    },
  ];
  List allBooks = [];
  bool _isLoading = true;

  Future getAllBook() async {
    var response = await http.get(
      Uri.parse('http://65.108.148.136:8087/api/Book'),
    );

    var data = jsonDecode(response.body);
    if (data['statusCode'] == 200) {
      setState(() {
        allBooks = data['data'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getAllBook();
    super.initState();
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1998),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrowerMethods(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  fontCercla(context),
                  appBarContainers(context),
                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : CarouselSlider.builder(
                            itemCount: allBooks.length,
                            itemBuilder: (context, index, realIndex) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      images[index],
                                      width: 126,
                                      height: 194,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      allBooks[index]['authorName'] ??
                                          'Loading...',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        allBooks[index]['title'] ??
                                            'Loading...',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: 300,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.easeInCubic,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.scale,
                              disableCenter: true,
                              viewportFraction: 0.38,
                              aspectRatio: 1.8,
                              initialPage: 10,
                            ),
                          ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: blue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              // ListView.builder(
              //   itemCount: ktegori.length,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       padding: EdgeInsets.all(26),
              //       margin: EdgeInsets.all(16),
              //       width: double.infinity,
              //       height: 170,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         image: DecorationImage(
              //           image: AssetImage(
              //             ktegori[index]['image'],
              //           ),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       child: Center(
              //         child: Text(
              //           allBooks[index]['title'],
              //           style: TextStyle(
              //             fontSize: 34,
              //             fontWeight: FontWeight.w400,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              SizedBox(height: 500),
            ],
          ),
        ),
      ),
    );
  }

  Widget KategoriWidget(image, name) {
    return Container(
      padding: EdgeInsets.all(26),
      margin: EdgeInsets.all(16),
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(
            image,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget DrowerMethods(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.close_outlined,
                          size: 35,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Welcome, book_nerd!',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.folder),
                title: Text('Catalog'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.groups),
                title: Text('Friends'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.group),
                title: Text('Groups'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.event),
                title: Text('Events'),
                onTap: () {
                  _selectDate(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign out'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarContainers(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      centerTitle: true,
      title: Text(
        'booky'.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      actions: [
        Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: _showSearch ? MediaQuery.of(context).size.width * 0.6 : 0,
              height: 60,
              child: _showSearch
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _showSearch = !_showSearch;
                });
              },
              icon: Icon(
                _showSearch ? Icons.close : Icons.search_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget fontCercla(BuildContext context) {
    
    return Align(
      alignment: Alignment.topCenter,
      child: Transform.scale(
        scale: 1.56,
        origin: Offset(0, MediaQuery.of(context).size.width * 0.4),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xff5ABD8C),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
