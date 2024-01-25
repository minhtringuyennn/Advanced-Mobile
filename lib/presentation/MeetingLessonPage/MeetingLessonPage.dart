import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../model/schedule/booking_infor.dart';

class MeetingLessonPage extends StatefulWidget {
  const MeetingLessonPage({super.key, required this.upcomingClass});
  final BookingInfo upcomingClass;

  @override
  State<MeetingLessonPage> createState() => _MeetingLessonPageState();
}

class _MeetingLessonPageState extends State<MeetingLessonPage> {
  late BookingInfo upcomingClass = widget.upcomingClass;
  late DateTime endTime;
  bool canJoinMeeting = false;

  @override
  void initState() {
    super.initState();
    endTime = DateTime.fromMillisecondsSinceEpoch(
        upcomingClass.scheduleDetailInfo!.startPeriodTimestamp!);
  }

  void onEnd() {
    setState(() {
      canJoinMeeting = true;
    });
  }

  void _joinMeeting() async {
    final String meetingToken =
        upcomingClass.studentMeetingLink?.split('token=')[1] ?? '';
    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String room = jwtDecoded['room'];

    // var options = JitsiMeetingOptions(
    //   roomNameOrUrl: room,
    //   serverUrl: "https://meet.lettutor.com",
    //   token: meetingToken,
    //   isAudioMuted: true,
    //   isAudioOnly: true,
    //   isVideoMuted: true,
    // );

    // await JitsiMeetWrapper.joinMeeting(
    //   options: options,
    //   listener: JitsiMeetingListener(
    //     onConferenceWillJoin: (url) => print("onConferenceWillJoin: url: $url"),
    //     onConferenceJoined: (url) => print("onConferenceJoined: url: $url"),
    //     onConferenceTerminated: (url, error) => print("onConferenceTerminated: url: $url, error: $error"),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            title: Text("Join Meeting",
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
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountdownTimer(
              endTime: endTime.millisecondsSinceEpoch,
              textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              endWidget: Text(
                "Go to meeting",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _joinMeeting();
              },
              child: Text("Join meeting"),
            ),
          ],
        ),
      ),
    );
  }

  // void onPressedChatBubble(BuildContext context, Size size) {
  //   Navigator.pushNamed(context, MyRouter.chatGpt);
  // }
}
