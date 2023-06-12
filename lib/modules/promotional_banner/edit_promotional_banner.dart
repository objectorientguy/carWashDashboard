// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_dashboard/widgets/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker_web/image_picker_web.dart';

class EditPromotionalBanner extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>? promotionalBannerData;

  const EditPromotionalBanner({Key? key, this.promotionalBannerData})
      : super(key: key);

  @override
  State<EditPromotionalBanner> createState() => _EditPromotionalBannerState();
}

class _EditPromotionalBannerState extends State<EditPromotionalBanner> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bannerController = TextEditingController();
  final TextEditingController _changeBannerController = TextEditingController();
  String? banner;
  bool fileSelected = false;
  String? message;
  dynamic mediaInfo;
  String file = "";
  String? mimeType;

  Future imagePicker() async {
    mediaInfo = await ImagePickerWeb.getImageInfo;
    file = mediaInfo.fileName;
    if (mediaInfo != null) {
      setState(() {
        fileSelected = true;
      });
      message = file;
      mimeType = mime(p.basename(mediaInfo.fileName));

      uploadFile(mediaInfo, file);
    }
  }

  Future uploadFile(mediaInfo, String fileName) async {
    try {
      ProgressBar.show(context);

      final metadata = SettableMetadata(contentType: mimeType);
      Reference ref =
          FirebaseStorage.instance.ref().child("promotionalBanners/$fileName");

      await ref.putData(mediaInfo.data, metadata);
      _changeBannerController.text = await ref.getDownloadURL();
      ProgressBar.dismiss(context);
    } catch (e) {
      return;
    }
  }

  Future<void> deleteImage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      _changeBannerController.text = _bannerController.text;
    } catch (e) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _bannerController.text = widget.promotionalBannerData!["banner"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height * 0.05,
            right: MediaQuery.of(context).size.height * 0.05,
            top: MediaQuery.of(context).size.height * 0.05),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const BackButton(),
            SizedBox(width: MediaQuery.of(context).size.width * 0.005),
            Text("Edit Promotional Banner",
                style: GoogleFonts.inter(
                    color: const Color(0xff333333),
                    fontSize: 20,
                    fontWeight: FontWeight.w600))
          ]),
          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
          Expanded(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.02),
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            padding: EdgeInsets.zero,
                            child: (fileSelected == false)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.015),
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade400)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      _bannerController.text,
                                                  imageBuilder: (context, imageProvider) => Container(
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.275,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                          image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.contain))),
                                                  progressIndicatorBuilder: (context, url, downloadProgress) => const CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) => Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01), child: const Text("oops!"))),
                                            )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: const BorderSide(
                                                        color: Colors.blue)),
                                                minimumSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.28,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.03)),
                                            onPressed: () {
                                              imagePicker();
                                            },
                                            child: const Text('Change Image')),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02)
                                      ])
                                : Column(children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                fileSelected = false;
                                              });
                                            },
                                            splashRadius: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            icon: Icon(
                                                Icons.highlight_remove_sharp,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.025))),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02),
                                            border: Border.all(
                                                color: Colors.grey.shade400)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.memory(mediaInfo.data,
                                                semanticLabel:
                                                    mediaInfo.fileName,
                                                fit: BoxFit.contain))),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                    Text(message.toString()),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.01)
                                  ])),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Form(
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 350,
                                    child: TextFormField(
                                      controller:
                                          (_changeBannerController.text == "" ||
                                                  _changeBannerController
                                                          .text ==
                                                      "")
                                              ? _bannerController
                                              : _changeBannerController,
                                      decoration: InputDecoration(
                                        labelText: 'Banner Image',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a banner';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        banner = value;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(left: 138.0),
                                      child: SizedBox(
                                          width: 100,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _formKey.currentState!.save();
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          "promotionalBanners")
                                                      .doc(widget
                                                          .promotionalBannerData!
                                                          .id)
                                                      .update({
                                                    "banner": (_changeBannerController
                                                                    .text ==
                                                                "null" ||
                                                            _changeBannerController
                                                                    .text ==
                                                                "")
                                                        ? _bannerController.text
                                                        : _changeBannerController
                                                            .text,
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text('Submit')))),
                                ])),
                      ])))),
        ]),
      ),
    );
  }
}
