// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_dashboard/widgets/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:html' as html;

class AddTypeOfWash extends StatefulWidget {
  const AddTypeOfWash({Key? key}) : super(key: key);

  @override
  State<AddTypeOfWash> createState() => _AddTypeOfWashState();
}

class _AddTypeOfWashState extends State<AddTypeOfWash> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bgColor = TextEditingController();
  final TextEditingController _cost = TextEditingController();
  final TextEditingController _discountedCost = TextEditingController();
  final TextEditingController _imageIcon = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _timeDuration = TextEditingController();
  bool? _active;
  bool fileSelected = false;
  String? message;
  var mediaInfo;
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
      html.File mediaFile =
          html.File(mediaInfo.data, mediaInfo.fileName, {'type': mimeType});
      uploadFile(mediaInfo, file);
      ProgressBar.show(context);
    }
  }

  Future uploadFile(mediaInfo, String fileName) async {
    try {
      final String? extension = extensionFromMime(mimeType!);
      final metadata = SettableMetadata(contentType: mimeType);
      Reference ref =
          FirebaseStorage.instance.ref().child("typeOfWashesIcons/$fileName");

      await ref.putData(mediaInfo.data, metadata);
      _imageIcon.text = await ref.getDownloadURL();
      ProgressBar.dismiss(context);
    } catch (e) {
      print("File Upload Error $e");
    }
  }

  Future<void> deleteImage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      _imageIcon.text = "";
    } catch (e) {
      print("Error deleting db from cloud: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BackButton(),
                SizedBox(width: MediaQuery.of(context).size.width * 0.005),
                Text("Add Type Of Wash",
                    style: GoogleFonts.inter(
                        color: const Color(0xff333333),
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.03),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      height:
                                          MediaQuery.of(context).size.width *
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
                                            color: Colors.grey.shade400)),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                      child: const Text('Pick Image')),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.02)
                                ])
                          : Column(children: [
                              Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {
                                        deleteImage(_imageIcon.text);
                                        setState(() {
                                          fileSelected = false;
                                        });
                                      },
                                      splashRadius:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      icon: Icon(Icons.highlight_remove_sharp,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025))),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
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
                                      MediaQuery.of(context).size.width * 0.01)
                            ])),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.005),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                  labelText: 'Wash Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: _bgColor,
                                decoration: InputDecoration(
                                  labelText: 'Background Color',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a bgColorCost';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: _cost,
                                decoration: InputDecoration(
                                  labelText: 'Cost',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a cost';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: _discountedCost,
                                decoration: InputDecoration(
                                  labelText: 'Discounted Cost',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a discountedcost';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: _imageIcon,
                                decoration: InputDecoration(
                                  labelText: 'Image Icon',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an imageIcon';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: 350,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  labelText: 'Is Active',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                value: _active,
                                items: const [
                                  DropdownMenuItem(
                                    value: true,
                                    child: Text('True'),
                                  ),
                                  DropdownMenuItem(
                                    value: false,
                                    child: Text('False'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _active = value!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select an option';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: _timeDuration,
                                decoration: InputDecoration(
                                  labelText: 'Time Duration',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the timeDuration';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 138.0),
                              child: SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      DocumentReference ref =
                                          await FirebaseFirestore.instance
                                              .collection("typeOfWashes")
                                              .add({
                                        "bgColor": _bgColor.text,
                                        "cost": _cost.text,
                                        "discountedCost": _discountedCost.text,
                                        "id": "",
                                        "imageIcon": _imageIcon.text,
                                        "isActive": _active,
                                        "name": _name.text,
                                        "timeDuration": _timeDuration.text,
                                      });
                                      ref.update({"id": ref.id});
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text('Submit'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
