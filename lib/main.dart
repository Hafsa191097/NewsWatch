import 'package:flutter/material.dart';

import 'Views/artical_main_screen.dart';
import 'Views/home_screen.dart';
import 'Views/profile.dart';
import 'Views/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsWatch',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        HomeScreen.route : (context) =>   HomeScreen(),
        SearchScreen.route : (context) =>  const SearchScreen(),
        ProfileScreen.route : (context) =>  const ProfileScreen(),
        ArticleScreen.route : (context) =>   ArticleScreen(),
      },
    );
  }
}

