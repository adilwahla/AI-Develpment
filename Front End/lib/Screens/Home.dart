import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Utils.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions using MediaQuery
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;

    double scaleFactor = Width > 1920
        ? 3
        : Width >= 1080
            ? 1.7
            : 1.3;
    double baseFontSize = 16.0;
    double scaledFontSize = baseFontSize * scaleFactor;
    // Define the desired dimensions for the card
    // double cardHeight = screenHeight * 1 / 3;
    // double cardWidth = screenWidth * 0.85;

    // Calculate the adaptive width of the card based on the height

    return Container(
      width: double.infinity,
      height: double.infinity,
      // color: Colors.amber,
      margin: EdgeInsets.symmetric(horizontal: 20),
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
                    width: Width * 0.444,
                    height: Height * 0.34,
                    margin: EdgeInsets.all(16.0),
                    child: AspectRatio(
                      aspectRatio: 3 / 1,
                      child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          color: Color(0xFFFDFFFF),
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                height: Height * 0.276,
                                width: Width * 0.313,
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
                                        padding: const EdgeInsets.all(.0),
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Welcome David!",
                                                style: GoogleFonts.inter(
                                                  fontSize: scaledFontSize,
                                                  color: Color(0xffFFFFFF),
                                                ),
                                              ),
                                              Text(
                                                "Your AI Assistant ",
                                                style:
                                                    line1Style, // Style for the first line
                                              ),
                                              Text(
                                                "Simplifying Life,  \nOne Task at a Time.",
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
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              // this line got error
                                              right: 40.0,
                                              top: 50),
                                          child: Transform.scale(
                                            scaleX: 2,
                                            scaleY: 2,
                                            child: AspectRatio(
                                              aspectRatio: 1 / 2,
                                              child: Transform.rotate(
                                                angle: 0,
                                                child: Container(
                                                  child: Image.asset(
                                                      'assets/images/circle.png',
                                                      fit: BoxFit.contain),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                      width: Width * 0.444,
                      height: Height * 0.34,
                      margin: EdgeInsets.all(16.0),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: Color(0xFFFDFFFF),
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              width: Width * 0.42,
                              height: Height * 0.274,
                              decoration: kHomeCardsdecoration.copyWith(
                                // color: Color(0xff6874FF),
                                gradient: kCardsLinearGradient,
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 0, left: 40.0, top: 120),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Transform.scale(
                                        scaleX: 1.2,
                                        scaleY: 1.2,
                                        child: Transform.rotate(
                                          angle: 0,
                                          child: Container(
                                            child: Image.asset(
                                                'assets/images/circle.png',
                                                fit: BoxFit.contain),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // crossAxisAlignment:
                                    //     // CrossAxisAlignment.stretch,
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
    );
  }
}

class MiniCard extends StatefulWidget {
  final String cardText;
  const MiniCard({super.key, required this.cardText});

  @override
  State<MiniCard> createState() => _MiniCardState();
}

class _MiniCardState extends State<MiniCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double scaleFactor = width > 1940
        ? 2
        : width >= 1080
            ? 1.4
            : 1;
    double baseFontSize = 12.0;
    double scaledFontSize = baseFontSize * scaleFactor;
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(8),
        width: width * 0.1944,
        height: height * 0.111,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
          color: Color.fromRGBO(255, 255, 255, 0.5), // Apply 50% opacity
          backgroundBlendMode: BlendMode.softLight,
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.cardText,
                style: kMiniCardsStyle.copyWith(fontSize: scaledFontSize),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "325",
                    style: kMiniCardsStyle.copyWith(
                        fontSize: scaledFontSize, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: width * 0.046,
                  height: height * 0.029,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'View',
                            style: kMiniCardsStyle.copyWith(fontSize: 9),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.open_in_new, // Replace with your desired icon
                            color: Colors.white, // Icon color
                            size: 14,
                          ),
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
