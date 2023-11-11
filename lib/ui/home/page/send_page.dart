import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/network/api_provider/api_provider.dart';
import 'package:texno_bozor/providers/news_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';



class SendMessage extends StatefulWidget {
  const SendMessage({Key? key}) : super(key: key);

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  ApiProvider apiProvider = ApiProvider();

  ImagePicker picker = ImagePicker();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  GlobalTextField(
                      hintText: 'Enter title',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.left,
                      controller: context.read<NewsProvider>().titleController),
                  const SizedBox(
                    height: 24,
                  ),
                  GlobalTextField(
                      hintText: 'Enter description',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.left,
                      controller: context.read<NewsProvider>().descriptionController),
                  const SizedBox(
                    height: 32,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          showBottomSheetDialog();
                        });
                      },
                      child: const Text('Select Image')),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CachedNetworkImage(
                      imageUrl: context.read<NewsProvider>().imageUrl,
                      placeholder: (context, url) => const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => const Center(child: Text('Imaeg Empty')),
                    ),
                  ),
                  TextButton(
                      onPressed: () {

                        if(context.read<NewsProvider>().descriptionController.text.isNotEmpty && context.read<NewsProvider>().titleController.text.isNotEmpty) {
                          setState(() {
                            Navigator.pop(context);
                          });
                          // apiProvider
                          //   ..createAlbum(
                          //       title: context
                          //           .read<NewsProvider>()
                          //           .titleController
                          //           .text,
                          //       description: context
                          //           .read<NewsProvider>()
                          //           .descriptionController
                          //           .text,
                          //       image: context
                          //           .read<NewsProvider>()
                          //           .imageUrl);
                          context
                              .read<NewsProvider>()
                              .titleController
                              .clear();
                          context
                              .read<NewsProvider>()
                              .descriptionController
                              .clear();
                          context
                              .read<NewsProvider>()
                              .imageUrl = '';
                        }else{
                          context.read<NewsProvider>().showMessage(context, 'ERROR');
                        }
                      },
                      child: const Text('Send'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }


  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      await Provider.of<NewsProvider>(context, listen: false)
          .uploadCategoryImage(context, xFile);
    }
  }
}
