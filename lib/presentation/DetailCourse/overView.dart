import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverView extends StatelessWidget {
  const OverView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> topics=["The Internet","Artifical Intelligence (AI)","Social Media","Internet Privacy","Live Streaming","Coding","Technology Transforming Healthcare","Smart Home Technology","Remote Work - A Dream Job?"];
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
            SizedBox(width: 5.0), // Add spacing between the line and text
            Text(
              "Overview",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            SizedBox(width: 4.0), // Add spacing between the line and text
            Expanded(
              flex: 8,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2, color: Colors.red)),
                child: Icon(
                  Icons.question_mark_outlined,
                  color: Colors.red,
                  size: 20,
                )),
            SizedBox(
              width: 8,
            ),
            Text(
              "Why take this course",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.black),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.",
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2, color: Colors.red)),
                child: Icon(
                  Icons.question_mark_outlined,
                  color: Colors.red,
                  size: 20,
                )),
            SizedBox(
              width: 8,
            ),
            Text(
              "What will you be able to do",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.black),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.",
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
            SizedBox(width: 6.0), // Add spacing between the line and text
            Expanded(
                flex: 3,
                child: Text(
                  "Experience",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                )),
            SizedBox(width: 4.0), // Add spacing between the line and text
            Expanded(
              flex: 7,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(
              Icons.group_add_outlined,
              color: Colors.blue.shade900,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Intermedicate",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
            SizedBox(width: 5.0), // Add spacing between the line and text
            Text(
              "Course Length",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            SizedBox(width: 4.0), // Add spacing between the line and text
            Expanded(
              flex: 6,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(
              Icons.book_outlined,
              color: Colors.blue.shade900,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "9 topics",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
            SizedBox(width: 5.0), // Add spacing between the line and text
            Text(
              "List Topics",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            SizedBox(width: 4.0), // Add spacing between the line and text
            Expanded(
              flex: 7,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
          ],
        ),
        SizedBox(height: 15,),
        ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children:generateWidgets(topics)),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
            SizedBox(width: 5.0), // Add spacing between the line and text
            Text(
              "Suggested Tutors",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            SizedBox(width: 4.0), // Add spacing between the line and text
            Expanded(
              flex: 6,
              child: Container(
                height: 0.5, // Customize the height of the left line
                color: Colors
                    .grey.shade300, // Customize the color of the left line
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        Row(
          children: [
            SizedBox(width: 10,),
            Text("Keegan",style: TextStyle(
              fontWeight: FontWeight.w500
            ),),
            SizedBox(width: 10,),

            Text("More info",style: TextStyle(
              color: Colors.blue.shade800
            ),),


          ],
        ),
        SizedBox(height: 10,),

      ],
    );
  }
  List<Widget> generateWidgets(List<String> list) {
    List<Widget> widgets = [];

    for (int i = 0; i < list.length; i++) {
      widgets.add( Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 0.5,
                color: Colors.grey.shade300
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text((i+1).toString()+"."),
            Text(list[i]),
          ],
        ),
      )); // Thêm widget Text vào danh sách
    }

    return widgets;
  }

}
