import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:texno_bozor/ui/home/widgets/news_detail.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/db/local_database.dart';
import '../../data/models/news_model.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsModel> news = [];
  List<NewsModel> news1 = [];

  _updateNews() async {
    news = await LocalDatabase.getAllNews();
    setState(() {});
  }

  @override
  void initState() {
    _updateNews();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILDING SLKDF');
    return Scaffold(
      appBar: AppBar(
        actions: [ 
          IconButton(onPressed: (){
            setState(() {
      _updateNews();
            });
          }, icon: Icon(Icons.refresh))
        ],
        title: Text(
          "Yangiliklar Faqat Bizda",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          news.isNotEmpty
              ? Expanded(
              child: ListView(
                children: [
                  ...List.generate(news.length, (index) {
                    NewsModel newsModel = news[index];
                    return ZoomTapAnimation(
                      onLongTap: (){
                        LocalDatabase.delete();
                      },
                      child: Container(
                        margin: EdgeInsets.all(18),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 10)
                            ]),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleDetailScreen(index: index,
                                        newsModel: newsModel)));
                          },
                          title: Text(newsModel.title),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                              tag: 'tag$index',
                              child: CachedNetworkImage(
                                imageUrl: newsModel.image,
                                width: 80,
                                height: 80,
                                placeholder: (context, url) =>
                                const CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ))
              : Center(child: CupertinoActivityIndicator())
        ],
      ),
    );
  }
}