import 'package:advanced_mobile/common/loading.dart';
import 'package:advanced_mobile/model/schedule/booking_infor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../Provider/auth_provider.dart';
import '../../services/booking.api.dart';

class Session extends StatefulWidget {
  final BookingInfo schedule;
  final String typeSession;
  const Session({super.key, required this.schedule, required this.typeSession});

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  bool isLoading = false;

  final List<DropdownMenuItem<String>> reason = [
    const DropdownMenuItem(
        value: '1', child: Text('Reschedule at another time')),
    const DropdownMenuItem(value: '2', child: Text('Busy at that time')),
    const DropdownMenuItem(value: '3', child: Text('Asked by the tutor')),
    const DropdownMenuItem(value: '4', child: Text('Other')),
  ];

  String convertDate(int time) {
    String date = DateFormat.yMMMMEEEEd()
        .format(DateTime.fromMillisecondsSinceEpoch(time));
    return date;
  }

  String convertTime(int start, int end) {
    DateTime timestart = DateTime.fromMillisecondsSinceEpoch(start);
    DateTime timeend = DateTime.fromMillisecondsSinceEpoch(end);

    String result_start =
        "${timestart.hour.toString().length == 1 ? "0" + timestart.hour.toString() : timestart.hour.toString()}:${timestart.minute.toString().length == 1 ? "0" + timestart.minute.toString() : timestart.minute.toString()}";
    String result_end =
        "${timeend.hour.toString().length == 1 ? "0" + timeend.hour.toString() : timeend.hour.toString()}:${timeend.minute.toString().length == 1 ? "0" + timeend.minute.toString() : timeend.minute.toString()}";
    String result = result_start + " - " + result_end;
    return result;
  }

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
            convertDate(
                widget.schedule.scheduleDetailInfo!.startPeriodTimestamp!),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
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
                    child: Image.network(widget.schedule!.scheduleDetailInfo!
                            .scheduleInfo!.tutorInfo!.avatar ??
                        "https://api.app.lettutor.com/avatar/e9e3eeaa-a588-47c4-b4d1-ecfa190f63faavatar1632109929661.jpg"), // Thay thế bằng hình ảnh của bạn
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.schedule!.scheduleDetailInfo!.scheduleInfo!
                          .tutorInfo!.name!,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    Text(
                      widget.schedule!.scheduleDetailInfo!.scheduleInfo!
                              .tutorInfo!.country! ??
                          "",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          fontSize: 14),
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
                          ? convertTime(
                              widget.schedule.scheduleDetailInfo!.scheduleInfo!
                                  .startTimestamp!,
                              widget.schedule.scheduleDetailInfo!.scheduleInfo!
                                  .endTimestamp!)
                          : "Lesson Time: " +
                              convertTime(
                                  widget.schedule.scheduleDetailInfo!
                                      .scheduleInfo!.startTimestamp!,
                                  widget.schedule.scheduleDetailInfo!
                                      .scheduleInfo!.endTimestamp!),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Visibility(
                      visible: widget.typeSession == "Schedule",
                      child: TextButton(
                          onPressed: () {
                            _dialogBuilder(context);
                          },
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
                              widget.schedule?.studentRequest ?? "",
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
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
        SizedBox(
          height: 8,
        ),
        Text(
          'Lesson Time',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          'Sat, 28 Oct 23, 15:30 - 15:55',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 0.5, // Customize the height of the left line
          color: Colors.grey.shade400, // Customize the color of the left line
        )
      ]),
      starSize: 30,
      starColor: Colors.yellow.shade700,
      submitButtonText: 'Submit',
      submitButtonTextStyle: TextStyle(
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

  void _dialogBuilder(BuildContext context) {
    String? valueReason;
    bool errorReason = false;
    TextEditingController textEditingController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return isLoading
            ? Loading()
            : AlertDialog(
                content: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 0),
                    child: Column(
                      children: [
                        Container(
                          width: 65, // Đặt chiều rộng của container
                          height: 65, // Đặt chiều cao của container
                          decoration: BoxDecoration(
                            shape:
                                BoxShape.circle, // Đặt hình dạng là hình tròn
                            border: Border.all(
                              color: Colors.blue, // Màu của đường viền
                              width: 1, // Độ rộng của đường viền
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(widget
                                    .schedule!
                                    .scheduleDetailInfo!
                                    .scheduleInfo!
                                    .tutorInfo!
                                    .avatar ??
                                "https://sandbox.app.lettutor.com/static/media/login.8d01124a.png"),
                          ),
                        ),
                        Text(
                          widget.schedule!.scheduleDetailInfo!.scheduleInfo!
                              .tutorInfo!.name!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Lesson Time',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade800),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          convertDate(widget.schedule.scheduleDetailInfo!
                              .startPeriodTimestamp!),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 0.5, // Customize the height of the left line
                          color: Colors.grey
                              .shade400, // Customize the color of the left line
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("What was the reason you cancel this booking?",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: DropdownButtonFormField(
                              items: reason,
                              value: valueReason,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  valueReason = value;
                                });
                              },
                            )),
                        Visibility(
                            visible: errorReason,
                            child: Text(
                              "The reason cannot be empty",
                              style: TextStyle(color: Colors.red),
                            )),
                        Container(
                          child: TextField(
                            maxLines: 3,
                            controller: textEditingController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Additional Notes",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Later'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Submit'),
                    onPressed: () {
                      if (valueReason != null) {
                        AuthProvider authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        setState(() {
                          isLoading = true;
                        });
                        callApiCancelClass(
                            valueReason!,
                            textEditingController.text,
                            widget.schedule.id!,
                            BookingRepository(),
                            authProvider);
                        Navigator.of(context).pop();
                      } else {
                        setState(() {
                          errorReason = true;
                        });
                      }
                    },
                  ),
                ],
              );
      },
    );
  }

  Future<void> callApiCancelClass(
      String cancelReasonId,
      String note,
      String scheduleDetailId,
      BookingRepository bookingRepository,
      AuthProvider authProvider) async {
    await bookingRepository.cancelClass(
        accessToken: authProvider.token?.access?.token ?? "",
        cancelReasonId: cancelReasonId,
        note: note,
        scheduleDetailId: scheduleDetailId,
        onSuccess: (message) async {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
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
