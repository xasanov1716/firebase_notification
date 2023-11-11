import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:texno_bozor/data/models/news_model.dart';

import '../../data/db/local_database.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit._() : super(NewsInitial()){getNews();}


  static final NewsCubit instance = NewsCubit._();
  List<NewsModel> news=[];
  bool isLoading=false;


  getNews()async{
    news = await LocalDatabase.getAllNews();
    debugPrint("GET ALL");
    emit(NewsInitial());
  }

  // deleteNews({required int id})async{
  //   emit(NewsLoadingState());
  //   await LocalDatabase.delete(id);
  //   await getNews();
  //   debugPrint("DELETE");
  //   emit(NewsSuccessState());
  // }
  //
  // deleteAllNews()async{
  //   emit(NewsLoadingState());
  //   await LocalDatabase.delete();
  //   getNews();
  //   debugPrint("DELETE ALL");
  //   emit(NewsSuccessState());
  //
  // }

  insertNews({required NewsModel newsModel})async{
    emit(NewsLoadingState());
    await LocalDatabase.insertNews(newsModel);
    debugPrint("INSERTTTT");
    await getNews();
    emit(NewsSuccessState());
  }
}