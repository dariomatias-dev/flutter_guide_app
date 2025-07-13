import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemsNotifier extends ValueNotifier<List<Widget>> {
  ItemsNotifier(
    super._value,
  );

  void add(
    Widget item,
  ) {
    value.add(item);

    notifyListeners();
  }

  void addAll(
    List<Widget> item,
  ) {
    value.addAll(item);

    notifyListeners();
  }
}

enum MessageStatus {
  send,
  receiver,
}

class MessageModel {
  const MessageModel({
    required this.text,
    required this.status,
    required this.sentDate,
  });

  final String text;
  final MessageStatus status;
  final DateTime sentDate;
}

final messages = <MessageModel>[
  MessageModel(
    text: 'Hello there!',
    status: MessageStatus.send,
    sentDate: DateTime(2024, 1, 1, 9, 0),
  ),
  MessageModel(
    text: 'Hi, how are you?',
    status: MessageStatus.receiver,
    sentDate: DateTime(2024, 1, 1, 9, 1),
  ),
  MessageModel(
    text: "I'm doing great, thanks!",
    status: MessageStatus.send,
    sentDate: DateTime(2024, 1, 2, 11, 16),
  ),
  MessageModel(
    text: "That's good to hear!",
    status: MessageStatus.receiver,
    sentDate: DateTime(2024, 1, 2, 11, 20),
  ),
  MessageModel(
    text: 'Did you finish the project we were working on?',
    status: MessageStatus.send,
    sentDate: DateTime(2024, 1, 2, 11, 23),
  ),
  MessageModel(
    text: 'Yes, I just sent you the final version. Check your email.',
    status: MessageStatus.receiver,
    sentDate: DateTime(2024, 1, 3, 6, 39),
  ),
  MessageModel(
    text: "Great! I'll take a look at it now.",
    status: MessageStatus.send,
    sentDate: DateTime(2024, 1, 3, 6, 41),
  ),
  MessageModel(
    text: 'Let me know if you have any feedback or need any changes.',
    status: MessageStatus.receiver,
    sentDate: DateTime(2024, 1, 3, 6, 49),
  ),
  MessageModel(
    text: 'Sure, will do. By the way, do you have any plans for the weekend?',
    status: MessageStatus.send,
    sentDate: DateTime(2024, 1, 3, 6, 52),
  ),
  MessageModel(
    text: 'Not yet. I was thinking about going hiking. What about you?',
    status: MessageStatus.receiver,
    sentDate: DateTime(2024, 1, 4, 8, 17),
  ),
  MessageModel(
    text: "That sounds fun! I might join you if that's okay.",
    status: MessageStatus.send,
    sentDate: DateTime(2024, 1, 4, 8, 22),
  ),
  MessageModel(
    text: "Of course! The more, the merrier. I'll send you the details.",
    status: MessageStatus.receiver,
    sentDate: DateTime(2024, 1, 4, 8, 29),
  ),
  MessageModel(
    text: 'Awesome! Looking forward to it.',
    status: MessageStatus.send,
    sentDate: DateTime(2024, 1, 5, 4, 1),
  ),
  MessageModel(
    text:
        "By the way, did you see the new movie that came out last week? It's getting great reviews.",
    status: MessageStatus.receiver,
    sentDate: DateTime(2024, 1, 5, 4, 7),
  ),
  MessageModel(
    text:
        "No, I haven't had the chance yet. Maybe we can watch it after the hike.",
    status: MessageStatus.send,
    sentDate: DateTime(2024, 1, 6, 20, 37),
  ),
  MessageModel(
    text: "Sounds like a plan! I'll book the tickets.",
    status: MessageStatus.receiver,
    sentDate: DateTime(2024, 1, 6, 20, 45),
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreenSample(),
    ),
  );
}

