import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class _Contact {
  const _Contact({required this.name, required this.subtitle});

  /// The [name].
  final String name;

  /// The [subtitle].
  final String subtitle;
}

const _contacts = [
  _Contact(name: 'Alice Monroe', subtitle: 'Product Manager'),
  _Contact(name: 'Aaron Blake', subtitle: 'iOS Developer'),
  _Contact(name: 'Bianca Reyes', subtitle: 'UX Designer'),
  _Contact(name: 'Bruno Costa', subtitle: 'Backend Engineer'),
  _Contact(name: 'Carla Nunes', subtitle: 'QA Engineer'),
  _Contact(name: 'Diego Alves', subtitle: 'DevOps'),
  _Contact(name: 'Elena Vargas', subtitle: 'Data Analyst'),
  _Contact(name: 'Ethan Wright', subtitle: 'Android Developer'),
  _Contact(name: 'Fiona Clarke', subtitle: 'Scrum Master'),
  _Contact(name: 'Gabriel Souza', subtitle: 'Tech Lead'),
  _Contact(name: 'Hannah Kim', subtitle: 'Marketing'),
  _Contact(name: 'Igor Petrov', subtitle: 'Support Engineer'),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroupedListSample(),
    ),
  );
}

/// Sample demonstrating `GroupedListSample`.
class GroupedListSample extends StatelessWidget {
  /// Creates a [GroupedListSample].
  const GroupedListSample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Contacts', style: theme.textTheme.titleLarge),
              ),
            ),
            Expanded(
              child: GroupedListView<_Contact, String>(
                elements: _contacts,
                groupBy: (contact) => contact.name[0],
                useStickyGroupSeparators: true,
                floatingHeader: true,
                padding: const EdgeInsets.only(bottom: 16),
                groupSeparatorBuilder: (letter) {
                  return Container(
                    width: double.infinity,
                    color: theme.colorScheme.surfaceContainerHighest,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: Text(
                      letter,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  );
                },
                itemBuilder: (context, contact) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(contact.name[0]),
                    ),
                    title: Text(contact.name),
                    subtitle: Text(contact.subtitle),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
