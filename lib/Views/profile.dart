import 'package:flutter/material.dart';

import '../Widgets/navigationbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      bottomNavigationBar: const NavigationnBar(index: 2,)
    );
  }
}