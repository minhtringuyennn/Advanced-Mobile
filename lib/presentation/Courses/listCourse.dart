import 'package:advanced_mobile/presentation/Courses/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/course_provider.dart';
import '../../common/loading.dart';
import '../../model/course-dto.dart';
import '../../model/course/course_model.dart';
import '../../services/course.api.dart';

class ListCourse extends StatefulWidget {
  const ListCourse({super.key});

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {
  List<CourseDTO> courses = [];

  bool isCallApi = false;
  bool isLoading = true;

  //Pagination
  int currentPage = 1;
  int maxPage = 1;
  int numberOfShowPages = 0;

  List<CourseModel> courseList = [];
  Map<String, List<CourseModel>> groupedCourses = {};

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    if (!isCallApi) {
      callAPIGetCourseList(1, CourseRepository(), courseProvider, authProvider);
    }

    return !isCallApi
        ? Loading()
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: groupedCourses.length,
            itemBuilder: (context, index) {
              String type = groupedCourses.keys.elementAt(index);
              List<CourseModel> typeCourses = groupedCourses[type]!;

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

  Future<void> callAPIGetCourseList(int page, CourseRepository courseRepository,
      CourseProvider courseProvider, AuthProvider authProvider) async {
    await courseRepository.getCourseListWithPagination(
        accessToken: authProvider.token?.access?.token ?? "",
        search: courseProvider.search,
        page: page,
        size: 10,
        onSuccess: (response, total) async {
          Map<String, List<CourseModel>> groupedCoursesTemp = {};

          for (CourseModel course in response) {
            if (groupedCoursesTemp.containsKey(course.categories![0].title)) {
              groupedCoursesTemp[course.categories![0].title]!.add(course);
            } else {
              groupedCoursesTemp[course.categories![0].title!] = [course];
            }
          }
          setState(() {
            groupedCourses = groupedCoursesTemp;
            courseList = response;
            isCallApi = true;
            currentPage = page;
            isLoading = false;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}
