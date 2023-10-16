import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Lesson extends StatefulWidget {
  const Lesson({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
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
            title: Text(widget.title,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Colors.blueAccent,
                  semanticLabel: 'Back Icon'
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
          ),

          // Replace 'assets/icon.png' with your image path
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: SfPdfViewer.network(
          widget.url,
          key: _pdfViewerKey,
        ),
      ),
    );
  }
}