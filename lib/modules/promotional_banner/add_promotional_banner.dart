// ignore_for_file: use_build_context_synchronously

import 'package:car_wash_dashboard/widgets/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker_web/image_picker_web.dart';

class AddPromotionalBanner extends StatefulWidget {
  const AddPromotionalBanner({Key? key}) : super(key: key);

  @override
  State<AddPromotionalBanner> createState() => _AddPromotionalBannerState();
}

class _AddPromotionalBannerState extends State<AddPromotionalBanner> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bannerController = TextEditingController();
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
      ProgressBar.show(context);
    }
  }

  Future uploadFile(mediaInfo, String fileName) async {
    try {
      final metadata = SettableMetadata(contentType: mimeType);
      Reference ref =
          FirebaseStorage.instance.ref().child("promotionalBanners/$fileName");

      await ref.putData(mediaInfo.data, metadata);
      _bannerController.text = await ref.getDownloadURL();
      ProgressBar.dismiss(context);
    } catch (e) {
      return;
    }
  }

  Future<void> deleteFile(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      _bannerController.text = "";
    } catch (e) {
      return;
    }
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
          Row(
            children: [
              const BackButton(),
              SizedBox(width: MediaQuery.of(context).size.width * 0.005),
              Text("Add Promotional Banner",
                  style: GoogleFonts.inter(
                      color: const Color(0xff333333),
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * 0.02),
                        border: Border.all(color: Colors.grey.shade400)),
                    padding: EdgeInsets.zero,
                    child: (fileSelected == false)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.015),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                        border: Border.all(
                                            color: Colors.grey.shade400))),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: const BorderSide(
                                                color: Colors.blue)),
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                            MediaQuery.of(context).size.width *
                                                0.03)),
                                    onPressed: () {
                                      imagePicker();
                                    },
                                    child: const Text('Pick Image')),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02)
                              ])
                        : Column(children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      deleteFile(_bannerController.text);

                                      setState(() {
                                        fileSelected = false;
                                      });
                                    },
                                    splashRadius:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                    icon: Icon(Icons.highlight_remove_sharp,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.025))),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.02),
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.memory(mediaInfo.data,
                                        semanticLabel: mediaInfo.fileName,
                                        fit: BoxFit.contain))),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.01),
                            Text(message.toString()),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.01),
                          ])),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: _bannerController,
                                  decoration: InputDecoration(
                                    labelText: 'Banner',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a banner';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    banner = value!;
                                  },
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Padding(
                                  padding: const EdgeInsets.only(left: 138.0),
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
                                                  .add({
                                                "banner":
                                                    _bannerController.text,
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text('Submit')))),
                            ]))),
              ])),
        ]),
      ),
    );
  }
}
