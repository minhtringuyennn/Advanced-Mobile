import 'package:advanced_mobile/model/tutor.dart';
import 'package:advanced_mobile/presentation/DetailTutor/DetailTutor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../repository/favorite-repository.dart';

class Tutor extends StatefulWidget {
  const Tutor(this.tutor, {super.key});
  final TutorDTO tutor;

  @override
  State<Tutor> createState() => _TutorState();
}

List<Widget> generateWidgets(List<String> list) {
  print(list);
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

List<Widget> generateRatings(double rating) {
  int realRating = rating.round();
  List<Widget> widgets = [];

  for (int i = 1; i <= 5; i++) {
    if (i <= realRating) {
      widgets.add(const Icon(
        Icons.star,
        size: 15,
        color: Colors.yellow,
      ));
    } else {
      widgets.add(Icon(
        Icons.star,
        size: 15,
        color: Colors.grey.shade300,
      ));
      // Thêm widget Text vào danh sách
    }
  }

  return widgets;
}

class _TutorState extends State<Tutor> {
  @override
  Widget build(BuildContext context) {
    FavouriteRepository favouriteRepository =
        context.watch<FavouriteRepository>();
    var isInFavourite =
        favouriteRepository.itemIds.contains(widget.tutor.userId);
    List<Widget> generatedWidgets = generateWidgets(widget.tutor.specialties);
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
                        MaterialPageRoute(
                            builder: (context) => DetailTutor(widget.tutor)),
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
                        child: Image.network(widget.tutor.avatar != null
                            ? widget.tutor.avatar
                            : "https://api.app.lettutor.com/avatar/e9e3eeaa-a588-47c4-b4d1-ecfa190f63faavatar1632109929661.jpg"), // Thay thế bằng hình ảnh của bạn
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
                                builder: (context) =>
                                    DetailTutor(widget.tutor)),
                          );
                        },
                        child: Text(
                          widget.tutor.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.network(
                            widget.tutor.country != null
                                ? "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/" +
                                    widget.tutor.country
                                        .toString()
                                        .toLowerCase() +
                                    ".svg"
                                : "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/ph.svg", // Replace with the path to your SVG file
                            width: 16, // Adjust the width as needed
                            height: 16, // Adjust the height as needed
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            widget.tutor.country != null
                                ? widget.tutor.country
                                : "Philippines",
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
                          children: generateRatings(widget.tutor.rating != null
                              ? widget.tutor.rating
                              : 0.0))
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  isInFavourite ? Icons.favorite : Icons.favorite_border,
                  color: isInFavourite ? Colors.red : Colors.blueAccent,
                ),
                onPressed: () {
                  // Handle icon click here
                  isInFavourite
                      ? favouriteRepository.remove(widget.tutor.userId)
                      : favouriteRepository.add(widget.tutor.userId);
                },
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
            child: Text(widget.tutor.bio,
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
