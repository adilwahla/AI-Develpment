// ignore_for_file: unused_field, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Screens/Email.dart';
import 'package:my_app/Screens/Home.dart';
import 'package:my_app/Screens/ProfileScreen/Profile.dart';
import 'package:my_app/Screens/RegistrationPage.dart';
import 'package:my_app/Screens/Report.dart';
import 'package:my_app/Screens/SocialMediaPage.dart';
import 'package:my_app/Screens/Translate.dart';
import 'package:my_app/Widgets/Footer.dart';
import 'package:my_app/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

List<bool> selected = [true, false, false, false, false];

class _HomeDashboardState extends State<HomeDashboard> {
  final AuthService authService = AuthService();
  int selectedIndex = 0;
  bool isAuthenticated = false;

  List<NavItem> navItems = [
    NavItem(imagePath: 'assets/images/home.png', name: 'Home'),
    NavItem(imagePath: 'assets/images/email.png', name: 'Email Generation'),
    NavItem(imagePath: 'assets/images/translate1.png', name: 'Translate'),
    NavItem(imagePath: 'assets/images/report.png', name: 'Report'),
    NavItem(imagePath: 'assets/images/social.png', name: 'Social Media'),
  ];
  String screenName = 'Home';
  void select(int n) {
    for (int i = 0; i < 6; i++) {
      if (i != 0) {
        screenName = "";
      } else {
        screenName = 'Home';
      }
      if (i == n) {
        selected[i] = true;
      } else {
        selected[i] = false;
      }
      setState(() {
        selectedIndex = n;
      });
    }

    // ignore: unused_element
    void onLoginSuccess() {
      setState(() {
        isAuthenticated = true;
      });
    }
  }

  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Color(0xff4C5AFE),
        child: Row(
          children: [
            // Container(
            //   color: Color(0xff332A7C),
            // ),
            Container(
              // margin: EdgeInsets.symmetric(vertical: 8.0),
              height: MediaQuery.of(context).size.height,
              width: width * 0.18, // Increase the width to 151.0 //170
              // width: 151.0, // Increase the width to 151.0
              decoration: BoxDecoration(
                color: Color(0xff4C5AFE),
                // borderRadius: BorderRadius.circular(20.0),
              ),
              child: Stack(
                children: [
                  Container(
                    width: width * 0.131,
                    height: height * 0.0564,
                    margin: EdgeInsets.only(top: 25, left: 30),
                    child: Image.asset(
                      'assets/images/logo.png',
                      // color: Colors.white, // Icon color
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 80, left: 30, right: 35),
                    child: Divider(
                      color:
                          Color(0xFFCED2D8), // Use the hexadecimal color code
                      thickness: 1.0, // Adjust the thickness as needed
                      // height: 4.0, // Adjust the height as needed
                    ),
                  ),
                  Positioned(
                    top: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: navItems
                          .map(
                            (e) => NavBarItem(
                              // icon: e.icon,
                              imagePath: e.imagePath,
                              name: e.name,
                              selected: selected[navItems.indexOf(e)],
                              onTap: () {
                                setState(() {
                                  select(navItems.indexOf(e));
                                });
                              },
                              color: selected[navItems.indexOf(e)] == true
                                  ? Color(0xffFF8203)
                                  : Colors.white,
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  // ********************| Footer |*********************//

                  Footer(width: width, height: height),

                  // ********************| Footer |*********************//
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 151.0),
                    height: MediaQuery.of(context).size.height,
                    // width: 151.0, // Increase the width to 151.0
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xffEBF2FC),
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(30.0), // Top-left corner rounding
                        bottomLeft: Radius.circular(
                            30.0), // Bottom-left corner rounding
                      ),
                    ),

                    // child: TopAppBar(),
                  ),
                  Padding(
                    //search bar avatar row
                    padding: EdgeInsets.only(top: 16.0, bottom: 16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(

                                      // height: 40,
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, left: 20),
                                    child: Text(
                                      screenName,
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffAEAEAE),
                                      ),
                                    ),
                                  ))),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    //  width: width * 0.165,
                                    width: width * 0.165,
                                    height: height * 0.05,
                                    // padding: const EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xFFFFFFFF),
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        //FFFFFF
                                        fillColor: Colors.white,
                                        hintText: "Search ",
                                        icon: Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                                  10), // Adjust the left margin as needed
                                          child: Icon(CupertinoIcons.search),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Add the dropdown button to trigger the menu
                                      PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'logout') {
                                            // authService.signOut(context);
                                            signOut(context);
                                          } else if (value == 'profile') {
                                            // Handle navigating to the profile page
                                            // showProfile = true;
                                            setState(() {
                                              selectedIndex = 5;
                                            });
                                          }
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          PopupMenuItem(
                                            value: 'logout',
                                            child: Text('Logout'),
                                          ),
                                          PopupMenuItem(
                                            value: 'profile',
                                            child: Text('Profile Page'),
                                          ),
                                        ],
                                        child: Container(
                                          // color: Colors.amber,
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 23,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    'assets/images/avatar.jpg'),
                                                radius: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(width: 5),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: renderSelectedWidget(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderSelectedWidget() {
    switch (selectedIndex) {
      case 0:
        return Home(); // Replace with your HomeWidget implementation
      case 1:
        return Email(); // Replace with your EmailWidget implementation
      case 2:
        return TranslatePage();
      case 3:
        return ReportPage();
      case 4:
        return SocialMediaPage();
      case 5:
        return Profile();

      default:
        screenName = 'Home';
        return Home(); // Return an empty container by default
    }
  }
}

