import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class _UserModel {
  const _UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String firstName;
  final String lastName;
  final String email;

  factory _UserModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return _UserModel(
      firstName: json['firstname'],
      lastName: json['lastname'],
      email: json['email'],
    );
  }
}

const _url = 'https://jsonplaceholder.org/users';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DioSample(),
    ),
  );
}

class DioSample extends StatefulWidget {
  const DioSample({super.key});

  @override
  State<DioSample> createState() => _DioSampleState();
}

class _DioSampleState extends State<DioSample> {
  final _dio = Dio();
  final _logger = Logger();

  Future<List<_UserModel>?> _getUsers() async {
    try {
      final response = await _dio.get(_url);

      final results = response.data as List;

      final users = <_UserModel>[];
      for (var result in results) {
        users.add(
          _UserModel.fromMap(result),
        );
      }

      return users;
    } catch (err, stackTrace) {
      _logger.e(
        'Error Log',
        error: err,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  @override
  void dispose() {
    _dio.close();
    _logger.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(
              child: Text(
                'Error fetching data.',
              ),
            );
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return ListTile(
                leading: const Icon(
                  Icons.person_outline_rounded,
                ),
                title: Text('${user.firstName} ${user.lastName}'),
                subtitle: Text(user.email),
              );
            },
          );
        },
      ),
    );
  }
}
