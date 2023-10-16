import 'package:advanced_mobile/presentation/DetailTutor/infoDetail.dart';
import 'package:advanced_mobile/presentation/DetailTutor/listReview.dart';
import 'package:advanced_mobile/presentation/DetailTutor/videoIntro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:expandable_text/expandable_text.dart';

class DetailTutor extends StatefulWidget {
  const DetailTutor({super.key});

  @override
  State<DetailTutor> createState() => _DetailTutorState();
}

class _DetailTutorState extends State<DetailTutor> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(50.0), // Define the height of the AppBar
          child: Container(
            decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.1), // Color and opacity of the shadow
                spreadRadius: 1, // Spread radius of the shadow
                blurRadius: 8, // Blur radius of the shadow
                offset: const Offset(0, 0), // Offset of the shadow
              )
            ]),

            child: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: Colors.black,
                // Status bar brightness (optional)
                statusBarIconBrightness:
                    Brightness.light, // For Android (dark icons)
              ),
              title: Text("Tutor Details",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.blueAccent,
                ),
              ),
              centerTitle: true,
            ),

            // Replace 'assets/icon.png' with your image path
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(25),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        width: 100, // Đặt chiều rộng của container
                        height: 100, // Đặt chiều cao của container
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
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Keegan",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 22),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.grey.shade300,
                              ),
                              Text(
                                "(127)",
                                style: TextStyle(color: Colors.grey.shade700),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
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
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ExpandableText(
                    "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
                    expandText: 'More',
                    collapseText: 'Less',
                    maxLines:
                        2, // Set the maximum number of lines to display before expanding
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    textAlign: TextAlign.left,
                    linkColor: Colors
                        .blueAccent, // Set the color of the 'Show more' and 'Show less' links
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color:
                                    isFavorite ? Colors.red : Colors.blueAccent,
                                size: 25,
                              )),
                          Text(
                            "Favorite",
                            style: TextStyle(
                                color: isFavorite
                                    ? Colors.red
                                    : Colors.blueAccent),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.report_gmailerrorred_outlined,
                                color: Colors.blueAccent,
                                size: 25,
                              )),
                          Text(
                            "Report",
                            style: TextStyle(color: Colors.blueAccent),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  VideoIntro(),
                  InfoDetail(),
                  SizedBox(height: 20),
                  ListReview()
                ]))));
  }
}
