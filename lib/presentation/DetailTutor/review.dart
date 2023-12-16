import 'package:advanced_mobile/model/feedback-dto.dart';
import 'package:advanced_mobile/model/tutor/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/rate-dto.dart';

class Review extends StatelessWidget {
  const Review(this.rate, {super.key});
  final TutorFeedback rate;

  String formatTimeAgo(String apiTime) {
    DateTime currentTime = DateTime.now();
    DateTime apiDateTime = DateTime.parse(apiTime);
    Duration difference = currentTime.difference(apiDateTime);

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade300, // Màu của đường viền
                width: 0.5, // Độ rộng của đường viền
              ), // Đặt hình dạng là hình tròn
            ),
            child: ClipOval(
              child: Image.network(
                rate.firstInfo!.avatar!,
                width: 50,
                height: 50,
              ), // Thay thế bằng hình ảnh của bạn
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: rate.firstInfo!.name,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  children: <TextSpan>[
                    TextSpan(
                        text: "   " + formatTimeAgo(rate.updatedAt!),
                        style: TextStyle(color: Colors.grey.shade400)),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: generateWidgets(rate.rating!),
              ),
              SizedBox(
                height: 2,
              ),
              Text(rate.content!)
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> generateWidgets(int rating) {
    List<Widget> widgets = [];

    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        widgets.add(Icon(
          Icons.star,
          size: 16,
          color: Colors.yellow.shade500,
        ));
      } else {
        widgets.add(Icon(
          Icons.star,
          size: 16,
          color: Colors.grey.shade300,
        ));
        // Thêm widget Text vào danh sách
      }
    }

    return widgets;
  }
}
