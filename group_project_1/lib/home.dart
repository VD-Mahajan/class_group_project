import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group_project_1/addfarmer.dart';
import 'package:group_project_1/dropdown.dart';
import 'package:group_project_1/search.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/cow.png',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                // height: 130,
                // color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Dairy",
                      style: GoogleFonts.quicksand(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '"Like milk in a bottle, let your diary capture the essence of each moment, preserving it for future reflection and understanding."',
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 3 Containers
            Expanded(
              // height: 300,
              // width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const AddFarmer();
                        }));
                      },
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Colors.green,
                                Colors.white,
                              ]),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(5, 5),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/farmer.png',
                              height: 130,
                            ),
                            Text(
                              'Add Farmer',
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const DropDown();
                        }));
                      },
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.green,
                              Colors.white,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(5, 5),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/insert.png',
                              height: 110,
                            ),
                            Text(
                              'Milk Entry',
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SearchScreen();
                        }));
                      },
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Colors.green,
                                Colors.white,
                              ]),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(5, 5),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/search.png',
                              height: 110,
                            ),
                            Text(
                              'Records',
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            )
            //end
          ],
        ),
      ),
    );
  }
}
