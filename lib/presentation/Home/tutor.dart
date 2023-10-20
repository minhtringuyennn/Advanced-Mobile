import 'package:advanced_mobile/presentation/DetailTutor/DetailTutor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tutor extends StatefulWidget {
  const Tutor({super.key});

  @override
  State<Tutor> createState() => _TutorState();
}

List<Widget> generateWidgets(List<String> list) {
  List<Widget> widgets = [];
  Color backgroundColor = Color.fromARGB(255, 221, 234, 255);

  for (int i = 0; i < list.length; i++) {
    widgets.add(TextButton(
        onPressed: () {},
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
              Size(40, 30)), // Thay đổi width và height tùy ý
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              horizontal: 10, vertical: 5)), // Điều chỉnh lề cho TextButton
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Đặt góc bo tròn
            ),
          ),
        ),
        child: Text(
          list[i],
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.blueAccent),
        ))); // Thêm widget Text vào danh sách
  }

  return widgets;
}

class _TutorState extends State<Tutor> {
  @override
  Widget build(BuildContext context) {
    List<String> listFilters = [
      "English for kids",
      "English for Business",
      "Conversational",
      "STARTERS",
      "IELTS",
    ];
    List<Widget> generatedWidgets = generateWidgets(listFilters);
    return Container(
      padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền của container
        borderRadius: BorderRadius.circular(10), // Độ bo tròn góc của container
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Màu của đổ bóng
            offset: Offset(
                1, 1), // Độ dịch chuyển đổ bóng theo chiều ngang và chiều dọc
            blurRadius: 2, // Độ mờ của đổ bóng
            spreadRadius: 0, // Độ rộng lan trải của đổ bóng
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailTutor()),
                      );
                    },
                    child: Container(
                      width: 65, // Đặt chiều rộng của container
                      height: 65, // Đặt chiều cao của container
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Đặt hình dạng là hình tròn
                        border: Border.all(
                          color: Colors.blue, // Màu của đường viền
                          width: 1, // Độ rộng của đường viền
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                            'images/welcome_login.png'), // Thay thế bằng hình ảnh của bạn
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailTutor()),
                          );
                        },
                        child: Text(
                          "Keegan",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'images/Tunisia.svg', // Replace with the path to your SVG file
                            width: 16, // Adjust the width as needed
                            height: 16, // Adjust the height as needed
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Tunisia",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.yellow,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Icon(
                Icons.favorite_border,
                color: Colors.blueAccent,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 0),
            child: Wrap(
              spacing: 5,
              runSpacing: -10,
              children: generatedWidgets,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
                "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
                maxLines: 4,
                style: TextStyle(fontSize: 12, color: Colors.black54),
                overflow: TextOverflow.ellipsis),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Colors.blueAccent, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(
                        Size(40, 30)), // Thay đổi width và height tùy ý
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5)), // Điều chỉnh lề cho TextButton
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Đặt góc bo tròn
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fact_check_rounded,
                        color: Colors.blueAccent,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Book",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.blueAccent),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
