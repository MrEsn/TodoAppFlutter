import 'package:flutter/material.dart';
import 'package:todotask/constant.dart';
import 'package:todotask/main.dart';
import 'package:todotask/models/Category.dart';
import 'package:todotask/screens/createctegory.dart';
import 'package:todotask/screens/createtask.dart';
import 'package:todotask/screens/homeScreen.dart';
import 'package:todotask/screens/mainScreen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  @override
  static var HEGHT = 50.0;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getcategory();
  }

  void getcategory() async {
    await MyApp.getDatacat();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double SCREENWidth = MediaQuery.of(context).size.width;
    double EstefdeGAR = SCREENWidth - 67 / 3;
    List<CategoryNader> sorted_category = [];
    var leswid =
        NewTaskScreen.Categorys.where((element) => element.level == false);
    leswid.forEach((element) => sorted_category.add(element));
    var fullwid =
        NewTaskScreen.Categorys.where((element) => element.level == true);
    int c = 0;
    bool is_f = true;
    for (int i = 0; i < fullwid.length; i++) {
      sorted_category.insert(c, fullwid.elementAt(i));
      if ((c + 3) > sorted_category.length) {
        c += 3 - c - 3 + sorted_category.length;
      } else {
        if (is_f == true) {
          c += 3;
          is_f = false;
        } else {
          c += 1;
          is_f = true;
        }
      }
    }
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 25, left: 25),
        width: double.infinity,
        height: double.infinity,
        color: Kback,
        child: ListView(
          children: [
            for (int i = 1;
                i <=
                    (sorted_category.length / 2) + (sorted_category.length % 2);
                i++) ...[
              Row(children: [
                sorted_category[(i * 2) - 2].level == true
                    ? CategoryContanerBIGWidget(
                        data: sorted_category[(i * 2) - 2])
                    : CategoryContainerWidget(
                        data: sorted_category[(i * 2) - 2]),
                (i * 2) - 1 <= (NewTaskScreen.Categorys.length - 1)
                    ? sorted_category[(i * 2) - 1].level == true
                        ? CategoryContanerBIGWidget(
                            data: sorted_category[(i * 2) - 1])
                        : CategoryContainerWidget(
                            data: sorted_category[(i * 2) - 1])
                    : Expanded(
                        flex:
                            sorted_category[(i * 2) - 2].level == true ? 1 : 2,
                        child: SizedBox()),
                (i * 2) - 1 <= (NewTaskScreen.Categorys.length - 1)
                    ? sorted_category[(i * 2) - 2].level == false &&
                            sorted_category[(i * 2) - 1].level == false
                        ? Expanded(flex: 1, child: SizedBox())
                        : SizedBox()
                    : SizedBox()
              ])
            ]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            NewCategoryScreen.TextFieledCategoryNotecontrollor.text = "";
            NewCategoryScreen.TextFieledCategorycontrollor.text = "";
            NewCategoryScreen.selectedColor = 0;
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewCategoryScreen();
            })).then((value) async {
              await MyApp.getDatacat();
              setState(() {});
            });
          },
          backgroundColor: kbuttom,
          child: Icon(
            Icons.add,
            color: Kback,
            size: 38,
          )),
    );
  }
}

class CategoryContanerBIGWidget extends StatelessWidget {
  const CategoryContanerBIGWidget({Key? key, required this.data})
      : super(key: key);
  final CategoryNader data;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(bottom: 17, right: 17),
          child: Container(
            height: 97,
            decoration: BoxDecoration(
                color: Ktask, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 8.5, left: 8),
                      child: Text(
                        this.data.title.length < 8
                            ? this.data.title
                            : this.data.title.substring(
                                    0,
                                    this.data.title.length < 8
                                        ? this.data.title.length
                                        : 8) +
                                (this.data.title.length > 8 ? "..." : ""),
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        this.data.note.length < 8
                            ? this.data.note
                            : this.data.note.substring(
                                    0,
                                    this.data.note.length < 8
                                        ? this.data.note.length
                                        : 8) +
                                (this.data.note.length > 8 ? " ..." : ""),
                        style: TextStyle(color: Colors.white, fontSize: 16.5),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Container(
                  height: double.infinity,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 209, 21, 8),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        HomeScreen.tasks
                            .where((element) =>
                                element.category == this.data.title)
                            .length
                            .toString(),
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryContainerWidget extends StatelessWidget {
  const CategoryContainerWidget({Key? key, required this.data})
      : super(key: key);
  final CategoryNader data;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(bottom: 17, right: 17),
          child: Container(
            height: 97,
            decoration: BoxDecoration(
                color: Ktask, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 7, left: 7),
                  child: Text(
                    this.data.title.length < 5
                        ? this.data.title
                        : this.data.title.substring(
                                0,
                                this.data.title.length < 5
                                    ? this.data.title.length
                                    : 5) +
                            (this.data.title.length > 5 ? "..." : ""),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text(
                    this.data.note.length < 5
                        ? this.data.note
                        : this.data.note.substring(
                                0,
                                this.data.note.length < 5
                                    ? this.data.note.length
                                    : 5) +
                            (this.data.note.length > 5 ? " ..." : ""),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                Spacer(),
                Container(
                  height: 28,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 148, 23),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        HomeScreen.tasks
                            .where((element) =>
                                element.category == this.data.title)
                            .length
                            .toString(),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
