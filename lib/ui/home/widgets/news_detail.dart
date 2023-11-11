import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/models/news_model.dart';

class SingleDetailScreen extends StatelessWidget {
  const SingleDetailScreen({super.key, required this.newsModel, required this.index});

  final NewsModel newsModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Hero(
                  tag: 'tag$index',
                  child: CachedNetworkImage(
                    imageUrl: newsModel.image,
                    width: 300,
                    height: 300,
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            const  SizedBox(height: 15,),
              Text(newsModel.title,style: const TextStyle(fontSize: 32),),
              const SizedBox(height: 15,),
              Text(newsModel.description,style: const TextStyle(fontSize: 18),),
              const SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}