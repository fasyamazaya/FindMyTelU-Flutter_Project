import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/database/places.dart';

/*  Future<http.Response> fetchPlaces(http.Client client) async {
    return client.get(Uri.parse('http://10.20.112.193:8000/api/places'));
  }*/

// A function that converts a response body into a List<Photo>.

Future<List<places>> fetchPlaces(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.0.108:8000/api/places'));
  print(response);
  // Use the compute function to run parsePhotos in a separate isolate.
  return parsePlaces(response.body);
}

List<places> parsePlaces(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print(parsed);
  return parsed.map<places>((json) => places.fromJson(json)).toList();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect Flutter with Laravel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Places'),
    );
  }
}

///List _data = [];

/*
  class Student {
  String baseUrl = "http://10.20.112.193:8000/api/places";

  Future<List> getAllStudent() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
*/


/*
  class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ///late Future<List> location;
  ///Student studentService = Student();

  @override
  void initState() {
    super.initState();
    ///location = studentService.getAllStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: FutureBuilder<List>(
            future: location,
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          snapshot.data![i]['name'],
                          style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: Text(
                          snapshot.data![i]['description'],
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No Data Found'),
                );
              }
            },
          ),
            ));
  }*/

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
      body: FutureBuilder<List<places>>(
        future: fetchPlaces(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PlacesList(location: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.location});

  final List<places> location;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: location.length,
      itemBuilder: (context, i) {
        return Card(
          child: ListTile(
            title: Text(
              location[i].name,
              style: TextStyle(fontSize: 30.0),
            ),
            subtitle: Text(
              location[i].description,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      },
    );
  }
}
