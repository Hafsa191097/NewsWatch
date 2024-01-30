import 'package:flutter/material.dart';
import 'package:news_watch/Views/home_screen.dart';
import 'package:news_watch/Views/profile.dart';
import 'package:news_watch/Views/search_screen.dart';

class NavigationnBar extends StatelessWidget {
  const NavigationnBar({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(100),
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(left: 50),
            child: IconButton(
              onPressed: () { 
                Navigator.pushNamed(context, HomeScreen.route);
              }, 
             icon: const Icon(Icons.home),
            ),
          ),
          label: 'Home',
        ),
    
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () { 
              Navigator.pushNamed(context, SearchScreen.route);
            }, 
           icon: const Icon(Icons.search),
          ),
          label: 'Discover',
        ),
    
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(right: 50),
            child: IconButton(
              
              onPressed: () { 
                Navigator.pushNamed(context, ProfileScreen.route);
              }, 
             icon: const Icon(Icons.person),
            ),
          ),
          label: 'Profile',
    
        ),
      
      ],
      
    );
  }
}