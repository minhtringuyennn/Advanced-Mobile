import 'package:advanced_mobile/presentation/Courses/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/loading.dart';
import '../../model/course-dto.dart';
import '../../model/course/course_model.dart';

class ListCourse extends StatefulWidget {
  const ListCourse(this.courses, this.groupedCourses, {super.key});
  final List<CourseDTO> courses;
  final Map<String, List<CourseModel>> groupedCourses;

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {
  @override
  Widget build(BuildContext context) {
    return widget.courses == null
        ? Loading()
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.groupedCourses.length,
            itemBuilder: (context, index) {
              String type = widget.groupedCourses.keys.elementAt(index);
              List<CourseModel> typeCourses = widget.groupedCourses[type]!;
              return Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
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
            },
          );
  }
}
