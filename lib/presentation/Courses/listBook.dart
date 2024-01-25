import 'package:advanced_mobile/presentation/Courses/course.dart';
import 'package:flutter/cupertino.dart';

import '../Home/tutor.dart';

class ListBook extends StatefulWidget {
  const ListBook({super.key});

  @override
  State<ListBook> createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  List<String> listTypeCourses = [
    "English For Traveling",
    "English For Beginners",
    "Business English",
    "English For Kid"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            //   Course(type: "Book",image: "assets/images/AvatarBook.jpeg",title: "What a world 1",description: "For teenagers who have an excellent vocabulary background and brilliant communication skills.",level: "Beginner",numberLesson: "",),
            //  Course(type: "Book",image: "assets/images/AvatarBook.jpeg",title: "What a world 1",description: "For teenagers who have an excellent vocabulary background and brilliant communication skills.",level: "Beginner",numberLesson: "",),
            //  Course(type: "Book",image: "assets/images/AvatarBook.jpeg",title: "What a world 1",description: "For teenagers who have an excellent vocabulary background and brilliant communication skills.",level: "Beginner",numberLesson: "",),
          ]),
    );
  }
}
