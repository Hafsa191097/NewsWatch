import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/model/error.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:news_watch/Models/article_screen.dart';
import 'package:news_watch/Widgets/image_widget.dart';

import '../Views/artical_main_screen.dart';

class BreakingNews extends StatelessWidget {
  final NewsAPI newsAPI = NewsAPI("e5ef803bf7b64de4b21da03a663492e7");
   BreakingNews({
    super.key,
    required this.articles,
  });

  final List<Articles> articles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text('More', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: FutureBuilder<List<Article>>(
              future: newsAPI.getTopHeadlines(country: "us"),
              builder: (BuildContext context, AsyncSnapshot<List<Article>> articless)  {

                return articless.connectionState == ConnectionState.done
              ? articless.hasData
                  ?  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: articless.data!.length,
                  itemBuilder: (context, index) {
                  String dateTimeString = articless.data![index].publishedAt!;
                  DateTime dateTime = DateTime.parse(dateTimeString);

                  String formattedTime = DateFormat.Hm().format(dateTime);
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ArticleScreen.route,
                            arguments: articless.data![index],
                          );
                        },
                        child: articless.data != null ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              ImageContainer(
                              width: MediaQuery.of(context).size.width * 0.5,
                              imageUrl: articless.data![index].urlToImage,
                            ) ,
                            const SizedBox(height: 10),
                            Text(
                              articless.data![index].title!,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold, height: 1.5),
                            ),
                            const SizedBox(height: 5),
                            Text(
                                '${formattedTime} Am',
                                style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 5),
                            Text('by ${articless.data![index].author ?? 'Unknown Writer'} ',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ) : const Center(child: Icon(Icons.error, color: Colors.redAccent,),),
                      ),
                    );
                  },
                ): _buildError(articless.error as ApiError)
              : _buildProgress();
              }
            ),
          ),
        ],
      ),
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


