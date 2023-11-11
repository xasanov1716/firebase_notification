part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}


class  NewsLoadingState extends NewsInitial{}


class  NewsSuccessState extends NewsInitial{}