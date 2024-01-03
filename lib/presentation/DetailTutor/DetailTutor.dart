import 'dart:convert';

import 'package:advanced_mobile/model/tutor/tutor_model.dart';
import 'package:advanced_mobile/presentation/DetailTutor/booking.dart';
import 'package:advanced_mobile/presentation/DetailTutor/infoDetail.dart';
import 'package:advanced_mobile/presentation/DetailTutor/listReview.dart';
import 'package:advanced_mobile/presentation/DetailTutor/videoIntro.dart';
import 'package:advanced_mobile/services/feedback.api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_provider.dart';
import '../../common/loading.dart';
import '../../model/tutor/feedback.dart';
import '../../model/tutor/infor.dart';
import '../../services/tutors.api.dart';
import '../../services/user.api.dart';

class DetailTutor extends StatefulWidget {
  const DetailTutor(this.tutor, {super.key});
  final TutorModel tutor;
  @override
  State<DetailTutor> createState() => _DetailTutorState();
}

class _DetailTutorState extends State<DetailTutor> {
  late TutorInfo tutorInfo;
  late List<FeedbackDTO> feedbacks = [];
  bool isFavorite = false;
  bool loading = true;

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
    setState(() {
      isFavorite = widget.tutor.isFavoriteTutor!;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    await Future.wait([
      callAPIGetTutorById(
          TutorRepository(),
          Provider.of<AuthProvider>(context, listen: false),
          widget.tutor.userId),
      callAPIGetFeedbackOfTutor(
          FeedBackRepository(),
          Provider.of<AuthProvider>(context, listen: false),
          widget.tutor.userId)
    ]).whenComplete(() {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  Future<void> refreshHome() async {
    setState(() {
      loading = true;
    });
    await Future.wait([
      callAPIGetTutorById(
          TutorRepository(),
          Provider.of<AuthProvider>(context, listen: false),
          widget.tutor.userId),
      callAPIGetFeedbackOfTutor(
          FeedBackRepository(),
          Provider.of<AuthProvider>(context, listen: false),
          widget.tutor.userId)
    ]).whenComplete(() {
      setState(() {
        loading = false;
      });
      return Future<void>.delayed(const Duration(seconds: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

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
            child: (loading || widget.tutor == null)
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
                                    widget.tutor.avatar!,
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
                                    widget.tutor.name!,
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
                                          widget.tutor.rating != null
                                              ? widget.tutor.rating!
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
                                        widget.tutor.country!,
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
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                        callApiManageFavoriteTutor(
                                            widget.tutor.userId!, authProvider);
                                      },
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite
                                            ? Colors.red
                                            : Colors.blueAccent,
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
                          ChewieDemo(linkVideo: tutorInfo.video!),
                          InfoDetail(tutorInfo!),
                          SizedBox(height: 20),
                          ListReview(feedbacks!),
                          SizedBox(height: 20),
                          Booking(tutor: widget.tutor)
                        ])))));
  }

  Future<void> callApiManageFavoriteTutor(
      String tutorID, AuthProvider authProvider) async {
    UserRepository userRepository = UserRepository();

    await userRepository.favoriteTutor(
        accessToken: authProvider.token?.access?.token ?? "",
        tutorId: tutorID!,
        onSuccess: (message, unfavored) async {
          setState(() {
            isFavorite = isFavorite;
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

  Future<void> callAPIGetTutorById(TutorRepository tutorRepository,
      AuthProvider authProvider, String? userId) async {
    await tutorRepository.getTutorById(
        accessToken: authProvider.token?.access?.token ?? "",
        tutorId: userId ?? "",
        onSuccess: (response) async {
          setState(() {
            tutorInfo = response;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  Future<void> callAPIGetFeedbackOfTutor(FeedBackRepository feedBackRepository,
      AuthProvider authProvider, String? userId) async {
    await feedBackRepository.getFeedBackOfTutor(
        accessToken: authProvider.token?.access?.token ?? "",
        page: 1,
        perPage: 20,
        tutorId: userId ?? "",
        onSuccess: (response, total) async {
          setState(() {
            feedbacks = response;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}
