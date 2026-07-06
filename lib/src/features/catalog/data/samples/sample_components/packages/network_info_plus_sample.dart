import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NetworkInfoPlusSample(),
    ),
  );
}

class NetworkInfoPlusSample extends StatefulWidget {
  const NetworkInfoPlusSample({super.key});

  @override
  State<NetworkInfoPlusSample> createState() => _NetworkInfoPlusSampleState();
}

class _NetworkInfoPlusSampleState extends State<NetworkInfoPlusSample> {
  final _info = NetworkInfo();

  String? _wifiName;
  String? _wifiBSSID;
  String? _wifiIP;
  String? _wifiIPv6;
  String? _wifiSubmask;
  String? _wifiBroadcast;
  String? _wifiGateway;

  Future<void> _fetchData() async {
    final result = await Future.wait([
      _info.getWifiName(),
      _info.getWifiBSSID(),
      _info.getWifiIP(),
      _info.getWifiIPv6(),
      _info.getWifiSubmask(),
      _info.getWifiBroadcast(),
      _info.getWifiGatewayIP(),
    ]);

    _wifiName = result[0];
    _wifiBSSID = result[1];
    _wifiIP = result[2];
    _wifiIPv6 = result[3];
    _wifiSubmask = result[4];
    _wifiBroadcast = result[5];
    _wifiGateway = result[6];

    setState(() {});
  }

  @override
  void initState() {
    _fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12.0,
          children: <Widget>[
            Text(
              'Wifi Name: $_wifiName',
            ),
            Text(
              'Wifi BSSID: $_wifiBSSID',
            ),
            Text(
              'Wifi IP: $_wifiIP',
            ),
            Text(
              'Wifi IPv6: $_wifiIPv6',
            ),
            Text(
              'Wifi Submask: $_wifiSubmask',
            ),
            Text(
              'Wifi Broadcast: $_wifiBroadcast',
            ),
            Text(
              'Wifi Gateway: $_wifiGateway',
            ),
          ],
        ),
      ),
    );
  }
}
