import 'package:advanced_mobile/presentation/Courses/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../model/course-dto.dart';
import '../Home/tutor.dart';

class ListCourse extends StatefulWidget {
  const ListCourse({super.key});

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {
  List<CourseDTO> courses = [];

  @override
  Widget build(BuildContext context) {
    courses = context.watch<List<CourseDTO>>();
    print(courses.length.toString());

    Map<String, List<CourseDTO>> groupedCourses = {};
    print("bbbbbbbbbbbbbb");

    for (CourseDTO course in courses) {
      if (groupedCourses.containsKey(course.categories[0].title)) {
        groupedCourses[course.categories[0].title]!.add(course);
      } else {
        groupedCourses[course.categories[0].title] = [course];
      }
    }
    print("cccccccccccccc");

    return Container(
      //child: Column(
      // children: listTypeCourses.map((valueItem) {
      //   return Container(
      //     margin: EdgeInsets.only(top:30),
      //     child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children:[
      //       Text(valueItem,style: TextStyle(
      //         fontSize: 22,
      //         fontWeight: FontWeight.w500
      //       ),),
      //       ListView(
      //         physics: NeverScrollableScrollPhysics(),
      //         shrinkWrap: true,
      //         children:[
      //           Course(type: "Course",image: "images/AvatarCourse.png",title: "Life in the Internet Age",description: "Let's discuss how technology is changing the way we live",level: "Intermediate",numberLesson: "9",),
      //           Course(type: "Course",image: "images/AvatarCourse.png",title: "Life in the Internet Age",description: "Let's discuss how technology is changing the way we live",level: "Intermediate",numberLesson: "9",),
      //           Course(type: "Course",image: "images/AvatarCourse.png",title: "Life in the Internet Age",description: "Let's discuss how technology is changing the way we live",level: "Intermediate",numberLesson: "9",),
      //         ]
      //
      //
      //       ),
      //     ]
      //     ),
      //   );}
      // ).toList()
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: groupedCourses.length,
          itemBuilder: (context, index) {
            String type = groupedCourses.keys.elementAt(index);
            List<CourseDTO> typeCourses = groupedCourses[type]!;
            return Container(
              margin: EdgeInsets.only(top: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    Column(
                      children: typeCourses.map((course) {
                        return Course(
                          type: "Course",
                          course: course,
                        );
                      }).toList(),
                    ),
                  ]),
            );
          }),
    );
  }
}