class NavItem {
  // final IconData icon;
  final String imagePath;
  final String name;

  NavItem({
    required this.imagePath,
    required this.name,
  });
}

class NavBarItem extends StatefulWidget {
  // final IconData icon;
  final String imagePath;
  final String name;
  final Function onTap;
  final bool selected;
  final Color color;

  NavBarItem({
    //required this.icon,
    required this.imagePath,
    required this.name,
    required this.onTap,
    required this.selected,
    required this.color,
  });
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;

  late Animation<double> _anim1;
  late Animation<double> _anim2;
  late Animation<double> _anim3;
  late Animation<Color?> _color;

  bool hovered = false;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 275),
    );

    _anim1 = Tween(begin: 170.0, end: 75.0).animate(_controller1);
    _anim2 = Tween(begin: 170.0, end: 25.0).animate(_controller2);
    _anim3 = Tween(begin: 170.0, end: 50.0).animate(_controller2);

    // Assign the animation with the cast
    _color = ColorTween(end: Color(0xff332a7c), begin: Color(0xffEBF2FC))
        .animate(_controller2);

    _controller1.addListener(() {
      setState(() {});
    });
    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(NavBarItem oldWidget) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    super.didUpdateWidget(oldWidget);
    if (!widget.selected) {
      Future.delayed(Duration(milliseconds: 10), () {
        //_controller1.reverse();
      });
      _controller1.reverse();
      _controller2.reverse();
    } else {
      _controller1.forward();
      _controller2.forward();
      Future.delayed(Duration(milliseconds: 10), () {
        //_controller2.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: Container(
          //  width: 170.0, // Adjust the width to 151.0
          width: width * 0.185, // Adjust the width to 151.0
          color: Color(0xff4C5AFE),
          // hovered && !widget.selected ? Colors.white12 : Colors.transparent,
          child: Stack(
            children: [
              // Positioned(
              //   child: Container(
              //     child: CustomPaint(
              //       painter: CurvePainter(
              //         value1: 0,
              //         animValue1: _anim3.value,
              //         animValue2: _anim2.value,
              //         animValue3: _anim1.value,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                child: Container(
                  // color: Colors.amber,
                  height: 45.0,
                  width: width * 0.185,
                  // width: 170.0,
                  margin: EdgeInsets.only(left: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.imagePath, // Use the imagePath from your NavItem
                        color: widget.color,
                        width: 15.0, // Adjust the width as needed
                        height: 15.0, // Adjust the height as needed
                      ),
                      // Icon(
                      //   widget.icon,
                      //   color: _color.value,
                      //   size: 18.0,
                      // ),
                      SizedBox(
                          width: 7), // Add some spacing between icon and name
                      Text(
                        widget.name, // Display the icon name
                        style: TextStyle(
                          color: widget.color,
                          fontSize: 15.0, // Adjust font size as needed
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0033333, size.height * 0.2824074);
    path_0.cubicTo(
        size.width * 1.0050000,
        size.height * 0.3293981,
        size.width * 0.4450000,
        size.height * 0.3224537,
        size.width * 0.4500000,
        size.height * 0.3481481);
    path_0.cubicTo(
        size.width * 0.4441667,
        size.height * 0.3793981,
        size.width * 1.0066667,
        size.height * 0.3597222,
        size.width * 0.9966667,
        size.height * 0.4055556);
    path_0.cubicTo(
        size.width * 0.9983333,
        size.height * 0.4212963,
        size.width * 1.0016667,
        size.height * 0.2560185,
        size.width * 1.0033333,
        size.height * 0.2824074);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(253, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


///////////////////////////////////////////////////////////
// class CurvePainter extends CustomPainter {
//   final double value1; // 200
//   final double animValue1; // static value1 = 50.0
//   final double animValue2; //static value1 = 75.0
//   final double animValue3; //static value1 = 75.0

//   CurvePainter({
//     required this.value1,
//     required this.animValue1,
//     required this.animValue2,
//     required this.animValue3,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     Path path = Path();
//     Paint paint = Paint();

//     path.moveTo(170, value1);
//     path.quadraticBezierTo(170, value1 + 9, animValue3, value1 + 9);
//     path.lineTo(animValue1, value1 + 10);
//     path.quadraticBezierTo(animValue2, value1 + 13, animValue2, value1 + 30);
//     path.lineTo(170, value1 + 30);
//     path.close();

//     path.moveTo(170, value1 + 50);
//     path.quadraticBezierTo(170, value1 + 40, animValue3, value1 + 40);
//     path.lineTo(animValue1, value1 + 40);
//     path.quadraticBezierTo(animValue2, value1 + 40, animValue2, value1 + 30);
//     path.lineTo(170, value1 + 30);
//     path.close();

//     paint.color = Color(0xffEBF2FC);
//     paint.strokeWidth = 170.0; // Adjust the stroke width to 151.0
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }
// }

// new one
