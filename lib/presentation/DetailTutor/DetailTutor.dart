import 'dart:convert';

import 'package:advanced_mobile/model/tutor.dart';
import 'package:advanced_mobile/model/tutor/tutor_model.dart';
import 'package:advanced_mobile/presentation/DetailTutor/booking.dart';
import 'package:advanced_mobile/presentation/DetailTutor/infoDetail.dart';
import 'package:advanced_mobile/presentation/DetailTutor/listReview.dart';
import 'package:advanced_mobile/presentation/DetailTutor/videoIntro.dart';
import 'package:advanced_mobile/presentation/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_provider.dart';
import '../../common/loading.dart';
import '../../model/tutor/infor.dart';
import '../../services/tutors.api.dart';

class DetailTutor extends StatefulWidget {
  const DetailTutor(this.tutor, this.changeFavorite, {super.key});
  final TutorModel tutor;
  final ChangeFavorite changeFavorite;
  @override
  State<DetailTutor> createState() => _DetailTutorState();
}

class _DetailTutorState extends State<DetailTutor> {
  late TutorModel tutorData;
  late TutorInfo tutorInfo;
  bool loading = false;

  List<Widget> generateRatings(double rating) {
    int realRating = rating.toInt();
    List<Widget> widgets = [];

    for (int i = 1; i <= 5; i++) {
      if (i <= realRating) {
        widgets.add(const Icon(
          Icons.star,
          size: 20,
          color: Colors.yellow,
        ));
      } else {
        widgets.add(Icon(
          Icons.star,
          size: 20,
          color: Colors.grey.shade300,
        ));
        // Thêm widget Text vào danh sách
      }
    }

    return widgets;
  }

  @override
  void initState() {
    tutorData = widget.tutor;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    callAPIGetTutorById(TutorRepository(),
        Provider.of<AuthProvider>(context, listen: false), tutorData.userId);
  }

  Future<void> refreshHome() async {
    setState(() {
      loading = true;
    });
    await Future.wait([
      callAPIGetTutorById(TutorRepository(),
          Provider.of<AuthProvider>(context, listen: false), tutorData.userId),
    ]).whenComplete(() {
      setState(() {
        loading = false;
      });
      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

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
        body: RefreshIndicator(
            onRefresh: () async {
              refreshHome();
            },
            child: !loading
                ? Loading()
                : SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.all(25),
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                width: 100, // Đặt chiều rộng của container
                                height: 100, // Đặt chiều cao của container
                                decoration: BoxDecoration(
                                  shape: BoxShape
                                      .circle, // Đặt hình dạng là hình tròn
                                  border: Border.all(
                                    color: Colors.blue, // Màu của đường viền
                                    width: 1, // Độ rộng của đường viền
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    tutorData.avatar!,
                                  ),
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
                                    tutorData.name!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: generateRatings(
                                          tutorData.rating != null
                                              ? tutorData.rating!
                                              : 0.0)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.network(
                                        "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/" +
                                            widget.tutor.country
                                                .toString()
                                                .toLowerCase() +
                                            ".svg", // Replace with the path to your SVG file
                                        width: 16, // Adjust the width as needed
                                        height:
                                            16, // Adjust the height as needed
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        tutorData.country!,
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
                            tutorInfo.bio!,
                            expandText: 'More',
                            collapseText: 'Less',
                            maxLines:
                                2, // Set the maximum number of lines to display before expanding
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade600),
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
                                        widget
                                            .changeFavorite(tutorData.userId!);
                                      },
                                      icon: Icon(
                                        tutorInfo.isFavorite!
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: tutorInfo.isFavorite!
                                            ? Colors.red
                                            : Colors.blueAccent,
                                        size: 25,
                                      )),
                                  Text(
                                    "Favorite",
                                    style: TextStyle(
                                        color: tutorInfo.isFavorite!
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
                          ChewieDemo(linkVideo: tutorInfo.video!),
                          InfoDetail(tutorInfo!),
                          SizedBox(height: 20),
                          ListReview(tutorData.feedbacks!.sublist(0, 10)),
                          SizedBox(height: 20),
                          Booking(tutor: widget.tutor)
                        ])))));
  }

  Future<void> callAPIGetTutorById(TutorRepository tutorRepository,
      AuthProvider authProvider, String? userId) async {
    await tutorRepository.getTutorById(
        accessToken: authProvider.token?.access?.token ?? "",
        tutorId: userId ?? "",
        onSuccess: (response) async {
          setState(() {
            tutorInfo = response;
            loading = true;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}
