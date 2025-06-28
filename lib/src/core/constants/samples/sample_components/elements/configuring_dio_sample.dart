import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const baseUrl = 'https://jsonplaceholder.typicode.com';

class DioClient {
  static final _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;

  Dio get client => dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
  }
}

enum ResourceType {
  users,
  comments,
  todos,
}

class UserModel {
  const UserModel({
    required this.name,
    required this.username,
    required this.email,
  });

  final String name;
  final String username;
  final String email;

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class CommentModel {
  const CommentModel({
    required this.name,
    required this.email,
    required this.body,
  });

  final String name;
  final String email;
  final String body;

  factory CommentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CommentModel(
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

class TodoModel {
  const TodoModel({
    required this.userId,
    required this.title,
    required this.completed,
  });

  final int userId;
  final String title;
  final bool completed;

  factory TodoModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TodoModel(
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConfiguringDioSample(),
    ),
  );
}

class ConfiguringDioSample extends StatefulWidget {
  const ConfiguringDioSample({super.key});

  @override
  State<ConfiguringDioSample> createState() => _ConfiguringDioSampleState();
}

class _ConfiguringDioSampleState extends State<ConfiguringDioSample> {
  final _resourceTypes = <ResourceType>[
    ResourceType.users,
    ResourceType.comments,
    ResourceType.todos,
  ];

  final _client = DioClient().client;

  ResourceType _resourceType = ResourceType.users;

  Widget getUserListTile(dynamic value) {
    final user = UserModel.fromJson(value);

    return ListTile(
      leading: const CircleAvatar(
        child: Icon(
          Icons.person_outline,
        ),
      ),
      title: Text(user.username),
      subtitle: Text(user.name),
    );
  }

  Widget getCommentListTile(dynamic value) {
    final comment = CommentModel.fromJson(value);

    return ListTile(
      title: Text(
        comment.name,
      ),
      subtitle: Text(
        comment.email,
      ),
    );
  }

  Widget getTodoListTile(dynamic value) {
    final todo = TodoModel.fromJson(value);

    return ListTile(
      title: Text(
        todo.title,
      ),
      subtitle: Text(
        todo.completed.toString(),
      ),
    );
  }

  Future<List<Widget>> _fetchData() async {
    try {
      String path = '/';
      Widget Function(
        dynamic data,
      ) getListTile;

      if (_resourceType == ResourceType.users) {
        path += 'users';
        getListTile = getUserListTile;
      } else if (_resourceType == ResourceType.comments) {
        path += 'posts/1/comments';
        getListTile = getCommentListTile;
      } else {
        path += 'todos';
        getListTile = getTodoListTile;
      }

      final response = await _client.get(path);

      final results = <Widget>[];

      final responseData = response.data as List;

      for (int i = 0; i < responseData.length; i++) {
        results.add(
          getListTile(
            responseData[i],
          ),
        );

        if (i == 19) break;
      }

      return results;
    } catch (err) {
      return <Widget>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _resourceType,
                  items: List.generate(_resourceTypes.length, (index) {
                    final resourceType = _resourceTypes[index];

                    return DropdownMenuItem(
                      value: resourceType,
                      child: Text(resourceType.name),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      _resourceType = value!;
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Center(
                    child: Text('Ocorreu um erro ao obter dados'),
                  );
                }

                final data = snapshot.data!;

                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return data[index];
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
