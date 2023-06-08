import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Geolocator",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: new AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "name",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            Text(
              "status",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            )
          ],
        ),

        leading: new Padding(
          padding: const EdgeInsets.all(5.0),
          child: new CircleAvatar(
            backgroundImage: new NetworkImage("https://lms.telkomuniversity.ac.id/pluginfile.php/435818/user/icon/remui/f3?rev=22649657"),
          ),
        ),
        actions: <Widget>[new Icon(Icons.more_vert)],
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geolocator"),
      centerTitle: true,
      var position = await _determinePosition();
      bottom: PreferredSize(
          child: Text("Your position: "),
          print(position);
          ),
      )
    body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                var position = await _determinePosition();
                print(position);
              },
              child: const Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }*/
}
