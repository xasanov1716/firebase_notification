import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:texno_bozor/data/models/universal_data.dart';

import '../../data/network/respositoriy/news_repo.dart';
import '../../data/upload_service.dart';
import '../../utils/ui_utils/error_message_dialog.dart';
import '../../utils/ui_utils/loading_dialog.dart';
import 'notification_state.dart';


class PostNotificationCubit extends Cubit<NotificationState> {
  PostNotificationCubit({required this.newsRepository})
      : super(NotificationInitial());

  final NewsRepository newsRepository;
  bool isLoading = false;
  String imageUrl = "";

  Future<void> postNotification(
      {required String title,
        required String description}) async {
    isLoading = true;
    UniversalReponse universalData = await newsRepository.postNotification(
        title: title, description: description, image: imageUrl);
    isLoading=false;
    if (universalData.error.isEmpty) {
      imageUrl="";
      emit(NotificationSuccessState());
    } else {
      emit(NotificationErrorState(errorText: universalData.error));
    }
  }

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
      emit(NotificationImageUploadState());
    } else {
      if (context.mounted) {
        showErrorMessage(context: context,message: data.error);
      }
    }
  }
}