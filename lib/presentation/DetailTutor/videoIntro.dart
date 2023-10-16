import 'package:flutter/cupertino.dart';

class VideoIntro extends StatefulWidget {
  const VideoIntro({super.key});

  @override
  State<VideoIntro> createState() => _VideoIntroState();
}

class _VideoIntroState extends State<VideoIntro> {
  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text("Video Intro"));
  }

  void initializeVideoPlayer() {}
  @override
  void dispose() {
    super.dispose();
  }
}
