import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_app/Provider/Auth_Provider.dart';
import 'package:my_app/Provider/user_provider.dart';
import 'package:my_app/Screens/RegistrationPage.dart';
import 'package:my_app/Screens/Report.dart';
import 'package:my_app/Screens/SocialMediaPage.dart';
import 'package:my_app/Screens/Translate.dart';
import 'package:my_app/Screens/email.dart';
import 'package:my_app/Screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

final appTheme = ThemeData(
    // primarySwatch: Colors.red,
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

List<bool> selected = [true, false, false, false, false];

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  bool isAuthenticated = false;
  // List<IconData> icon = [
  //   Feather.wind,
  //   Feather.folder,
  //   Feather.monitor,
  //   Feather.lock,
  //   Feather.mail,
  // ];
  List<NavItem> navItems = [
    NavItem(icon: Feather.home, name: 'Home'),
    NavItem(icon: Feather.mail, name: 'Email '),
    NavItem(icon: Feather.monitor, name: 'Translate'),
    NavItem(icon: Feather.lock, name: 'Report'),
    NavItem(icon: Feather.share, name: 'Social Media'),
  ];

  void select(int n) {
    for (int i = 0; i < 5; i++) {
      if (i == n) {
        selected[i] = true;
      } else {
        selected[i] = false;
      }
      setState(() {
        selectedIndex = n;
      });
    }
    // Use Navigator to navigate to the appropriate screen
    //   if (n == 0) {
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => Home()));
    //   } else if (n == 1) {
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => Email()));
    //   }
    // void onLoginSuccess() {
    //   setState(() {
    //     isAuthenticated = true;
    //   });
    // }
    void onLoginSuccess() {
      setState(() {
        isAuthenticated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth_provider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        home:
             Scaffold(
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
                        width: 151.0, // Increase the width to 151.0
                        // width: 151.0, // Increase the width to 151.0
                        decoration: BoxDecoration(
                          color: Color(0xff4C5AFE),
                          // borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 5, right: 5),
                              child: Image.asset(
                                'assets/images/logo.png',
                                // color: Colors.white, // Icon color
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 80, left: 9, right: 9),
                              child: Divider(
                                color: Color(
                                    0xFFCED2D8), // Use the hexadecimal color code
                                thickness:
                                    1.0, // Adjust the thickness as needed
                                height: 8.0, // Adjust the height as needed
                              ),
                            ),
                            Positioned(
                              top: 110,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: navItems
                                    .map(
                                      (e) => NavBarItem(
                                        icon: e.icon,
                                        name: e.name,
                                        selected: selected[navItems.indexOf(e)],
                                        onTap: () {
                                          setState(() {
                                            select(navItems.indexOf(e));
                                          });
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
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
                                  topLeft: Radius.circular(
                                      50.0), // Top-left corner rounding
                                  bottomLeft: Radius.circular(
                                      50.0), // Bottom-left corner rounding
                                ),
                              ),

                              // child: TopAppBar(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 50,
                                    // padding: const EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFFFFFFFF),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey, // Shadow color
                                          // blurRadius: 5, // Spread of the shadow
                                          offset: Offset(0,
                                              0), // Offset of the shadow (x, y)
                                        ),
                                      ],
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
                                  SizedBox(width: 5),
                                  _nameAndProfilePicture(
                                      context, "assets/images/avatar.jpg"
                                      //  "https://image.freepik.com/free-photo/dreamy-girl-biting-sunglasses-looking-away-with-dreamy-face-purple-background_197531-7085.jpg",
                                      //  "https://media.istockphoto.com/id/1399788030/photo/portrait-of-young-confident-indian-woman-pose-on-background.jpg"
                                      ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 90),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 100,
                              child: renderSelectedWidget(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
       
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

      default:
        return Home(); // Return an empty container by default
    }
  }
}

Widget _nameAndProfilePicture(BuildContext context, String imageUrl) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      // const Padding(
      //   padding: EdgeInsets.only(left: 6.0),
      //   child: Icon(
      //     CupertinoIcons.chevron_down,
      //     size: 14,
      //   ),
      // ),
      Visibility(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 36,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 31,
            ),
          ),
        ),
      ),
    ],
  );
}

class NavItem {
  final IconData icon;
  final String name;

  NavItem({
    required this.icon,
    required this.name,
  });
}

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final String name;
  final Function onTap;
  final bool selected;
  NavBarItem({
    required this.icon,
    required this.name,
    required this.onTap,
    required this.selected,
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

    _anim1 = Tween(begin: 151.0, end: 75.0).animate(_controller1);
    _anim2 = Tween(begin: 151.0, end: 25.0).animate(_controller2);
    _anim3 = Tween(begin: 151.0, end: 50.0).animate(_controller2);

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
          width: 151.0, // Adjust the width to 151.0
          color: Color(0xff4C5AFE),
          // hovered && !widget.selected ? Colors.white12 : Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  child: CustomPaint(
                    painter: CurvePainter(
                      value1: 0,
                      animValue1: _anim3.value,
                      animValue2: _anim2.value,
                      animValue3: _anim1.value,
                    ),
                  ),
                ),
              ),
              Container(
                height: 80.0,
                width: 151.0,
                margin: EdgeInsets.only(left: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      color: _color.value,
                      size: 18.0,
                    ),
                    SizedBox(
                        width: 12), // Add some spacing between icon and name
                    Text(
                      widget.name, // Display the icon name
                      style: TextStyle(
                        color: hovered ? Color(0xffFF8203) : _color.value,
                        fontSize: 12.0, // Adjust font size as needed
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double value1; // 200
  final double animValue1; // static value1 = 50.0
  final double animValue2; //static value1 = 75.0
  final double animValue3; //static value1 = 75.0

  CurvePainter({
    required this.value1,
    required this.animValue1,
    required this.animValue2,
    required this.animValue3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(151, value1);
    path.quadraticBezierTo(151, value1 + 20, animValue3, value1 + 20);
    path.lineTo(animValue1, value1 + 20);
    path.quadraticBezierTo(animValue2, value1 + 20, animValue2, value1 + 40);
    path.lineTo(151, value1 + 40);
    path.close();

    path.moveTo(151, value1 + 80);
    path.quadraticBezierTo(151, value1 + 60, animValue3, value1 + 60);
    path.lineTo(animValue1, value1 + 60);
    path.quadraticBezierTo(animValue2, value1 + 60, animValue2, value1 + 40);
    path.lineTo(151, value1 + 40);
    path.close();

    paint.color = Color(0xffEBF2FC);
    paint.strokeWidth = 151.0; // Adjust the stroke width to 151.0
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

// new one
class TopAppBar extends StatelessWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Visibility(
            child: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Text(
                "Overview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Search something...",
                  icon: Icon(CupertinoIcons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _nameAndProfilePicture(
              context,
              "Emily Smith",
              "https://image.freepik.com/free-photo/dreamy-girl-biting-sunglasses-looking-away-with-dreamy-face-purple-background_197531-7085.jpg",
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameAndProfilePicture(
      BuildContext context, String username, String imageUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Icon(
            CupertinoIcons.chevron_down,
            size: 14,
          ),
        ),
        Visibility(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ),
      ],
    );
  }
}
