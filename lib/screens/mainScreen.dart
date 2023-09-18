import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todotask/constant.dart';

import 'package:todotask/screens/homeScreen.dart';
import 'package:todotask/screens/category.dart';
import 'package:todotask/screens/createtask.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget Body = HomeScreen();
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double SCreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Stack(
        children: [
          Container(
            width: double.infinity,
            color: Ktask,
            child: Container(
              margin: EdgeInsets.only(
                  left: SCreenWidth * .23, right: SCreenWidth * .23),
              height: SCreenWidth * .155,
              decoration: BoxDecoration(
                color: Ktask,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: SCreenWidth * .02),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      /* final tile = NewTaskScreen.Categorys.firstWhere(
                          (item) => item.title == "jsdjcnkn");
                      print(tile.many);*/
                      currentIndex = index;
                      if (index == 0) {
                        Body = HomeScreen();
                      } else {
                        Body = CategoryScreen();
                      }
                    });
                  },
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex
                            ? SCreenWidth * .32
                            : SCreenWidth * .18,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: index == currentIndex ? SCreenWidth * .12 : 0,
                          width: index == currentIndex ? SCreenWidth * .32 : 0,
                          decoration: BoxDecoration(
                            color: index == currentIndex
                                ? Color.fromARGB(255, 0, 0, 0).withOpacity(.37)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex
                            ? '${listOfStrings[index]}' == "Category"
                                ? SCreenWidth * .45
                                : SCreenWidth * .32
                            : SCreenWidth * .18,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex
                                      ? SCreenWidth * .13
                                      : 0,
                                ),
                                AnimatedOpacity(
                                  opacity: index == currentIndex ? 1 : 0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                    index == currentIndex
                                        ? '${listOfStrings[index]}'
                                        : '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex
                                      ? SCreenWidth * .03
                                      : 20,
                                ),
                                Icon(
                                  listOfIcons[index],
                                  size: SCreenWidth * .076,
                                  color: index == currentIndex
                                      ? Colors.white
                                      : Colors.black38,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Body,
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.mode_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Catego',
  ];
}

/*Container(
          color: Ktask,
          child: Padding(
            padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: HomeScreen.ScreenWidth / 4.5,
                right: HomeScreen.ScreenWidth / 4.5),
            child: GNav(
                color: Colors.white,
                tabBackgroundColor: Colors.black45,
                activeColor: Colors.white,
                backgroundColor: Ktask,
                padding: EdgeInsets.all(10),
                gap: 8,
                onTabChange: (index) {
                  setState(() {
                    if (index == 0) {
                      Body = HomeScreen();
                    } else {
                      Body = TimeScreen();
                    }
                  });
                },
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(icon: Icons.access_time_filled, text: 'Time')
                ]),
          )),
      body: Body,*/