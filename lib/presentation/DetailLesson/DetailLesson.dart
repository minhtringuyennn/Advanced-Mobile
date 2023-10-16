import 'package:advanced_mobile/presentation/DetailLesson/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailLesson extends StatefulWidget {
  const DetailLesson({super.key});

  @override
  State<DetailLesson> createState() => _DetailLessonState();
}

class _DetailLessonState extends State<DetailLesson> {
  List<String> topics = [
    "The Internet",
    "Artifical Intelligence (AI)",
    "Social Media",
    "Internet Privacy",
    "Live Streaming",
    "Coding",
    "Technology Transforming Healthcare",
    "Smart Home Technology",
    "Remote Work - A Dream Job?"
  ];
  int selectedItemIndex = 0;
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
              title: Text("Lessons",
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
          padding: EdgeInsets.only(bottom: 35, left: 10, right: 10, top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.grey, width: 0.5), // Màu nền của container
            borderRadius:
                BorderRadius.circular(2), // Độ bo tròn góc của container
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: FittedBox(
                    fit: BoxFit
                        .fill, // You can change the BoxFit property as needed

                    child: Image.asset(
                        "images/AvatarCourse.png")), // Replace with your image
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Life in the Internet Age",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Let's discuss how technology is changing the way we live",
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "List Topics",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Lesson(
                                      title: topics[index],
                                      url:
                                          "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileThe%20Internet.pdf")),
                            );
                            setState(() {
                              selectedItemIndex = index;
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.only(left: 20, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: selectedItemIndex == index
                                    ? Colors.grey.shade300
                                    : Colors.white,
                              ),
                              height: 40,
                              child: Text((index + 1).toString() +
                                  ".    " +
                                  topics[index])),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
