import 'package:flutter/material.dart';
import 'package:todotask/constant.dart';
import 'package:todotask/screens/homeScreen.dart';

class taskScreen extends StatefulWidget {
  final int index;
  const taskScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<taskScreen> createState() => _taskScreenState();
}

class _taskScreenState extends State<taskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Kback,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarTaskWidget(),
            Row(
              children: [
                SizedBox(
                  width: 13,
                ),
                UTPUTwidget(
                  text: HomeScreen.tasks[widget.index].description,
                  title: HomeScreen.tasks[widget.index].title,
                  size: 25,
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 13,
                ),
                UTPUTwidget(
                  text: HomeScreen.tasks[widget.index].date,
                  title: "End date",
                  size: 18,
                ),
                UTPUTwidget(
                  text: HomeScreen.tasks[widget.index].time,
                  title: "End time",
                  size: 18,
                ),
                UTPUTwidget(
                  text: HomeScreen.tasks[widget.index].level,
                  title: "Difficulty",
                  size: 18,
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 13,
                ),
                UTPUTwidget(
                  text: HomeScreen.tasks[widget.index].level,
                  title: "Difficulty",
                  size: 18,
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget AppBarTaskWidget() {
    return Row(
      children: [
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          child: Container(
            child: Icon(
              Icons.arrow_back,
              size: 28,
              color: Colors.white,
            ),
          ),
          onTap: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        SizedBox(
          width: 7,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(
              'Task',
              style: TextStyle(color: Colors.white, fontSize: 35),
            )),
      ],
    );
  }
}

class UTPUTwidget extends StatelessWidget {
  final double size;
  final String title;
  final String text;
  const UTPUTwidget(
      {Key? key, required this.size, required this.text, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Container(
          margin: EdgeInsets.only(right: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: size),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                // height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.white)),
                padding: EdgeInsets.all(7),
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
