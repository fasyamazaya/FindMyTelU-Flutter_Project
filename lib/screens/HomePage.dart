import 'package:flutter/material.dart';
import 'package:project1/screens/bottomBar.dart';
import 'package:project1/screens/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    BottomNavigation();

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          /*leading: isLargeScreen
              ? null
              : IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),*/
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "FindMyTelU",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                ///if (isLargeScreen) Expanded(child: _navBarItems())
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: _ProfileIcon()),
            )
          ],
        ),
        ///drawer: isLargeScreen ? null : _drawer(),
        body: BottomNav(),
      ),

    );
  }

/*Widget _drawer() => Drawer(
    child: ListView(
      children: _menuItems
          .map((item) => ListTile(
        onTap: () {
          _scaffoldKey.currentState?.openEndDrawer();
          ///Navigator.push(context, MaterialPageRoute(builder:(context) => Login()));
        },
        title: Text(item),
      ))
          .toList(),
    ),
  );
*/
  /*Widget _navBarItems() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: _menuItems
        .map(
          (item) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 24.0, horizontal: 16),
          child: Text(
            item,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    )
        .toList(),
  );*/
}

final List<String> _menuItems = <String>[
  'Sign Out',
];

enum Menu { itemOne }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
        icon: const Icon(Icons.menu),
        offset: const Offset(0, 40),
        onSelected: (Menu item) {
          Navigator.push(context, MaterialPageRoute(builder:(context) => Login()));
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
          const PopupMenuItem<Menu>(
            value: Menu.itemOne,
            child: Text('Sign Out'),

            
          ),
        ]);
  }
}
