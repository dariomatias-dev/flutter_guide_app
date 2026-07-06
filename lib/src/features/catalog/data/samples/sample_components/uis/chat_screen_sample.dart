import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemsNotifier extends ValueNotifier<List<Widget>> {
  ItemsNotifier(super.value);

  void add(Widget item) {
    value.add(item);

    notifyListeners();
  }

  void addAll(List<Widget> items) {
    value.addAll(items);

    notifyListeners();
  }
}

enum MessageStatus {
  sent,
  received,
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
    text: 'Hello!',
    status: MessageStatus.sent,
    sentDate: DateTime(2024, 1, 1, 9, 0),
  ),
  MessageModel(
    text: 'Hi, how are you?',
    status: MessageStatus.received,
    sentDate: DateTime(2024, 1, 1, 9, 1),
  ),
  MessageModel(
    text: "I'm great, thanks!",
    status: MessageStatus.sent,
    sentDate: DateTime(2024, 1, 2, 11, 16),
  ),
  MessageModel(
    text: "Good to hear that!",
    status: MessageStatus.received,
    sentDate: DateTime(2024, 1, 2, 11, 20),
  ),
  MessageModel(
    text: 'Did you finish the project we were working on?',
    status: MessageStatus.sent,
    sentDate: DateTime(2024, 1, 2, 11, 23),
  ),
  MessageModel(
    text: 'Yes, I just sent you the final version. Check your email.',
    status: MessageStatus.received,
    sentDate: DateTime(2024, 1, 3, 6, 39),
  ),
  MessageModel(
    text: "Great! I'll take a look now.",
    status: MessageStatus.sent,
    sentDate: DateTime(2024, 1, 3, 6, 41),
  ),
  MessageModel(
    text: 'Let me know if you have any feedback or need any changes.',
    status: MessageStatus.received,
    sentDate: DateTime(2024, 1, 3, 6, 49),
  ),
  MessageModel(
    text: 'Sure, I will. By the way, do you have any plans for the weekend?',
    status: MessageStatus.sent,
    sentDate: DateTime(2024, 1, 3, 6, 52),
  ),
  MessageModel(
    text: 'Not yet. I was thinking of going for a hike. What about you?',
    status: MessageStatus.received,
    sentDate: DateTime(2024, 1, 4, 8, 17),
  ),
  MessageModel(
    text: "Sounds fun! Can I join you, if that's okay?",
    status: MessageStatus.sent,
    sentDate: DateTime(2024, 1, 4, 8, 22),
  ),
  MessageModel(
    text: "Of course! The more the merrier. I'll send you the details.",
    status: MessageStatus.received,
    sentDate: DateTime(2024, 1, 4, 8, 29),
  ),
  MessageModel(
    text: 'Awesome! I\'m looking forward to it.',
    status: MessageStatus.sent,
    sentDate: DateTime(2024, 1, 5, 4, 1),
  ),
  MessageModel(
    text:
        "By the way, have you seen the new movie that was released last week? It's getting great reviews.",
    status: MessageStatus.received,
    sentDate: DateTime(2024, 1, 5, 4, 7),
  ),
  MessageModel(
    text:
        "No, I haven't had the chance yet. Maybe we can watch it after the hike.",
    status: MessageStatus.sent,
    sentDate: DateTime(2024, 1, 6, 20, 37),
  ),
  MessageModel(
    text: "Deal! I'll book the tickets.",
    status: MessageStatus.received,
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
  final _itemsNotifier = ItemsNotifier([]);

  double get _maxWidth => MediaQuery.of(context).size.width * 0.7;

  SizedBox get _space => const SizedBox(height: 8.0);

  void _addItem(String text) {
    if (text.isEmpty) return;

    final message = MessageModel(
      text: text,
      status: MessageStatus.sent,
      sentDate: DateTime.now(),
    );

    final newItems = <Widget>[
      if (_itemsNotifier.value.isNotEmpty) _space,
      MessageWidget(
        isMessageSent: true,
        maxWidth: _maxWidth,
        message: message,
      ),
    ];

    _itemsNotifier.addAll(newItems);
    _autoScrollToEnd();
  }

  void _generateItems() {
    final items = <Widget>[];
    DateTime? currentDate;

    for (var i = 0; i < messages.length; i++) {
      final message = messages[i];
      final sentDate = message.sentDate;

      if (currentDate == null ||
          currentDate.year != sentDate.year ||
          currentDate.month != sentDate.month ||
          currentDate.day != sentDate.day) {
        currentDate = sentDate;
        items.add(
          DateSeparator(
            date: currentDate,
          ),
        );
      }

      items.add(
        MessageWidget(
          isMessageSent: message.status == MessageStatus.sent,
          maxWidth: _maxWidth,
          message: message,
        ),
      );

      if (i < messages.length - 1) {
        items.add(_space);
      }
    }

    _itemsNotifier.value = items;
  }

  void _generateItemsAndScroll() {
    _generateItems();

    _autoScrollToEnd(
      initial: true,
    );
  }

  void _autoScrollToEnd({
    bool initial = false,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent + (initial ? 40.0 : 0.0),
        );
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateItemsAndScroll();
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageFocus.dispose();
    _messageController.dispose();
    _itemsNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Chat'),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: ValueListenableBuilder<List<Widget>>(
                valueListenable: _itemsNotifier,
                builder: (context, value, child) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return value[index];
                    },
                  );
                },
              ),
            ),
          ),
          MessageInputField(
            controller: _messageController,
            focusNode: _messageFocus,
            onSubmitted: (text) {
              _addItem(text);

              _messageController.clear();
              _messageFocus.requestFocus();
            },
          ),
        ],
      ),
    );
  }
}

class DateSeparator extends StatelessWidget {
  const DateSeparator({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM dd, yyyy');

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          dateFormat.format(date),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 12.0,
          ),
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

  String get formattedTime {
    final dateFormat = DateFormat('HH:mm');

    return dateFormat.format(message.sentDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    final sentColor = theme.colorScheme.primary;
    final receivedColor =
        isLight ? theme.colorScheme.secondary : theme.colorScheme.surface;
    final sentTextColor = isLight ? Colors.white : Colors.black;
    final receivedTextColor = theme.colorScheme.onSurface;

    return Align(
      alignment: isMessageSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMessageSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: isMessageSent ? sentColor : receivedColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18.0),
                topRight: const Radius.circular(18.0),
                bottomLeft: Radius.circular(
                  isMessageSent ? 18.0 : 4.0,
                ),
                bottomRight: Radius.circular(
                  isMessageSent ? 4.0 : 18.0,
                ),
              ),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: isMessageSent ? sentTextColor : receivedTextColor,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: Text(
              formattedTime,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageInputField extends StatelessWidget {
  const MessageInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 4.0,
            color: Colors.black.withAlpha(13),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 42.0,
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    filled: true,
                    fillColor: theme.colorScheme.secondary,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onFieldSubmitted: onSubmitted,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              icon: Icon(
                Icons.send,
                color: theme.colorScheme.primary,
              ),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  onSubmitted(controller.text.trim());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
