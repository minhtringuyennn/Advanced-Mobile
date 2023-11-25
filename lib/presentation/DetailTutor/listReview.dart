import 'package:advanced_mobile/model/feedback-dto.dart';
import 'package:advanced_mobile/presentation/DetailTutor/review.dart';
import 'package:flutter/cupertino.dart';

import '../../model/rate-dto.dart';

class ListReview extends StatelessWidget {
  const ListReview(this.feedbacks, {super.key});
  final List<FeedbackDTO> feedbacks;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Others review",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              return Review(feedbacks[index]);

              // Add more customization here if needed
            },
          )
        ],
      ),
    );
  }
}
