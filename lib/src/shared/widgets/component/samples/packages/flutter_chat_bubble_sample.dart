import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class FlutterChatBubbleSample extends StatelessWidget {
  const FlutterChatBubbleSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ChatBubble(
                clipper: ChatBubbleClipper9(
                  type: BubbleType.sendBubble,
                ),
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ChatBubble(
                clipper: ChatBubbleClipper9(
                  type: BubbleType.receiverBubble,
                ),
                backGroundColor: Colors.grey.shade300,
                child: const Text(
                  'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
