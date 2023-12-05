import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todotask/constant.dart';
import 'package:todotask/main.dart';
import 'package:todotask/screens/createctegory.dart';
import 'package:todotask/screens/searchscreen.dart';
import 'package:todotask/screens/taskScreen.dart';
import 'package:todotask/screens/category.dart';
import 'package:todotask/screens/createtask.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/Task.dart';
import "package:get/get.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static List<Task> tasks = [];

  static List<Task> tasksShow = [];

  static List<int> categorySelected = [];

  static List<String> categoryShow = [];

  static List<String> categorys = [];

  static List<String> sorted_List = ['Time', 'Difficulty', 'Time add'];

  static int sorted_index = 2;
  static double ScreenWidth = 0;
  static double ScreenHeigth = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String More = "More";
  bool isSplit = false;
  @override
  void initState() {
    MyApp.getDatatask().then((value) {
      MyApp.getDatacat().then(((value) {
        updateTask();
        setState(() {});
      }));
    });

    super.initState();
  }

  Box<Task> hiveBox = Hive.box<Task>('taskBox');
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    HomeScreen.ScreenWidth = ScreenWidth;
    double ScreenHeigth = MediaQuery.of(context).size.height;
    HomeScreen.ScreenHeigth = ScreenHeigth;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Kback,
        body: Container(
          child: Column(
            children: [
              AppBar(task: HomeScreen.tasksShow.length),
              SizedBox(
                  width: double.infinity, height: 27, child: selectionlist()),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (HomeScreen.categorySelected.length == 0) {
                        return TasksWedget(
                          HomeScreen.tasksShow[index],
                          index,
                        );
                      } else if (HomeScreen.categorySelected.indexOf(HomeScreen
                              .categorys
                              .indexOf(HomeScreen.tasksShow[index].category)) !=
                          -1) {
                        return TasksWedget(
                          HomeScreen.tasksShow[index],
                          index,
                        );
                      }
                      return SizedBox();
                    },
                    itemCount: HomeScreen.tasksShow.length),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            NewTaskScreen.descriptioncontrollor.text = '';
            NewTaskScreen.titlecontrollor.text = '';
            NewTaskScreen.Time = '';
            NewTaskScreen.level = '';
            NewTaskScreen.categoryss = '';
            NewTaskScreen.Data = '';
            NewTaskScreen.newedit = "New";
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewTaskScreen();
            })).then((value) {
              MyApp.getDatatask().then((value) {
                updateTask();
                setState(() {});
              });
            });
          },
          child: Icon(
            Icons.add,
            color: Kback,
            size: 38,
          ),
          backgroundColor: Color.fromARGB(255, 182, 182, 182),
        ),
      ),
    );
  }

  updateTask() {
    HomeScreen.tasksShow.clear();
    HomeScreen.categorys.clear();
    HomeScreen.categoryShow.clear();
    HomeScreen.tasks.forEach((element) {
      HomeScreen.tasksShow.add(element);
    });
    NewTaskScreen.Categorys.forEach((element) {
      HomeScreen.categorys.add(element.title);
    });
    HomeScreen.categorys.forEach((element) {
      HomeScreen.categoryShow.add(element);
    });
    if (HomeScreen.sorted_index == 0) {
      sortByDate();
    } else if (HomeScreen.sorted_index == 1) {
      sortByLevel();
    }
  }

  sortByLevel() {
    List<Task> tasksShow = [];
    for (int i = 0; i < HomeScreen.tasks.length; i++) {
      if (HomeScreen.tasks[i].level == 'Hard') {
        tasksShow.add(HomeScreen.tasks[i]);
      }
    }
    for (int i = 0; i < HomeScreen.tasks.length; i++) {
      if (HomeScreen.tasks[i].level == 'Medium') {
        tasksShow.add(HomeScreen.tasks[i]);
      }
    }
    for (int i = 0; i < HomeScreen.tasks.length; i++) {
      if (HomeScreen.tasks[i].level == 'Easy') {
        tasksShow.add(HomeScreen.tasks[i]);
      }
    }
    HomeScreen.tasksShow.clear();
    tasksShow.forEach((element) {
      HomeScreen.tasksShow.add(element);
    });
  }

  sortByDate() {
    List<Task> tasksShow = [];
    HomeScreen.tasks.forEach((element) {
      tasksShow.add(element);
    });
    for (int i = 0; i < tasksShow.length; i++) {
      for (int j = 0; j < tasksShow.length - 1; j++) {
        if (DateTime.parse(tasksShow[j].date.replaceAll(' / ', '-') +
                    ' ' +
                    (tasksShow[j].time.split(':')[0].length < 2 ? '0' : '0') +
                    tasksShow[j].time.replaceAll(' ', '') +
                    ':00')
                .compareTo(DateTime.parse(
                    tasksShow[j + 1].date.replaceAll(' / ', '-') +
                        ' ' +
                        (tasksShow[j + 1].time.split(':')[0].length < 2
                            ? '0'
                            : '0') +
                        tasksShow[j + 1].time.replaceAll(' ', '') +
                        ':00')) >
            0) {
          Task temp = tasksShow[j + 1];
          tasksShow[j + 1] = tasksShow[j];
          tasksShow[j] = temp;
        }
      }
    }
    HomeScreen.tasksShow.clear();
    tasksShow.forEach((element) {
      HomeScreen.tasksShow.add(element);
    });
    setState(() {});
  }

  Row selectionlist() {
    return Row(children: [
      Expanded(
          child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0 || index == HomeScreen.categoryShow.length + 1) {
            return SizedBox(width: 5);
          }
          return itemOflist(HomeScreen.categoryShow[index - 1]);
        },
        itemCount: HomeScreen.categoryShow.length + 2,
        scrollDirection: Axis.horizontal,
      )),
      sortbutton(),
      SizedBox(
        width: 5,
      )
    ]);
  }

  Widget sortbutton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              context: context,
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 49, 49, 49),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Sort by',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    for (int i = 0; i < HomeScreen.sorted_List.length; i++) ...[
                      itemSortedBottomSheet(HomeScreen.sorted_List[i], i)
                    ],
                  ]),
                );
              });
        });
      },
      child: Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget itemSortedBottomSheet(String text, int index) {
    return GestureDetector(
      onTap: () {
        HomeScreen.sorted_index = index;
        updateTask();
        setState(() {});
        Navigator.pop(context);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        color: index == HomeScreen.sorted_index
            ? Color.fromARGB(14, 101, 90, 255)
            : Colors.transparent,
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 20,
                  color: index == HomeScreen.sorted_index
                      ? Color.fromARGB(255, 60, 105, 255)
                      : Colors.white),
            ),
            Spacer(),
            index == HomeScreen.sorted_index
                ? Icon(
                    Icons.check_rounded,
                    color: Color.fromARGB(255, 60, 105, 255),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget itemOflist(String data) {
    return GestureDetector(
      onTap: () {
        AddSelected(data);
        setState(() {});
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(right: 8, left: 8),
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 11),
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
              style: BorderStyle.solid,
            ),
            color: HomeScreen.categorySelected
                        .indexOf(HomeScreen.categorys.indexOf(data)) ==
                    -1
                ? Color.fromARGB(0, 0, 0, 0)
                : Color.fromARGB(255, 255, 255, 255)),
        child: Text(data,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: HomeScreen.categorySelected
                            .indexOf(HomeScreen.categorys.indexOf(data)) ==
                        -1
                    ? Color.fromARGB(255, 255, 255, 255)
                    : Colors.black)),
      ),
    );
  }

  void AddSelected(String data) {
    int index = HomeScreen.categorys.indexOf(data);
    if (HomeScreen.categorySelected.indexOf(index) != -1) {
      HomeScreen.categorySelected.remove(index);
    } else {
      HomeScreen.categorySelected.add(index);
    }
    HomeScreen.categoryShow.clear();

    for (int i = 0; i < HomeScreen.categorySelected.length; i++) {
      HomeScreen.categoryShow
          .add(HomeScreen.categorys[HomeScreen.categorySelected[i]]);
    }
    for (int i = 0; i < HomeScreen.categorys.length; i++) {
      if (HomeScreen.categorySelected.indexOf(i) == -1) {
        HomeScreen.categoryShow.add(HomeScreen.categorys[i]);
      }
    }
  }

  Widget TasksWedget(Task data, int index) {
    return Slidable(
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              hiveBox.deleteAt(index).then((value) {
                MyApp.getDatatask().then((value) {
                  updateTask();
                  setState(() {});
                });
              });

              /*for (int i = 0; i < HomeScreen.tasks.length; i++) {
                  if (data.id == HomeScreen.tasks[i].id) {
                    hiveBox.deleteAt(i);
                    MyApp.getDatatask();
                    break;
                  }
                }*/
            },
            backgroundColor: Kback,
            icon: Icons.keyboard_double_arrow_left_rounded,
            label: "Delete",
            borderRadius: BorderRadius.circular(10),
            foregroundColor: Color.fromARGB(255, 211, 14, 0),
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: ((context) {
              setState(() {
                NewTaskScreen.descriptioncontrollor.text =
                    HomeScreen.tasks[index].description;
                NewTaskScreen.titlecontrollor.text =
                    HomeScreen.tasks[index].title;
                NewTaskScreen.Time = HomeScreen.tasks[index].time;
                NewTaskScreen.level = HomeScreen.tasks[index].level;
                NewTaskScreen.categoryss = HomeScreen.tasks[index].category;
                NewTaskScreen.Data = HomeScreen.tasks[index].date;
                NewTaskScreen.newedit = "Edit";
                NewTaskScreen.index = index;
                Get.to(NewTaskScreen())!.then((value) async {
                  await MyApp.getDatatask();
                  updateTask();
                  setState(() {});
                });
              });
            }),
            backgroundColor: Kback,
            icon: Icons.keyboard_double_arrow_right_rounded,
            label: "Edit",
            borderRadius: BorderRadius.circular(10),
            foregroundColor: Color.fromARGB(255, 60, 105, 255),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return taskScreen(
                index: index,
              );
            }));
          });
        },
        child: SizedBox(
          child: Container(
            width: double.infinity,
            // height: 100,
            margin: EdgeInsets.symmetric(horizontal: 13, vertical: 9),
            decoration: BoxDecoration(
              color: Ktask,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Wrap(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 9.0),
                          child: Text(
                            data.title,
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 7),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.5),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            child: Text(
                              '#' + data.category,
                              style: TextStyle(
                                fontSize: 13.5,
                                color: Color.fromARGB(255, 255, 255, 255),
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Color(0xFF183912)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: HomeScreen.ScreenWidth - 170,
                          child: Text(
                            HomeScreen.tasks[index].more
                                ? data.description
                                : data.description.substring(
                                        0,
                                        data.description.length < 30
                                            ? data.description.length
                                            : 30) +
                                    (data.description.length > 30
                                        ? " ..."
                                        : ""),
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                        data.description.length > 50
                            ? MoreButtonWiedget(index)
                            : NewWidget(),
                      ],
                    ),
                    SizedBox(
                      height: 13,
                    )
                  ],
                ),
                Spacer(),
                Text(
                  data.level,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Nunito',
                      //  fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: 2.5,
                  height: 38,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  data.date.split(' / ')[1] +
                      ' / ' +
                      data.date.split(' / ')[2] +
                      '\n' +
                      data.time,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 15,
                      //  fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(width: 12)
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector MoreButtonWiedget(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          HomeScreen.tasks[index].more = !HomeScreen.tasks[index].more;
        });
      },
      child: Text(
        HomeScreen.tasks[index].more ? "Less" : "More",
        style: TextStyle(
            color: Color.fromARGB(255, 62, 101, 228),
            fontWeight: FontWeight.bold,
            fontSize: 14.5),
      ),
    );
  }
}

