
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rating_dialog/rating_dialog.dart';

class Session extends StatefulWidget {
  final String typeSession;
  final String time_or_number;
  const Session(
      {super.key, required this.typeSession, required this.time_or_number});

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thu, 26 Oct 23",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(widget.time_or_number),
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(3)),
            child: Row(
              children: [
                Container(
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
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Keegan",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
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
                      height: 3,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.message_outlined,
                          size: 18,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Direct Message",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.blueAccent,
                              fontSize: 14),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(3)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.typeSession == "Schedule"
                          ? "03:30 - 03:55"
                          : "Lesson Time: 03:30 - 03:55",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Visibility(
                      visible: widget.typeSession == "Schedule",
                      child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: Colors.red, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                            minimumSize:
                                MaterialStateProperty.all(Size(40, 30)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical:
                                        5)), // Điều chỉnh lề cho TextButton
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(4), // Đặt góc bo tròn
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 17,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Request for lesson",
                              style: TextStyle(fontSize: 16),
                            ),
                            Visibility(
                              visible: widget.typeSession == "Schedule",
                              child: Text(
                                "Edit",
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                      children: [
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                color: Colors.grey, // Color of the top border
                                width: 0.5, // Width of the top border
                              ),
                            )),
                            child: Text(
                              "Hello word",
                              style: TextStyle(fontSize: 14),
                            ))
                      ],
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.typeSession == "History",
                  child: Container(
                    margin: EdgeInsets.only(top: 0, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Review from tutor",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        children: [
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border(
                                top: BorderSide(
                                  color: Colors.grey, // Color of the top border
                                  width: 0.5, // Width of the top border
                                ),
                              )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Session 1: 03:30 - 03:55",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "Lesson status: Completed - Page 40",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Lesson progress: Completed",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Behavior (",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Text(
                                        "): ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "good",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Listening (",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Text(
                                        "): ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "good",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Speaking (",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Text(
                                        "): ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "good",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Vocalbulary (",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      Text(
                                        "): ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "good",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Overall comment: We finished this lesson",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ))
                        ],
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.typeSession == "History",
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20, top: 15, bottom: 15, right: 10),
                    margin: EdgeInsets.only(top: 0, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Row(
                          //   children: [
                          //     Text(
                          //       "Rating: ",
                          //       style: TextStyle(
                          //           fontSize: 14
                          //       ),),
                          //     Icon(Icons.star,color: CupertinoColors.systemYellow,size: 18,),
                          //     Icon(Icons.star,color: CupertinoColors.systemYellow,size: 18,),
                          //     Icon(Icons.star,color: CupertinoColors.systemYellow,size: 18,),
                          //     Icon(Icons.star,color: CupertinoColors.systemYellow,size: 18,),
                          //     Icon(Icons.star,color: CupertinoColors.systemYellow,size: 18,),
                          //   ],
                          // ),

                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _showReviewModal();
                                // Handle button click here
                              },
                              child: Padding(
                                padding: EdgeInsets.all(0), // No padding
                                child: Text(
                                  "Add a rating",
                                  style: TextStyle(
                                      color: Colors.blueAccent // Text color
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 15,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    _showReviewModal();
                                    // Handle button click here
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(0), // No padding
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.blueAccent // Text color
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Report",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blueAccent),
                              ),
                            ],
                          )
                        ]),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showReviewModal() {
    final _dialog = RatingDialog(
      initialRating: 5.0,
      // your app's name?
      title: Text(
        'What is your rating for Keegan?',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
      ),
      message: null,
      // encourage your user to leave a high rating?
      // your app's logo?
      image: Column(children: [
        Container(
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
        Text(
          'Keegan',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8,),
        Text(
          'Lesson Time',
          textAlign: TextAlign.center,
          style:  TextStyle(
            fontSize: 14,
            color: Colors.grey.shade800
          ),
        ),
        SizedBox(height: 3,),
        Text(
          'Sat, 28 Oct 23, 15:30 - 15:55',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20,),

        Container(
          height: 0.5, // Customize the height of the left line
          color: Colors
              .grey.shade400, // Customize the color of the left line
        )


      ]),
      starSize: 30,
      starColor: Colors.yellow.shade700,
      submitButtonText: 'Submit',
      submitButtonTextStyle : TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      commentHint: 'Content review',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          // _rateAndReviewApp();
        }
      },
    );
    showDialog(
      context: context,
      barrierDismissible: false, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }
}
