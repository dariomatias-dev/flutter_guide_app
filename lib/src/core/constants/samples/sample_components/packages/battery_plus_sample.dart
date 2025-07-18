import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:logger/logger.dart';

final _battery = Battery();

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BatteryPlusSample(),
    ),
  );
}

class BatteryPlusSample extends StatefulWidget {
  const BatteryPlusSample({super.key});

  @override
  State<BatteryPlusSample> createState() => _BatteryPlusSampleState();
}

class _BatteryPlusSampleState extends State<BatteryPlusSample> {
  final _logger = Logger();

  int? _batteryLevel;
  bool? _isInBatterySaveMode;
  BatteryState? _batteryState;

  Future<void> _getBatteryInfos() async {
    try {
      _batteryLevel = await _battery.batteryLevel;
      _isInBatterySaveMode = await _battery.isInBatterySaveMode;
    } catch (err, stackTrace) {
      _logger.e(
        'Error Log',
        error: err,
        stackTrace: stackTrace,
      );
    }
  }

  void _onBatteryStateChanged(
    BatteryState state,
  ) {
    if (mounted) {
      setState(() {
        _batteryState = state;
      });
    }
  }

  @override
  void initState() {
    _battery.onBatteryStateChanged.listen(_onBatteryStateChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: FutureBuilder(
          future: _getBatteryInfos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Error fetching data.',
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Battery Level: ${_batteryLevel!}%',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Device in battery saving mode: ${_isInBatterySaveMode! ? 'Yes' : 'No'}.',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Battery State: ${_batteryState?.name}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
