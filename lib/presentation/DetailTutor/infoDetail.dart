import 'package:advanced_mobile/model/tutor.dart';
import 'package:advanced_mobile/model/tutor/infor.dart';
import 'package:advanced_mobile/presentation/DetailCourse/DetailCourse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InfoDetail extends StatelessWidget {
  const InfoDetail(this.tutor, {super.key});
  final TutorInfo tutor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Education",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(tutor.education!,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Languages",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20)),
            child: Text(tutor.languages!,
                style: TextStyle(color: Colors.blue.shade800, fontSize: 16)),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Specialties",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: generateWidgets(tutor.specialties!.split(','))),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Suggested courses",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: RichText(
              text: TextSpan(
                text: 'Basic Conversation Topics: ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                children: [
                  TextSpan(
                      text: 'Link',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => DetailCourse()),
                          // );
                        }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: RichText(
              text: TextSpan(
                text: 'Life in the Internet Age: ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                children: [
                  TextSpan(
                      text: 'Link',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => DetailCourse()),
                          // );
                        }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Interests",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(tutor.interests!,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Teaching experience",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(tutor.experience!,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  List<Widget> generateWidgets(List<String> list) {
    List<Widget> widgets = [];

    for (int i = 0; i < list.length; i++) {
      widgets.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20)),
          child: Text(list[i],
              style: TextStyle(color: Colors.blue.shade800, fontSize: 16)),
        ),
      ); // Thêm widget Text vào danh sách
    }

    return widgets;
  }
}
