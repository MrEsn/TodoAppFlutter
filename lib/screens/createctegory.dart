import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todotask/constant.dart';
import 'package:todotask/models/Category.dart';
import 'package:todotask/screens/createtask.dart';

void main(List<String> args) {
  runApp(NewCategoryScreen());
}

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({Key? key}) : super(key: key);
  static TextEditingController TextFieledCategorycontrollor =
      TextEditingController();
  static TextEditingController TextFieledCategoryNotecontrollor =
      TextEditingController();
  static bool issave = false;
  static var selectedColor = 0;
  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  var index;
  // Box<CategoryNader> hiveBox = Hive.box<CategoryNader>('categoryBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      color: Kback,
      child: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                      'New Category',
                      style: TextStyle(color: Colors.white, fontSize: 32.5),
                    )),
              ],
            ),
            TextFieldCategoryWedget(
              controller: NewCategoryScreen.TextFieledCategorycontrollor,
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              controller: NewCategoryScreen.TextFieledCategoryNotecontrollor,
            ),
            Column(
              children: List<Widget>.generate(2, (int index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          NewCategoryScreen.selectedColor = index;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 13, left: 13),
                        child: CircleAvatar(
                            backgroundColor: index == 0
                                ? Color.fromARGB(255, 209, 21, 8)
                                : Color.fromARGB(255, 19, 148, 23),
                            radius: 17,
                            child: NewCategoryScreen.selectedColor == index
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 21,
                                  )
                                : Container()),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 11.5),
                      child: Text(
                        index == 0 ? "UseFull" : "LessFull",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                );
              }),
            ),
            Container(
              width: double.infinity,
              child: SavedBottomWedget2(),
              alignment: Alignment.bottomRight,
            ),
          ],
        ),
      ]),
    ));
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  const TextFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 13, right: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Note',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Column(children: [
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: TextField(
                    maxLines: 6,
                    controller: controller,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    cursorHeight: 26,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Kback)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Kback)),
                      hintText: 'Enter Note for your Category',
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 15),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}

class SavedBottomWedget2 extends StatefulWidget {
  const SavedBottomWedget2({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedBottomWedget2> createState() => _SavedBottomWedget2State();
}

class _SavedBottomWedget2State extends State<SavedBottomWedget2> {
  Box<CategoryNader> hiveBox = Hive.box<CategoryNader>('categoryBox');
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
      width: 80,
      height: 35,
      child: ElevatedButton(
          onPressed: () {
            NewTaskScreen.Categoryha.add(
                NewCategoryScreen.TextFieledCategorycontrollor.text);
            /* NewTaskScreen.Categorys.add(CategoryNader(
              title: NewCategoryScreen.TextFieledCategorycontrollor.text,
              note: NewCategoryScreen.TextFieledCategoryNotecontrollor.text,
              id: Random().nextInt(9999),
              level: NewCategoryScreen.selectedColor == 0 ? true : false,
            ));*/
            hiveBox.add(CategoryNader(
              title: NewCategoryScreen.TextFieledCategorycontrollor.text,
              note: NewCategoryScreen.TextFieledCategoryNotecontrollor.text,
              id: Random().nextInt(9999),
              level: NewCategoryScreen.selectedColor == 0 ? true : false,
            ));
            NewCategoryScreen.issave = true;
            Navigator.pop(context);
          },
          style:
              ButtonStyle(backgroundColor: MaterialStateProperty.all(kbuttom)),
          child: Text(
            'Save',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}

class TextFieldCategoryWedget extends StatelessWidget {
  final TextEditingController controller;
  const TextFieldCategoryWedget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 13, right: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Column(children: [
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    cursorHeight: 26,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Kback)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Kback)),
                      hintText: 'Enter a new Category',
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 15),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}
