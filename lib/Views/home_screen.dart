import 'package:flutter/material.dart';
import 'package:news_watch/Models/article_screen.dart';
import '../Widgets/breaking_news.dart';
import '../Widgets/navigationbar.dart';
import '../Widgets/newsofday.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    Articles article = Articles.articles[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body:  ListView(padding: EdgeInsets.zero, children: [
        NewsOfTheDay(article: article),
        BreakingNews(articles: Articles.articles),
        ],
      ),
      bottomNavigationBar: const NavigationnBar(index: 0,)
    );
  }
}
      
    

