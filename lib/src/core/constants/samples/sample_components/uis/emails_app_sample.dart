import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:validatorless/validatorless.dart';

enum Direction {
  left,
  right,
}

const uuid = Uuid();

class EmailModel {
  EmailModel({
    required this.id,
    required this.sender,
    required this.to,
    required this.subject,
    required this.body,
    required this.date,
    required this.withStar,
  });

  final String id;
  final String sender;
  final String to;
  final String subject;
  final String body;
  final DateTime date;
  bool withStar;

  void toggleWithStar() {
    withStar = !withStar;
  }
}

final emails = <EmailModel>[
  EmailModel(
    id: uuid.v4(),
    sender: 'Rika',
    to: 'team@townplanning.com',
    subject: 'Plans for re-opening the town',
    body:
        'Hello team, We need to discuss the plans for re-opening the town. Please find attached the agenda for our upcoming meeting. Regards, Rika',
    date: DateTime(2024, 06, 01),
    withStar: false,
  ),
  EmailModel(
    id: uuid.v4(),
    sender: 'Julius',
    to: 'staff@eventmanagement.com',
    subject: 'Updates on upcoming event',
    body:
        'Hi everyone, Just a quick update on the event. We have confirmed the venue and finalized the guest list. More details to follow soon. Best, Julius',
    date: DateTime(2024, 5, 07),
    withStar: true,
  ),
  EmailModel(
    id: uuid.v4(),
    sender: 'Fred',
    to: 'team@corporate.com',
    subject: 'Meeting agenda for next week',
    body:
        'Dear team, Please find attached the agenda for our meeting next week. Kindly review it beforehand. Regards, Fred',
    date: DateTime(2024, 3, 24),
    withStar: false,
  ),
  EmailModel(
    id: uuid.v4(),
    sender: 'Rein',
    to: 'reports@salesdepartment.com',
    subject: 'Request for information',
    body:
        'Hello, I hope this email finds you well. Could you please provide me with the latest sales report? Thanks, Rein',
    date: DateTime(2024, 3, 12),
    withStar: false,
  ),
  EmailModel(
    id: uuid.v4(),
    sender: 'Toren',
    to: 'submissions@projectmanagement.com',
    subject: 'Reminder: Deadline approaching',
    body:
        'Hi there, Just a friendly reminder that the deadline for project submissions is approaching. Make sure to submit your work on time. Regards, Toren',
    date: DateTime(2024, 2, 19),
    withStar: true,
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmailsAppSample(),
    ),
  );
}

class EmailsAppSample extends StatelessWidget {
  const EmailsAppSample({super.key});

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
                  return const EmailsScreen();
                },
              ),
            );
          },
          child: const Text('Access Screen'),
        ),
      ),
    );
  }
}

class EmailsNotifier extends ValueNotifier<List<EmailModel>> {
  EmailsNotifier(super.value);

  void addEmail(
    EmailModel email,
  ) {
    value.insert(0, email);

    notifyListeners();
  }

  void setEmails(
    List<EmailModel> emails,
  ) {
    value = emails;

    notifyListeners();
  }

  void updateEmail() {
    notifyListeners();
  }
}

enum Screen {
  main,
  withStar,
}

class EmailsScreen extends StatefulWidget {
  const EmailsScreen({super.key});

  @override
  State<EmailsScreen> createState() => _EmailsScreenState();
}

class _EmailsScreenState extends State<EmailsScreen> {
  final _emailsNotifier = EmailsNotifier([]);

  Screen screen = Screen.main;

  late bool _isLigth;
  late List<EmailModel> _screenEmails;

  void _showEmails() {
    screen = Screen.main;

    _setScreenEmails(emails);
  }

  void _showStarredEmails() {
    screen = Screen.withStar;

    final starredEmails = <EmailModel>[];
    for (var email in _screenEmails) {
      if (email.withStar) {
        starredEmails.add(email);
      }
    }

    _setScreenEmails(starredEmails);
  }

  void _removeEmail(
    String emailId,
  ) {
    emails.removeWhere((email) {
      return email.id == emailId;
    });

    _screenEmails.removeWhere((email) {
      return email.id == emailId;
    });
    _emailsNotifier.setEmails(
      _screenEmails,
    );
  }

  void _setScreenEmails(
    List<EmailModel> value,
  ) {
    _screenEmails = value;
    _emailsNotifier.setEmails(value);
  }

  void _searchEmails(
    String query,
  ) {
    if (query.trim() == '') {
      _emailsNotifier.setEmails(
        _screenEmails,
      );

      return;
    }

    query = query.trim().toLowerCase();

    final results = <EmailModel>[];

    for (var email in _screenEmails) {
      if (email.sender.toLowerCase().contains(query) ||
          email.subject.toLowerCase().contains(query) ||
          email.body.toLowerCase().contains(query)) {
        results.add(email);
      }
    }

    _emailsNotifier.setEmails(results);
  }

