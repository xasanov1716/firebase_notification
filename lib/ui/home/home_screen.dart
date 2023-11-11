import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/ui/home/page/send_page.dart';
import 'package:texno_bozor/ui/home/widgets/news_detail.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


import '../../data/db/local_database.dart';
import '../../data/models/news_model.dart';
import '../../data/storage/storage_repo.dart';
import '../../providers/news_provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  bool isSubs = StorageRepository.getBool("subs");
  checking()async{
    isSubs? await FirebaseMessaging.instance.subscribeToTopic("news") : await FirebaseMessaging.instance.unsubscribeFromTopic("news")  ;
  }


  @override
  Widget build(BuildContext context) {
    print('BUILDING SLKDF');
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: CupertinoSwitch(
            onChanged: (value) {
              isSubs = !isSubs;
              StorageRepository.putBool("subs", isSubs);
              setState(() {
                checking();
              });
            },
            value: isSubs,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
              LocalDatabase.delete();
              context.read<NewsProvider>().getNews();

          }, icon: Icon(Icons.delete)),
          IconButton(onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context)=>SendMessage()));
          }, icon: Icon(Icons.add)),
        ],
        title: Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10),
          child: Lottie.asset('assets/lottie/news.json',width: 70, height: 70),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          context.watch<NewsProvider>().news.isNotEmpty
              ? Expanded(
              child: ListView(
                children: [
                  ...List.generate(context.watch<NewsProvider>().news.length, (index) {
                    NewsModel newsModel = context.watch<NewsProvider>().news[index];
                    return ZoomTapAnimation(
                      onLongTap: (){
                        LocalDatabase.delete();
                      },
                      child: Container(
                        margin: EdgeInsets.all(18),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
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
                          title: Text(newsModel.description),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
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
              : Center(child: Lottie.asset('assets/lottie/loading.json'))
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        context.read<NewsProvider>().getNews();
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState suspending');
        break;
      default:
    }
  }

}