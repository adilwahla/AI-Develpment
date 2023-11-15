import 'package:flutter/material.dart';
import 'package:my_app/Utils.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define the desired dimensions for the card
    double cardHeight = screenHeight * 1 / 3;
    double cardWidth = screenWidth * 0.85;

    // Calculate the adaptive width of the card based on the height

    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.amber,
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  // color: Colors.deepPurple,
                  child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: 300.0,
                      margin: EdgeInsets.all(16.0),
                      child: AspectRatio(
                        aspectRatio: 3 / 1,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color(0xFFFDFFFF),
                            elevation: 4.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 229,
                                decoration: kHomeCardsdecoration.copyWith(
                                  // color: Color(0xff6874FF),
                                  gradient: kCardsLinearGradient,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left half with 2 flex
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Welcome David!",
                                                style: kh1Style.copyWith(
                                                  fontSize: 24,
                                                ),
                                              ),
                                              Text(
                                                "Your AI Assistant ",
                                                style:
                                                    line1Style, // Style for the first line
                                              ),
                                              Text(
                                                "Simplifying Life,  \n One Task at a Time.",
                                                style: line1Style.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //     width:
                                    //         8), // Add spacing between the two halves
                                    // Right half with flex 1
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: AspectRatio(
                                          aspectRatio: 3 / 3,
                                          child: Container(
                                            child: Image.asset(
                                                'assets/images/circle.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Container(
                        // color: Colors.white,
                        // height: 300,
                        width: double.infinity,
                        margin: EdgeInsets.all(16.0),
                        child: AspectRatio(
                          aspectRatio: 3 / 1,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color(0xFFFDFFFF),
                            elevation: 4.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 229,
                                decoration: kHomeCardsdecoration.copyWith(
                                  // color: Color(0xff6874FF),
                                  gradient: kCardsLinearGradient,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MiniCard(
                                          cardText: 'Text Generated',
                                        ),
                                        MiniCard(
                                          cardText: 'Report Generated',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MiniCard(
                                          cardText: 'Content Generated',
                                        ),
                                        MiniCard(
                                          cardText: 'Hours Saved ',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                  // Spacer(),
                ],
              )),
            ),
            Expanded(
              flex: 2,
              child: Container(
                //
                child: Center(
                  child: Image.asset('assets/images/logo1.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       elevation: 3,
//       child: Container(
//         width: adaptiveWidth,
//         height: cardHeight,
//         padding: EdgeInsets.all(16.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left half with 2 flex
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Left Text 1',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Left Text 2',
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 16), // Add spacing between the two halves
//             // Right half with flex 1
//             Expanded(
//               flex: 1,
//               child: Container(
//                 color: Colors.blue, // Replace with your desired widget
//                 child: Center(
//                   child: Text(
//                     'Right Widget',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

class Home1 extends StatelessWidget {
  const Home1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double userTextScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Expanded(
      child: Container(
        // padding: EdgeInsets.all(50),
        // color: Colors.lightBlueAccent,
        margin: EdgeInsets.all(20),
        width: width * 0.85,
        height: height * 3 / 4,
        //  color: Colors.amberAccent,

        child: Stack(
          children: [
            Container(
              // color: Color(0xFFFFFFFF),
              height: MediaQuery.of(context).size.height * 0.35,
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 1 / 2,
                    width: width * 1 / 3,
                    // color: Color(0xFF000000),
                    decoration: kHomeCardsdecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: height * 1 / 3,
                        width: width * 0.4 - 50,
                        //  color: Color(0xFFFFFFFF),
                        decoration: kHomeCardsdecoration.copyWith(
                          // color: Color(0xff6874FF),
                          gradient: kCardsLinearGradient,
                        ),

                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              bottom: 10,
                              left: 30,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Changes start here
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Welcome David!",
                                      style: kh1Style.copyWith(
                                        fontSize: 36 * userTextScaleFactor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  // Changes end here
                                  Text(
                                    "Your AI Assistant ",
                                    style:
                                        line1Style, // Style for the first line
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      "Simplifying Life,  \n One Task at a Time.",
                                      style: line1Style.copyWith(
                                        fontSize: 18 * userTextScaleFactor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.only(top: 7),
                                child: SizedBox(
                                  width: circleRadius * 3,
                                  height: circleRadius * 4,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        // top: 0,
                                        left: circleRadius / 2,
                                        bottom: -circleRadius,
                                        child: circle,
                                      ),
                                      Positioned(
                                        right: -circleRadius / 2,
                                        child: circle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: height * 1 / 3,
                    width: width * 1 / 2,
                    decoration: kHomeCardsdecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: height * 1 / 3,
                        width: width * 1 / 2 - 50,
                        //  color: Color(0xFFFFFFFF),
                        decoration: kHomeCardsdecoration.copyWith(
                          // color: Color(0xff6874FF),
                          gradient: kCardsLinearGradient,
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MiniCard(
                                      cardText: 'Text Generated',
                                    ),
                                    MiniCard(
                                      cardText: 'Report Generated',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MiniCard(
                                      cardText: 'Content Generated',
                                    ),
                                    MiniCard(
                                      cardText: 'Hours Saved ',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Image.asset('assets/images/logo1.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniCard extends StatelessWidget {
  final String cardText;
  const MiniCard({super.key, required this.cardText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(16.0), // Adjust the radius as needed
          color: Color.fromRGBO(255, 255, 255, 0.5), // Apply 50% opacity
          backgroundBlendMode: BlendMode.softLight,
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                cardText,
                style: kMiniCardsStyle,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "325",
                    style: kMiniCardsStyle.copyWith(fontSize: 28),
                  ),
                ),
                Container(
                  width: 80,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Make it circular
                    // Button background color (white)
                    border: Border.all(
                      color: Colors.white, // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '  View',
                          style: kMiniCardsStyle.copyWith(fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.open_in_new, // Replace with your desired icon
                          color: Colors.white, // Icon color
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
