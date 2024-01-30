import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:news_watch/sources/api_error.dart';

import '../Models/article_screen.dart';
import '../Widgets/image_widget.dart';
import '../Widgets/tags.dart';

class ArticleScreen extends StatelessWidget {
  
   ArticleScreen({super.key});

  static const route = '/article';
  
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Article;
    return ImageContainer(
      width: double.infinity,
      imageUrl: article.urlToImage,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: ListView(
          children: [
            _NewsHeadline(article: article),
            _NewsBody(article: article)
          ],
        ),
      ),
    );
  }
}

class _NewsBody extends StatelessWidget {
  _NewsBody({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;
  final NewsAPI newsAPI = NewsAPI("e5ef803bf7b64de4b21da03a663492e7");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: FutureBuilder<List<Article>>(
        future: newsAPI.getTopHeadlines(country: "us"),
        builder:  (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? snapshot.hasData
                  ? Column(
            children: [
              Row(
                children: [
                  CustomTag(
                    backgroundColor: Colors.black,
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                          snapshot.data!.first.urlToImage!,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        snapshot.data!.first.author!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  CustomTag(
                    backgroundColor: Colors.grey.shade200,
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${snapshot.data!.first.publishedAt}h',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  CustomTag(
                    backgroundColor: Colors.grey.shade200,
                    children: const[
                       Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                       SizedBox(width: 10),
                      
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                snapshot.data!.first.title!,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                snapshot.data!.first.description!,
                style:
                    Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    return ImageContainer(
                      width: MediaQuery.of(context).size.width * 0.42,
                      imageUrl: snapshot.data![index].urlToImage,
                      margin: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                    );
                  })
            ],
          ) : _buildError(snapshot.error as ApiError)
              : _buildProgress();
        }
      ),
    );
  }
}

class _NewsHeadline extends StatelessWidget {
  final NewsAPI newsAPI = NewsAPI("e5ef803bf7b64de4b21da03a663492e7");
   _NewsHeadline({
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder<List<Article>>(
        future: newsAPI.getTopHeadlines(country: "us"),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> articless)  {
          return articless.connectionState == ConnectionState.done
              ? articless.hasData
                  ?  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              CustomTag(
                backgroundColor: Colors.grey.withAlpha(150),
                children: [
                  Text(
                    articless.data!.first.source.category!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                articless.data!.first.title!,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.25,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                articless.data!.first.source.name!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ],
          ) : _buildError(articless.error as ApiError)
              : _buildProgress();
        }
      ),
    );
  }
}


  Widget _buildProgress() {
    return const Center(child: CircularProgressIndicator());
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
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(error.message!, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
