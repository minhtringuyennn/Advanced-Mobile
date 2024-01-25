import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Courses.dart';

class SearchCourse extends StatefulWidget {
  const SearchCourse(this.filterCallback, {super.key});
  final SearchCourseCallback filterCallback;

  @override
  State<SearchCourse> createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
  TextEditingController _textEditingDate = TextEditingController();
  bool isEmpty = true;

  void checkTextEmpty(String value) {
    setState(() {
      isEmpty = value.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover Courses",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 5,
                      child: Container(
                        height: 35,
                        padding: EdgeInsets.only(left: 10, right: 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Màu của biên
                            width: 1.0, // Độ rộng của biên
                          ),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _textEditingDate,
                          onChanged: (value) => {checkTextEmpty(value)},
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: -4, left: 0),
                              border: InputBorder.none,
                              hintText: "Course",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                              suffixIcon: Visibility(
                                visible: !isEmpty,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.highlight_remove_outlined,
                                    color: Colors.black54,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    widget.filterCallback("");
                                    _textEditingDate.text = "";
                                  },
                                ),
                              )),
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Màu của biên
                            width: 1.0, // Độ rộng của biên
                          ),
                          color: Colors.white,
                        ),
                        child: IconButton(
                            onPressed: () {
                              widget
                                  .filterCallback(_textEditingDate.text ?? "");
                            },
                            icon: Icon(
                              Icons.search_rounded,
                              size: 25,
                              color: Colors.grey,
                            )),
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
