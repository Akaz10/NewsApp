import 'package:flutter/material.dart';
import 'package:news_app/views/favorite_page.dart';
import 'package:news_app/views/home_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<MyNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outlined),
            label: 'Favorites',
          ),
        ],
      ),
      body: <Widget>[
        HomePage(),
        FavoritePage()
      ][currentPageIndex],
    );
  }
}