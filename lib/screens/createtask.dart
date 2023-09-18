import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todotask/constant.dart';
import '../models/Category.dart';
import 'package:todotask/models/Task.dart';
import 'package:todotask/screens/createctegory.dart';
import 'package:todotask/screens/homeScreen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);
  static TextEditingController categoryhacontrollor = TextEditingController();
  static TextEditingController titlecontrollor = TextEditingController();
  static TextEditingController descriptioncontrollor = TextEditingController();
  static TextEditingController categorycontrollor = TextEditingController();
  static String level = 'Difficulty';
  static var categoryss = 'Category';
  static var Categoryha = ['Add Category', 'program', 'game'];
  static String Data = "Calendar";
  static int id = 0;
  static String Data2 = "";
  static String Time = "";
  static String newedit = "";
  static List<CategoryNader> Categorys = [
    CategoryNader(
      title: "School",
      note:
          "Sit eu duis duis exercitation amet officia aliqua sint fugiat consequat non occaecat sunt sit. Consequat ex duis tempor eiusmod labore occaecat est sit proident. Sint velit quis commodo ipsum anim sint qui Lorem ad nulla officia officia. Velit aliquip in cupidatat excepteur magna ullamco ex aliquip consectetur. Ipsum voluptate id labore Lorem. Magna irure reprehenderit nulla voluptate ipsum laboris eu qui ipsum laboris excepteur cillum sit ipsum.",
      id: 0,
      level: false,
    ),
    CategoryNader(
      title: "jsdjcnkn",
      note: "sjdk",
      id: 1,
      level: true,
    ),
    CategoryNader(
      title: "program",
      note:
          "Sit eu duis duis exercitation amet officia aliqua sint fugiat consequat non occaecat sunt sit. Consequat ex duis tempor eiusmod labore occaecat est sit proident. Sint velit quis commodo ipsum anim sint qui Lorem ad nulla officia officia. Velit aliquip in cupidatat excepteur magna ullamco ex aliquip consectetur. Ipsum voluptate id labore Lorem. Magna irure reprehenderit nulla voluptate ipsum laboris eu qui ipsum laboris excepteur cillum sit ipsum.",
      id: 2,
      level: true,
    ),
    CategoryNader(
      title: "game",
      note: "sjdfk",
      id: 3,
      level: false,
    ),
  ];
  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  String value = 'item';
  String dropdownvalue = 'Item 1';
  var Difficulty = ['Hard', 'Medium', 'Easy'];
  TimeOfDay _timeofday = TimeOfDay(hour: 1, minute: 0);

  get newValue => null;
  get index => null;

  @override
  void initState() {
    NewTaskScreen.categoryss =
        NewTaskScreen.categoryss == '' ? 'Category' : NewTaskScreen.categoryss;
    NewTaskScreen.level =
        NewTaskScreen.level == '' ? 'Difficulty' : NewTaskScreen.level;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Kback,
      body: ListView(children: [
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
                      NewTaskScreen.newedit + ' Task',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )),
              ],
            ),
            TitleWedget(
              controller: NewTaskScreen.titlecontrollor,
            ),
            SizedBox(
              height: 17,
            ),
            DescriptionWidget(
              controller: NewTaskScreen.descriptioncontrollor,
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                DropDownBottumWedget(),
                SizedBox(
                  width: 13,
                ),
                dropdownbottom2Wedget(),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            CalendarWedget(),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            Row(
              children: [
                TimeWedget(),
                SizedBox(
                  width: 13,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: SaveButtonWedget(),
              alignment: Alignment.bottomRight,
            ),
          ],
        ),
      ]),
    ));
  }

  Expanded TimeWedget() {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: (() {
          setState(() {
            showTimePicker(context: context, initialTime: TimeOfDay.now())
                .then((value) {
              setState(() {
                _timeofday = value!;
                value.toString().length == 7
                    ? NewTaskScreen.Time =
                        _timeofday.format(context).toString().substring(0, 4)
                    : NewTaskScreen.Time =
                        _timeofday.format(context).toString().substring(0, 5);
              });
            });
          });
        }),
        child: Container(
          padding: EdgeInsets.only(left: 7, right: 5),
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.only(left: 13),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Colors.white,
              )),
          child: Row(
            children: [
              Text(
                NewTaskScreen.Time == "" ? "Time" : NewTaskScreen.Time,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Spacer(),
              Container(
                alignment: Alignment.centerRight,
                // padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.access_time_rounded,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container CalendarWedget() {
    return Container(
      child: GestureDetector(
        onTap: () async {
          var pickedData = await showPersianDatePicker(
              context: context,
              initialDate: Jalali.now(),
              firstDate: Jalali(1400),
              lastDate: Jalali(1499));

          setState(() {
            String year = pickedData!.year.toString();
            String month = pickedData.month.toString().length == 1
                ? "0${pickedData.month.toString()}"
                : pickedData.month.toString();
            String day = pickedData.day.toString().length == 1
                ? "0${pickedData.day.toString()}"
                : pickedData.day.toString();
            NewTaskScreen.Data2 = month + " / " + day;
            NewTaskScreen.Data = year + " / " + month + " / " + day;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 13),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Container(
                child: Text(
                  NewTaskScreen.Data == "" ? "Calendar" : NewTaskScreen.Data,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.calendar_month,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded dropdownbottom2Wedget() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(right: 13),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(left: 7, right: 4),
        child: Row(
          children: [
            DropdownButton(
                borderRadius: BorderRadius.circular(5),
                dropdownColor: Ktask,
                underline: SizedBox(),
                icon: SizedBox(),
                hint: Text(
                  NewTaskScreen.categoryss,
                  style: TextStyle(color: Colors.white),
                ),
                items: NewTaskScreen.Categoryha.map((vala) {
                  return DropdownMenuItem(
                      value: vala,
                      child: new Text(
                        vala,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ));
                }).toList(),
                onChanged: (String? vala) {
                  setState(() {
                    if (vala == 'Add Category') {
                      NewCategoryScreen.TextFieledCategoryNotecontrollor.text =
                          "";
                      NewCategoryScreen.TextFieledCategorycontrollor.text = "";
                      NewCategoryScreen.selectedColor = 0;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NewCategoryScreen();
                      })).then((value) {
                        if (NewCategoryScreen.issave == true) {
                          NewTaskScreen.categoryss = NewCategoryScreen
                              .TextFieledCategorycontrollor.text;
                          NewCategoryScreen.TextFieledCategorycontrollor.text =
                              '';
                          NewCategoryScreen.issave == false;
                        }
                        setState(() {});
                      });
                    } else {
                      NewTaskScreen.categoryss = vala!;
                    }
                  });
                }),
          ],
        ),
      ),
    );
  }

  Expanded DropDownBottumWedget() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 13),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(left: 7, right: 4),
        child: Row(
          children: [
            Expanded(
                child: DropdownButton(
                    borderRadius: BorderRadius.circular(5),
                    dropdownColor: Ktask,
                    underline: SizedBox(),
                    iconDisabledColor: Colors.red,
                    iconEnabledColor: Colors.red,
                    icon: SizedBox(),
                    hint: Text(
                      NewTaskScreen.level,
                      style: TextStyle(color: Colors.white),
                    ),
                    items: Difficulty.map((val) {
                      return DropdownMenuItem(
                          value: val,
                          child: new Text(
                            val,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ));
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        NewTaskScreen.level = val!;
                      });
                    })),
          ],
        ),
      ),
    );
  }
}

