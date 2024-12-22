import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonSample extends StatelessWidget {
  const LikeButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LikeButton(
          likeBuilder: (isLiked) {
            return Icon(
              Icons.thumb_up,
              color: isLiked ? Colors.blue : Colors.grey,
            );
          },
        ),
      ),
    );
  }
}
