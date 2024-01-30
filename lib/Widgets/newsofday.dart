import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:news_watch/Models/article_screen.dart';
import 'package:news_watch/Widgets/image_widget.dart';
import 'package:news_watch/Widgets/tags.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/model/error.dart';

class NewsOfTheDay extends StatelessWidget {
  final NewsAPI _newsAPI = NewsAPI("e5ef803bf7b64de4b21da03a663492e7");
  NewsOfTheDay({
    super.key,
    required this.article,
  });

  final Articles article;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: _newsAPI.getTopHeadlines(country: "us"),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        return snapshot.connectionState == ConnectionState.done
              ? snapshot.hasData
                  ? ImageContainer(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              imageUrl: snapshot.data!.last.urlToImage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTag(
                    backgroundColor: Colors.grey.withAlpha(150),
                    children: [
                      Text(
                        'News of the Day',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
              const SizedBox(height: 10),
              Text(
                snapshot.data!.first.description!,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold, height: 1.25, color: Colors.white),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Row(
                  children: [
                    Text(
                      'Learn More',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) : _buildError(snapshot.error as ApiError)
              : _buildProgress();
      }
    );
  }
}

  Widget _buildProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError(ApiError error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error.code ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 4),
            Text(error.message!, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