class SaveButtonWedget extends StatefulWidget {
  const SaveButtonWedget({
    Key? key,
  }) : super(key: key);

  @override
  State<SaveButtonWedget> createState() => _SaveButtonWedgetState();
}

class _SaveButtonWedgetState extends State<SaveButtonWedget> {
  Box<Task> hiveBox = Hive.box<Task>('taskBox');
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
      width: 80,
      height: 35,
      child: ElevatedButton(
          onPressed: () {
            //  NewTaskScreen.Categoryha.add()
            /*HomeScreen.tasks.add(Task(
                id: Random().nextInt(9999),
                title: NewTaskScreen.titlecontrollor.text,
                description: NewTaskScreen.descriptioncontrollor.text,
                date: NewTaskScreen.Data,
                time: NewTaskScreen.Time,
                level: NewTaskScreen.level,
                category: NewTaskScreen.categoryss,
                more: false));*/
            hiveBox.add(Task(
                id: Random().nextInt(9999),
                title: NewTaskScreen.titlecontrollor.text,
                description: NewTaskScreen.descriptioncontrollor.text,
                date: NewTaskScreen.Data,
                time: NewTaskScreen.Time,
                level: NewTaskScreen.level,
                category: NewTaskScreen.categoryss,
                more: false));
            /* final tile = NewTaskScreen.Categorys.firstWhere(
                (item) => item.title == NewTaskScreen.categoryss);*/
            setState(() {});
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

class TitleWedget extends StatelessWidget {
  final TextEditingController controller;
  const TitleWedget({
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
              'Title',
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
                      hintText: 'Enter Tilte for your task',
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

class DescriptionWidget extends StatelessWidget {
  final TextEditingController controller;
  const DescriptionWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 13, right: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
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
                      hintText: 'Enter Description for your task',
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