  @override
  void initState() {
    _screenEmails = emails;
    _emailsNotifier.setEmails(
      _screenEmails,
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _isLigth = Theme.of(context).brightness == Brightness.light;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
      child: Scaffold(
        drawer: EmailsScreenDrawerWidget(
          showEmails: _showEmails,
          showStarredEmails: _showStarredEmails,
          setScreenEmails: _setScreenEmails,
        ),
        appBar: EmailsScreenAppBarWidget(
          isLigth: _isLigth,
          searchEmails: _searchEmails,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: ValueListenableBuilder(
            valueListenable: _emailsNotifier,
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return EmailWidget(
                    email: value[index],
                    removeEmail: _removeEmail,
                    updateScreen:
                        screen == Screen.withStar ? _showStarredEmails : () {},
                    emailsNotifier: _emailsNotifier,
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: ComposeEmailFloatingActionButtonWidget(
          isLigth: _isLigth,
          emailsNotifier: _emailsNotifier,
          showEmails: _showEmails,
        ),
      ),
    );
  }
}

class EmailsScreenDrawerWidget extends StatelessWidget {
  const EmailsScreenDrawerWidget({
    super.key,
    required this.showEmails,
    required this.showStarredEmails,
    required this.setScreenEmails,
  });

  final VoidCallback showEmails;
  final VoidCallback showStarredEmails;
  final void Function(
    List<EmailModel> value,
  ) setScreenEmails;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 32.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'User Name',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'emailexample@gmail.com',
                        style: TextStyle(
                          fontSize: 12.0,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            const Divider(
              height: 12.0,
            ),
            ListTile(
              onTap: () {
                showEmails();

                Navigator.pop(context);
              },
              leading: const Icon(
                Icons.inbox,
                size: 20.0,
              ),
              title: const Text(
                'Main',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                showStarredEmails();

                Navigator.pop(context);
              },
              leading: const Icon(
                Icons.star_outline,
                size: 20.0,
              ),
              title: const Text(
                'With Star',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Back',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}

class EmailsScreenAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const EmailsScreenAppBarWidget({
    super.key,
    required this.isLigth,
    required this.searchEmails,
  });

  final bool isLigth;
  final void Function(
    String query,
  ) searchEmails;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<EmailsScreenAppBarWidget> createState() =>
      _EmailsScreenAppBarWidgetState();
}

class _EmailsScreenAppBarWidgetState extends State<EmailsScreenAppBarWidget> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        height: 40.0,
        child: TextFormField(
          controller: _searchController,
          focusNode: _searchFocus,
          onEditingComplete: () {
            widget.searchEmails(
              _searchController.text,
            );
          },
          decoration: InputDecoration(
            prefixIcon: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                Icons.menu,
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.onSurface.withAlpha(31),
            contentPadding: const EdgeInsets.all(12.0),
            isDense: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(24.0),
              ),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class ComposeEmailFloatingActionButtonWidget extends StatefulWidget {
  const ComposeEmailFloatingActionButtonWidget({
    super.key,
    required this.isLigth,
    required this.emailsNotifier,
    required this.showEmails,
  });

  final bool isLigth;
  final EmailsNotifier emailsNotifier;
  final VoidCallback showEmails;

  @override
  State<ComposeEmailFloatingActionButtonWidget> createState() =>
      _ComposeEmailFloatingActionButtonWidgetState();
}

class _ComposeEmailFloatingActionButtonWidgetState
    extends State<ComposeEmailFloatingActionButtonWidget> {
  TextStyle get _defaultTitleFieldTextStyle => TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      );

  EdgeInsets get _defaultPadding => const EdgeInsets.symmetric(
        horizontal: 12.0,
      );

  InputDecoration _defaultInputDecoration({
    String? hinText,
  }) {
    return InputDecoration(
      contentPadding: _defaultPadding,
      border: InputBorder.none,
      isDense: true,
      hintText: hinText,
      hintStyle: _defaultTitleFieldTextStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (context) {
            return CreateEmailWidget(
              titleFieldTextStyle: _defaultTitleFieldTextStyle,
              inputDecoration: _defaultInputDecoration,
              padding: _defaultPadding,
              emailsNotifier: widget.emailsNotifier,
              showEmails: widget.showEmails,
            );
          },
        );
      },
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      icon: Icon(
        Icons.edit_outlined,
        color: Theme.of(context).colorScheme.onPrimary,
        size: 20.0,
      ),
      label: Text(
        'Compose',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class CreateEmailWidget extends StatefulWidget {
  const CreateEmailWidget({
    super.key,
    required this.titleFieldTextStyle,
    required this.inputDecoration,
    required this.padding,
    required this.emailsNotifier,
    required this.showEmails,
  });

  final TextStyle titleFieldTextStyle;
  final InputDecoration Function({
    String? hinText,
  }) inputDecoration;
  final EdgeInsets padding;
  final EmailsNotifier emailsNotifier;
  final VoidCallback showEmails;

  @override
  State<CreateEmailWidget> createState() => _CreateEmailWidgetState();
}

class _CreateEmailWidgetState extends State<CreateEmailWidget> {
  final _formKey = GlobalKey<FormState>();

  final _senderController = TextEditingController();
  final _toController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = EmailModel(
        id: uuid.v4(),
        sender: _senderController.text,
        to: _toController.text,
        subject: _subjectController.text,
        body: _bodyController.text,
        date: DateTime.now(),
        withStar: false,
      );

      emails.insert(0, email);
      widget.emailsNotifier.setEmails(emails);
      Navigator.pop(context);
      widget.showEmails();

      final snackBar = SnackBar(
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
        content: const Text('Email sent'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _senderController.dispose();
    _toController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: widget.padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      const Text(
                        'Compose an Email',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _submitForm,
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.send_outlined,
                          size: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CreateEmailTextFieldWidget(
                      controller: _senderController,
                      autoFocus: true,
                      titleFieldTextStyle: widget.titleFieldTextStyle,
                      inputDecoration: widget.inputDecoration(),
                      text: 'De',
                      validator: Validatorless.multiple([
                        Validatorless.required('Required field'),
                        Validatorless.min(10, 'Minimum 10 characters'),
                        Validatorless.max(30, 'Maximum 30 characters'),
                      ]),
                    ),
                    const CreateEmailDividirWidget(),
                    CreateEmailTextFieldWidget(
                      controller: _toController,
                      titleFieldTextStyle: widget.titleFieldTextStyle,
                      inputDecoration: widget.inputDecoration(),
                      text: 'Para',
                      validator: Validatorless.multiple([
                        Validatorless.required('Required field'),
                        Validatorless.min(10, 'Minimum 10 characters'),
                        Validatorless.max(30, 'Maximum 30 characters'),
                      ]),
                    ),
                    const CreateEmailDividirWidget(),
                    TextFormField(
                      controller: _subjectController,
                      decoration: widget.inputDecoration(
                        hinText: 'Subject',
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Required field'),
                        Validatorless.min(10, 'Minimum 10 characters'),
                        Validatorless.max(50, 'Maximum 50 characters'),
                      ]),
                    ),
                    const CreateEmailDividirWidget(),
                    Expanded(
                      child: TextFormField(
                        controller: _bodyController,
                        maxLines: null,
                        decoration: widget.inputDecoration(
                          hinText: 'Write Email',
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('Required field'),
                          Validatorless.min(10, 'Minimum 10 characters'),
                          Validatorless.max(200, 'Maximum 200 characters'),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateEmailTextFieldWidget extends StatelessWidget {
  const CreateEmailTextFieldWidget({
    super.key,
    required this.controller,
    this.autoFocus = false,
    required this.titleFieldTextStyle,
    required this.inputDecoration,
    required this.text,
    required this.validator,
  });

  final TextEditingController controller;
  final bool autoFocus;
  final TextStyle titleFieldTextStyle;
  final InputDecoration inputDecoration;
  final String text;
  final String? Function(
    String? value,
  )? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: titleFieldTextStyle,
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              autofocus: autoFocus,
              decoration: inputDecoration,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}

class CreateEmailDividirWidget extends StatelessWidget {
  const CreateEmailDividirWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.0,
      ),
      child: Divider(),
    );
  }
}

final months = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

class EmailWidget extends StatefulWidget {
  const EmailWidget({
    super.key,
    required this.email,
    required this.removeEmail,
    required this.updateScreen,
    required this.emailsNotifier,
  });

  final EmailModel email;
  final void Function(
    String emailId,
  ) removeEmail;
  final VoidCallback updateScreen;
  final EmailsNotifier emailsNotifier;

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  late String date;

  void _navigateToEmailScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EmailScreen(
            email: widget.email,
            emailsNotifier: widget.emailsNotifier,
            removeEmail: widget.removeEmail,
          );
        },
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ModalBottomSheetWidget(
          emailId: widget.email.id,
          removeEmail: widget.removeEmail,
        );
      },
    );
  }

  @override
  void initState() {
    final emailDate = widget.email.date;

    final elapsedTime = DateTime.now().difference(
      emailDate,
    );

    date = elapsedTime.inDays == 0
        ? '${emailDate.hour}:${emailDate.minute}'
        : '${months[emailDate.month - 1]} ${emailDate.day}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToEmailScreen,
      onLongPress: _showModalBottomSheet,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 32.0,
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.email.sender,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        date,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.email.subject,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.email.body,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withAlpha(128),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      SaveEmailButtonWidget(
                        email: widget.email,
                        updateScreen: widget.updateScreen,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SaveEmailButtonWidget extends StatefulWidget {
  const SaveEmailButtonWidget({
    super.key,
    required this.email,
    required this.updateScreen,
  });

  final EmailModel email;
  final VoidCallback updateScreen;

  @override
  State<SaveEmailButtonWidget> createState() => _SaveEmailButtonWidgetState();
}

class _SaveEmailButtonWidgetState extends State<SaveEmailButtonWidget> {
  late bool _isStarred;

  void _setIsStarred() {
    _isStarred = widget.email.withStar;
  }

  @override
  void didUpdateWidget(covariant SaveEmailButtonWidget oldWidget) {
    _setIsStarred();

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _setIsStarred();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _isStarred = !_isStarred;

        widget.email.toggleWithStar();
        widget.updateScreen();

        setState(() {});
      },
      child: Icon(
        _isStarred ? Icons.star : Icons.star_border,
        size: 20.0,
        color: _isStarred
            ? Colors.yellow.shade600
            : Theme.of(context).colorScheme.secondary.withAlpha(128),
      ),
    );
  }
}

class ModalBottomSheetWidget extends StatefulWidget {
  const ModalBottomSheetWidget({
    super.key,
    required this.emailId,
    required this.removeEmail,
  });

  final String emailId;
  final void Function(
    String emailId,
  ) removeEmail;

  @override
  State<ModalBottomSheetWidget> createState() => _ModalBottomSheetWidgetState();
}

class _ModalBottomSheetWidgetState extends State<ModalBottomSheetWidget> {
  void _removeEmail() {
    widget.removeEmail(
      widget.emailId,
    );

    Navigator.pop(context);
  }

  void _action() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        right: 12.0,
        bottom: 12.0,
        left: 12.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 4.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            height: 86.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ModalBottomSheetWidgetActionWidget(
                  action: _action,
                  icon: Icons.share_outlined,
                  text: 'Share',
                ),
                const SizedBox(width: 8.0),
                ModalBottomSheetWidgetActionWidget(
                  action: _action,
                  icon: Icons.add,
                  text: 'Add to',
                ),
                const SizedBox(width: 8.0),
                ModalBottomSheetWidgetActionWidget(
                  action: _removeEmail,
                  icon: Icons.delete_outline,
                  text: 'Trash',
                ),
                const SizedBox(width: 8.0),
                ModalBottomSheetWidgetActionWidget(
                  action: _action,
                  icon: Icons.archive_outlined,
                  text: 'Move to archive',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ModalBottomSheetWidgetActionWidget extends StatelessWidget {
  const ModalBottomSheetWidgetActionWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.action,
  });

  final IconData icon;
  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: action,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              Icon(
                icon,
                size: 24.0,
              ),
              const SizedBox(height: 8.0),
              Text(
                text,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailScreen extends StatefulWidget {
  const EmailScreen({
    super.key,
    required this.email,
    required this.emailsNotifier,
    required this.removeEmail,
  });

  final EmailModel email;
  final EmailsNotifier emailsNotifier;
  final void Function(
    String emailId,
  ) removeEmail;

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _isStarredNotifier = ValueNotifier(false);

  void _deleteEmail() {
    widget.removeEmail(
      widget.email.id,
    );

    Navigator.pop(context);
  }

  void _starEmail() {
    _isStarredNotifier.value = !_isStarredNotifier.value;

    widget.email.toggleWithStar();
    widget.emailsNotifier.updateEmail();
  }

  @override
  void initState() {
    _isStarredNotifier.value = widget.email.withStar;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).brightness == Brightness.light
          ? ThemeData.light()
          : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: _deleteEmail,
              icon: const Icon(
                Icons.delete_outline,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _isStarredNotifier,
              builder: (context, value, child) {
                return IconButton(
                  onPressed: _starEmail,
                  icon: Icon(
                    value ? Icons.star : Icons.star_border,
                    color: value ? Colors.yellow.shade600 : null,
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.archive_outlined,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.email.subject,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.email.body,
              ),
              const SizedBox(height: 32.0),
              const SizedBox(
                height: 76.0,
                child: Row(
                  children: <Widget>[
                    EmailScreenActionWidget(
                      icon: Icons.keyboard_arrow_left_rounded,
                      title: 'Responder',
                    ),
                    SizedBox(width: 6.0),
                    EmailScreenActionWidget(
                      icon: Icons.keyboard_double_arrow_left_rounded,
                      title: 'Responder a todos',
                    ),
                    SizedBox(width: 6.0),
                    EmailScreenActionWidget(
                      icon: Icons.keyboard_arrow_right_rounded,
                      title: 'Encaminhar',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmailScreenActionWidget extends StatelessWidget {
  const EmailScreenActionWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
