import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TableCalendarSample(),
    ),
  );
}

/// Sample demonstrating `TableCalendarSample`.
class TableCalendarSample extends StatefulWidget {
  /// Creates a [TableCalendarSample].
  const TableCalendarSample({super.key});

  @override
  State<TableCalendarSample> createState() => _TableCalendarSampleState();
}

class _TableCalendarSampleState extends State<TableCalendarSample> {
  late final Map<DateTime, List<String>> _events = _buildEvents();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Map<DateTime, List<String>> _buildEvents() {
    DateTime normalize(DateTime day) {
      return DateTime.utc(day.year, day.month, day.day);
    }

    final today = DateTime.now();

    return {
      normalize(today): ['Team standup', 'Grocery shopping'],
      normalize(today.add(const Duration(days: 2))): ['Dentist appointment'],
      normalize(today.add(const Duration(days: 5))): [
        'Project deadline',
        'Gym',
      ],
    };
  }

  List<String> _eventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDay = _selectedDay ?? _focusedDay;

    return Scaffold(
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            clipBehavior: Clip.antiAlias,
            child: TableCalendar<String>(
              firstDay: DateTime.utc(2020),
              lastDay: DateTime.utc(2030),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              eventLoader: _eventsForDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontWeight: FontWeight.w600),
                weekendStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonShowsNext: false,
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
              ),
              calendarStyle: CalendarStyle(
                weekendTextStyle: const TextStyle(color: Colors.redAccent),
                outsideTextStyle: TextStyle(color: theme.disabledColor),
                todayDecoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
              ),
              onFormatChanged: (format) {
                setState(() => _calendarFormat = format);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _buildEventList(selectedDay),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList(DateTime selectedDay) {
    final events = _eventsForDay(selectedDay);

    if (events.isEmpty) {
      return const Center(
        child: Text(
          'No events for this day.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: events.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.event_outlined, color: Colors.white),
            ),
            title: Text(events[index]),
          ),
        );
      },
    );
  }
}
