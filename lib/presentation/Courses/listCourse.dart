import 'package:advanced_mobile/presentation/Courses/course.dart';
import 'package:flutter/cupertino.dart';

import '../Home/tutor.dart';

class ListCourse extends StatefulWidget {
  const ListCourse({super.key});

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {
  List<String> listTypeCourses = [
    "English For Traveling",
    "English For Beginners",
    "Business English",
    "English For Kid"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: listTypeCourses.map((valueItem) {
        return Container(
          margin: EdgeInsets.only(top: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              valueItem,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Course(
                    type: "Course",
                    image: "images/AvatarCourse.png",
                    title: "Life in the Internet Age",
                    description:
                        "Let's discuss how technology is changing the way we live",
                    level: "Intermediate",
                    numberLesson: "9",
                  ),
                  Course(
                    type: "Course",
                    image: "images/AvatarCourse.png",
                    title: "Life in the Internet Age",
                    description:
                        "Let's discuss how technology is changing the way we live",
                    level: "Intermediate",
                    numberLesson: "9",
                  ),
                  Course(
                    type: "Course",
                    image: "images/AvatarCourse.png",
                    title: "Life in the Internet Age",
                    description:
                        "Let's discuss how technology is changing the way we live",
                    level: "Intermediate",
                    numberLesson: "9",
                  ),
                ]),
          ]),
        );
      }).toList()),
    );
  }
}
