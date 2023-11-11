import 'package:texno_bozor/data/models/universal_data.dart';
import 'package:texno_bozor/data/network/api_provider/api_service.dart';

import '../api_provider/api_provider.dart';

class NewsRepository {
  final ApiService apiService;

  NewsRepository({required this.apiService});

  Future<UniversalReponse> postNotification(
      {required String title,
        required String description,
        required String image}) async =>
      apiService.notification(
          title: title, description: description, image: image);
}