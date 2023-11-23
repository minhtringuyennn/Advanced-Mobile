import 'package:advanced_mobile/model/course-dto.dart';
import 'package:advanced_mobile/presentation/Courses/listBook.dart';
import 'package:advanced_mobile/presentation/Courses/listCourse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  int isActived = 1;
  @override
  Widget build(BuildContext context) {
    List<CourseDTO> courses = context.watch<List<CourseDTO>>();
    print("hello " + courses.length.toString());

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: isActived == 1
                        ? Border(
                            bottom: BorderSide(
                              color: Colors.blue, // Border color
                              width: 1,
                              // Border width
                            ),
                            // Border radius
                          )
                        : null,
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          isActived = 1;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Text(
                        "Course",
                        style: TextStyle(
                            color: isActived == 1 ? Colors.blue : Colors.grey),
                      )),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: isActived == 2
                        ? Border(
                            bottom: BorderSide(
                              color: Colors.blue, // Border color
                              width: 1,
                              // Border width
                            ),
                            // Border radius
                          )
                        : null,
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          isActived = 2;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Text(
                        "E-Book",
                        style: TextStyle(
                            color: isActived == 2 ? Colors.blue : Colors.grey),
                      )),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: isActived == 3
                        ? Border(
                            bottom: BorderSide(
                              color: Colors.blue, // Border color
                              width: 1,
                              // Border width
                            ),
                            // Border radius
                          )
                        : null,
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          isActived = 3;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Text(
                        "Interactive E-book",
                        style: TextStyle(
                            color: isActived == 3 ? Colors.blue : Colors.grey),
                      )),
                )
              ],
            ),
          ),
          Visibility(visible: isActived == 2, child: ListBook()),
          Visibility(visible: isActived == 1, child: ListCourse())
        ],
      ),
    );
  }
}
