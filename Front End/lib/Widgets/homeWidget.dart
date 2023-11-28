import 'package:flutter/material.dart';
import 'package:my_app/Utils.dart';

class homeWidget extends StatelessWidget {
  const homeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              // padding: EdgeInsets.all(50),
              margin: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 3 / 4,
              //  color: Colors.amberAccent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //  color: Color(0xFFFFFFFF),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius as needed
                    color: Color(0xFFFDFFFF),
                    // Background color
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5), // Stroke color
                      width: 0.5, // Stroke width
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff666CFF).withAlpha(153), // 60% opacity
                        offset: Offset(0, 4), // Offset (x, y) of the shadow
                        blurRadius: 6, // Spread of the shadow
                        spreadRadius: 2, // Expansion of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the radius as needed
                            color: Color(0xff6874FF),
                            // Background color
                            border: Border.all(
                              color:
                                  Colors.black.withOpacity(0.5), // Stroke color
                              width: 0.5, // Stroke width
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.5), // Shadow color
                                blurRadius:
                                    1, // Adjust the blur radius as needed
                                offset: Offset(0,
                                    2), // Offset to create a shadow at the bottom
                              ),
                            ],
                          ),
                          //  padding: EdgeInsets.all(50),
                          // margin: EdgeInsets.all(20),
                          width: 480,
                          height: 200,
                          // color: Color(0xff666CFF),
                        ),
                        //welcome david
                        Container(
                          padding: EdgeInsets.only(
                              left: 20, top: 20), // Set left padding to 0
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "Welcome David!",
                                  style: TextStyle(
                                    fontFamily:
                                        'Inter', // Use the "Inter" font family
                                    fontSize:
                                        40, // Adjust the font size as needed
                                    fontWeight: FontWeight
                                        .bold, // You can adjust the font weight as needed
                                    color: Color(
                                        0xFFFFFFFF), // Adjust the text color as needed
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "Your AI Assistant",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                          'Inter', // Use the "Inter" font family
                                      fontSize:
                                          20, // Adjust the font size as needed
                                      fontWeight: FontWeight
                                          .bold, // You can adjust the font weight as needed
                                      color: Color(
                                          0xFFFFFFFF), // Adjust the text color as needed
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Simplifying Life",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily:
                                        'Inter', // Use the "Inter" font family
                                    fontSize:
                                        20, // Adjust the font size as needed
                                    fontWeight: FontWeight
                                        .normal, // You can adjust the font weight as needed
                                    color: Color(
                                        0xFFFFFFFF), // Adjust the text color as needed
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 25),
                                child: Text(
                                  "One Task at a Time.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily:
                                        'Inter', // Use the "Inter" font family
                                    fontSize:
                                        20, // Adjust the font size as needed
                                    fontWeight: FontWeight
                                        .normal, // You can adjust the font weight as needed
                                    color: Color(
                                        0xFFFFFFFF), // Adjust the text color as needed
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          child: SizedBox(
                            width: circleRadius * 2,
                            height: circleRadius * 4,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: circle,
                                ),
                                Positioned(
                                  top: circleRadius *
                                      0.75, // Move the second circle down to create space for overlap
                                  left: 0, // Keep the X-coordinate the same
                                  child: circle,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  //  color: Color(0xFFFFFFFF),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius as needed
                    color: Color(0xFFFDFFFF),
                    // Background color
                    // border: Border.all(
                    //   color: Colors.black.withOpacity(0.5), // Stroke color
                    //   width: 0.5, // Stroke width
                    // ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff666CFF).withAlpha(153), // 60% opacity
                        offset: Offset(0, 4), // Offset (x, y) of the shadow
                        blurRadius: 6, // Spread of the shadow
                        spreadRadius: 2, // Expansion of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the radius as needed
                            color: Color(0xff6874FF),
                            // Background color
                            // border: Border.all(
                            //   color: Colors.black.withOpacity(0.5), // Stroke color
                            //   width: 0.5, // Stroke width
                            // ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.5), // Shadow color
                                blurRadius:
                                    1, // Adjust the blur radius as needed
                                offset: Offset(0,
                                    2), // Offset to create a shadow at the bottom
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(50),
                          // margin: EdgeInsets.all(20),
                          width: 600,
                          height: 200,
                          // color: Color(0xff666CFF),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        280, // 1/4 of the parent container width
                                    height:
                                        80, // 1/4 of the parent container height
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        // color: Color.fromRGBO(255, 255, 255, 0.5),
                                        color: Colors.white.withOpacity(0.4)),
                                    child: Center(
                                      child: Text(
                                        'Top Container',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        280, // 1/4 of the parent container width
                                    height:
                                        80, // 1/4 of the parent container height
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        // color: Color.fromRGBO(255, 255, 255, 0.5),
                                        color: Colors.white.withOpacity(0.4)),
                                    child: Center(
                                      child: Text(
                                        'Top Container',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        280, // 1/4 of the parent container width
                                    height:
                                        80, // 1/4 of the parent container height
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        // color: Color.fromRGBO(255, 255, 255, 0.5),
                                        color: Colors.white.withOpacity(0.4)),
                                    child: Center(
                                      child: Text(
                                        'Top Container',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        280, // 1/4 of the parent container width
                                    height:
                                        80, // 1/4 of the parent container height
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        // color: Color.fromRGBO(255, 255, 255, 0.5),
                                        color: Colors.white.withOpacity(0.4)),
                                    child: Center(
                                      child: Text(
                                        'Top Container',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )

                        //new row
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 400),
              child: Center(
                child: Image.asset('assets/images/logo1.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