class ChatScreenSample extends StatelessWidget {
  const ChatScreenSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const ChatScreen();
                },
              ),
            );
          },
          child: const Text(
            'Show Chat Screen',
          ),
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollController = ScrollController();
  final _messageFocus = FocusNode();
  final _messageController = TextEditingController();

  final _items = ItemsNotifier([]);

  double get _maxWidth => MediaQuery.sizeOf(context).width * 0.8;

  SizedBox get _space => const SizedBox(
        height: 16.0,
      );

  void _addItem() {
    final text = _messageController.text.trim();
    final message = MessageModel(
      text: text,
      status: MessageStatus.send,
      sentDate: DateTime.now(),
    );

    final items = <Widget>[];

    if (_items.value.last is! SizedBox) {
      items.add(_space);
    }

    items.add(
      MessageWidget(
        isMessageSent: message.status == MessageStatus.send,
        maxWidth: _maxWidth,
        message: message,
      ),
    );

    _items.addAll(items);
  }

  void _generateItems() {
    final maxWidth = _maxWidth;

    final items = <Widget>[];
    final itemsLength = items.length;
    DateTime? currentDate;

    for (var i = 0; i < messages.length; i++) {
      final message = messages[i];
      final isMessageSent = message.status == MessageStatus.send;
      final sentDate = message.sentDate;

      if (!(currentDate?.year == sentDate.year &&
          currentDate?.month == sentDate.month &&
          currentDate?.day == sentDate.day)) {
        currentDate = sentDate;

        final dateFormat = DateFormat('MM/dd/yyyy');
        final date = dateFormat.format(currentDate);

        if (items.isNotEmpty) {
          items.removeLast();
        }

        items.add(
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(
                top: 24.0,
                bottom: 28.0,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 6.0,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 8.0,
                    spreadRadius: 8.0,
                    color: Colors.black.withAlpha(29),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
              child: Text(date),
            ),
          ),
        );
      }

      items.add(
        MessageWidget(
          isMessageSent: isMessageSent,
          maxWidth: maxWidth,
          message: message,
        ),
      );

      if (i + 1 != itemsLength) {
        items.add(_space);
      }
    }

    _items.value = items;
  }

  @override
  void didChangeDependencies() {
    _generateItems();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageFocus.dispose();
    _messageController.dispose();
    _items.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
          title: const Text('Chat'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _items,
                builder: (context, value, child) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      curve: Curves.linear,
                    );
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _items.value.length,
                    itemBuilder: (context, index) {
                      return value[index];
                    },
                  );
                },
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.onSecondary,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: SizedBox(
                height: 40.0,
                child: TextFormField(
                  focusNode: _messageFocus,
                  controller: _messageController,
                  autofocus: true,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade900,
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: BorderSide.none,
                    ),
                    isDense: true,
                  ),
                  onFieldSubmitted: (value) {
                    if (value.trim() != '') {
                      _addItem();

                      _messageController.clear();
                      _messageFocus.requestFocus();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.isMessageSent,
    required this.maxWidth,
    required this.message,
  });

  final bool isMessageSent;
  final double maxWidth;
  final MessageModel message;

  String get formatDate {
    final dateFormat = DateFormat('HH:mm');

    return dateFormat.format(
      message.sentDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMessageSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isMessageSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: isMessageSent
                    ? Colors.blue
                    : Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    isMessageSent ? 20.0 : 0.0,
                  ),
                  topRight: Radius.circular(
                    isMessageSent ? 0.0 : 20.0,
                  ),
                  bottomRight: const Radius.circular(20.0),
                  bottomLeft: const Radius.circular(20.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 8.0,
                    spreadRadius: 8.0,
                    color: Colors.black.withAlpha(29),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isMessageSent ? Colors.white : Colors.black,
                  fontSize: 14.0,
                  height: 1.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2.0),
          Padding(
            padding: EdgeInsets.only(
              right: isMessageSent ? 2.0 : 0.0,
              left: isMessageSent ? 0.0 : 2.0,
            ),
            child: Text(
              formatDate,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
