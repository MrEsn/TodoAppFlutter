import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todotask/models/Task.dart';
import 'package:todotask/screens/homeScreen.dart';
import 'package:todotask/screens/taskScreen.dart';

import '../constant.dart';
import 'createtask.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static TextEditingController SearchInputController =
      new TextEditingController();
  static List<Task> Tasks = [...HomeScreen.tasks];
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    SearchScreen.Tasks = [...HomeScreen.tasks];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Kback,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 2,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    size: 23,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: TextField(
                      controller: SearchScreen.SearchInputController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Search In Task ...",
                          isCollapsed: true,
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none),
                      onChanged: (v) => setState(() {}),
                    ),
                    decoration: BoxDecoration(
                        color: Ktask, borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (SearchScreen.Tasks[index].title
                        .contains(SearchScreen.SearchInputController.text)) {
                      return TasksWedget(
                        SearchScreen.Tasks[index],
                        index,
                      );
                    }
                    return SizedBox();
                  },
                  itemCount: SearchScreen.Tasks.length),
            )
          ],
        ),
      ),
    ));
  }

  Widget TasksWedget(Task data, int index) {
    return Slidable(
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: ((context) {
              setState(() {
                for (int i = 0; i < HomeScreen.tasks.length; i++) {
                  if (data.id == HomeScreen.tasks[i].id) {
                    HomeScreen.tasks.removeAt(i);
                    break;
                  }
                }
                SearchScreen.Tasks = [...HomeScreen.tasks];
                setState(() {});
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewTaskScreen();
                }));
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
            margin: EdgeInsets.symmetric(vertical: 9),
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
