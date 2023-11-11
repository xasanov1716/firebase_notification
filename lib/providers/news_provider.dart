
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/db/local_database.dart';
import '../data/models/news_model.dart';
import '../data/models/universal_data.dart';
import '../data/upload_service.dart';
import '../utils/ui_utils/loading_dialog.dart';

class NewsProvider with ChangeNotifier{

  NewsProvider._(){
    getNews();
  }


  String imageUrl = '';

  static final NewsProvider instance = NewsProvider._();


  List<NewsModel> news=[];


  getNews()async{
    news = await LocalDatabase.getAllNews();
    notifyListeners();
  }


  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> uploadCategoryImage(
      BuildContext context,
      XFile xFile,
      ) async {
    showLoading(context: context);
    UniversalReponse data = await FileUploader.imageUploader(xFile);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (data.error.isEmpty) {
      imageUrl = data.data as String;
      notifyListeners();
    } else {
      if (context.mounted) {
        showMessage(context, data.error);
      }
    }
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.deepPurpleAccent,
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
      ),
    );
    notifyListeners();
  }

  insertNews({required NewsModel newsModel})async{
    await LocalDatabase.insertNews(newsModel);
    await getNews();
    notifyListeners();
  }



}