/*class TasksWedget extends StatefulWidget {
  final Task data;
  final int index;
  TasksWedget({required this.data, required this.index});

  @override
  State<TasksWedget> createState() => _TasksWedgetState();
}

class _TasksWedgetState extends State<TasksWedget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: ((context) {
              setState(() {
                HomeScreen.tasks.removeAt(widget.index);
                
              });
            }),
            backgroundColor: Kback,
            icon: Icons.keyboard_double_arrow_left_rounded,
            label: "Delete",
            borderRadius: BorderRadius.circular(10),
            foregroundColor: Color.fromARGB(255, 211, 14, 0),
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: ((context) {}),
            backgroundColor: Kback,
            icon: Icons.keyboard_double_arrow_right_rounded,
            label: "Edit",
            borderRadius: BorderRadius.circular(10),
            foregroundColor: Color.fromARGB(255, 60, 105, 255),
          ),
        ],
      ),
      child: SizedBox(
        child: Container(
          width: double.infinity,
          // height: 100,
          margin: EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          decoration: BoxDecoration(
            color: Ktask,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        widget.data.title,
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        child: Text(
                          '#' + widget.data.category,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 255, 255, 255),
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xFF183912)),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 330,
                        child: Text(
                          widget.data.description,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                          child: Text(
                            HomeScreen.More,
                            style: TextStyle(
                                color: Color.fromARGB(255, 60, 105, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // data.description.length >= 50 ? MoreBottom() : NewWidget(),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  )
                ],
              ),
              Spacer(),
              Text(
                widget.data.level,
                style: TextStyle(
                    fontSize: 16.5,
                    fontFamily: 'Nunito',
                    //  fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              SizedBox(
                width: 7,
              ),
              Container(
                width: 2.5,
                height: 40,
                color: Colors.black,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                widget.data.date + '\n' + widget.data.time,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16.5,
                    //  fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              SizedBox(width: 12)
            ],
          ),
        ),
      ),
    );
  }
}*/

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
    required this.task,
  }) : super(key: key);

  final int task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 13,
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(top: 11),
          height: 35,
          decoration: BoxDecoration(
              color: Ktask, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              HomeScreen.tasksShow.length == 0
                  ? 'Nothing !!'
                  : 'Remaning task : ' + HomeScreen.tasksShow.length.toString(),
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        )),
        GestureDetector(
          onTap: () {
            Get.to(SearchScreen());
          },
          child: Container(
            margin: EdgeInsets.only(
              top: 11,
            ),
            width: 50,
            height: 50,
            child: Icon(
              Icons.search,
              color: Color.fromARGB(255, 253, 253, 253),
              size: 36,
            ),
          ),
        ),
      ],
    );
  }
}

// Container(
//                     alignment: Alignment.topLeft,
//                     color: Ktask,
//                     width: double.infinity,
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onTap: (() {
//                             setState(() {
//                               Navigator.pop(context);
//                             });
//                           }),
//                           child: Container(
//                             margin: EdgeInsets.only(top: 7, left: 10),
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               'Time',
//                               style: TextStyle(
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         GestureDetector(
//                           onTap: (() {
//                             setState(() {
//                               Navigator.pop(context);
//                             });
//                           }),
//                           child: Container(
//                             margin: EdgeInsets.only(left: 10),
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               'Difficulty',
//                               style: TextStyle(
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ));
