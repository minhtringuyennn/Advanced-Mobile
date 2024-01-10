import 'package:advanced_mobile/model/tutor/tutor_model.dart';
import 'package:advanced_mobile/presentation/DetailTutor/DetailTutor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_provider.dart';
import '../../services/user.api.dart';
import 'Home.dart';

class Tutor extends StatefulWidget {
  const Tutor(this.tutor, this.isFavorite, this.changeFavorite, {super.key});
  final TutorModel tutor;
  final bool isFavorite;
  final ChangeFavorite changeFavorite;

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
    var authProvider = Provider.of<AuthProvider>(context);
    List<Widget> generatedWidgets =
        generateWidgets(widget.tutor.specialties?.split(',') ?? []);
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
                          child: Image.network(
                            widget.tutor.avatar ?? "",
                            errorBuilder: (context, error, stackTrace) {
                              // You can return a default image or any other widget as a fallback
                              return Image.network("");
                            },
                          ),
                        ),
                      )),
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
                          widget.tutor.name ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      Text(
                        widget.tutor.country ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: generateRatings(widget.tutor.rating ?? 0.0))
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.isFavorite ? Colors.red : Colors.blueAccent,
                ),
                onPressed: () {
                  callApiManageFavoriteTutor(widget.tutor.id!, authProvider);
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
            child: Text(widget.tutor.bio ?? "",
                maxLines: 4,
                style: TextStyle(fontSize: 12, color: Colors.black54),
                overflow: TextOverflow.ellipsis),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailTutor(widget.tutor)),
                    );
                  },
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

  Future<void> callApiManageFavoriteTutor(
      String tutorID, AuthProvider authProvider) async {
    UserRepository userRepository = UserRepository();
    await userRepository.favoriteTutor(
        accessToken: authProvider.token?.access?.token ?? "",
        tutorId: tutorID!,
        onSuccess: (message, unfavored) async {
          setState(() {
            widget.changeFavorite(tutorID);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Update favorite tutor successful",
                style: TextStyle(color: Colors.white),
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}
