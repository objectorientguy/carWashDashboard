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

class EditTypeOfWash extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>? typeOfWashData;

  const EditTypeOfWash({Key? key, this.typeOfWashData}) : super(key: key);

  @override
  State<EditTypeOfWash> createState() => _EditTypeOfWashState();
}

class _EditTypeOfWashState extends State<EditTypeOfWash> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bgColor = TextEditingController();
  final TextEditingController _cost = TextEditingController();
  final TextEditingController _discountedCost = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _imageIcon = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _timeDuration = TextEditingController();
  final TextEditingController _changeImageIcon = TextEditingController();
  bool? _active;
  bool fileSelected = false;
  String? message;
  dynamic mediaInfo;
  String file = "";
  String? mimeType;

  @override
  void initState() {
    super.initState();
    _bgColor.text = widget.typeOfWashData!["bgColor"].toString();
    _cost.text = widget.typeOfWashData!["cost"].toString();
    _discountedCost.text = widget.typeOfWashData!["discountedCost"].toString();
    _imageIcon.text = widget.typeOfWashData!["imageIcon"].toString();
    _name.text = widget.typeOfWashData!["name"].toString();
    _timeDuration.text = widget.typeOfWashData!["timeDuration"].toString();
    _active = widget.typeOfWashData!["isActive"];
    _id.text = widget.typeOfWashData!["id"].toString();
  }

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
          FirebaseStorage.instance.ref().child("typeOfWashesIcons/$fileName");

      await ref.putData(mediaInfo.data, metadata);
      _changeImageIcon.text = await ref.getDownloadURL();
      ProgressBar.dismiss(context);
    } catch (e) {
      return;
    }
  }

  Future<void> deleteImage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      _changeImageIcon.text = _imageIcon.text;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const BackButton(),
                SizedBox(width: MediaQuery.of(context).size.width * 0.005),
                Text("Edit Type Of Wash",
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
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: _imageIcon.text,
                                              imageBuilder: (context, imageProvider) => Container(
                                                  height:
                                                      MediaQuery.of(context).size.height * 0.35,
                                                  width: MediaQuery.of(context).size.width * 0.35,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.02), image: DecorationImage(image: imageProvider, fit: BoxFit.contain))),
                                              progressIndicatorBuilder: (context, url, downloadProgress) => const CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01), child: const Center(child: Text("oops!")))))),
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
                                      child: const Text('Change Image')),
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
                                        deleteImage(_changeImageIcon.text);
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
                                      MediaQuery.of(context).size.width * 0.01),
                            ])),
                  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      0.005),
                              SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      controller: _name,
                                      decoration: InputDecoration(
                                          labelText: 'Wash Name',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a name';
                                        }
                                        return null;
                                      })),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      controller: _bgColor,
                                      decoration: InputDecoration(
                                          labelText: 'Background Color',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a background Color';
                                        }
                                        return null;
                                      })),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      controller: _cost,
                                      decoration: InputDecoration(
                                          labelText: 'Cost',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a cost';
                                        }
                                        return null;
                                      })),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      controller: _discountedCost,
                                      decoration: InputDecoration(
                                          labelText: 'Discounted Cost',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a discounted cost';
                                        }
                                        return null;
                                      })),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      controller: _id,
                                      decoration: InputDecoration(
                                          labelText: 'Wash Id',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a id';
                                        }
                                        return null;
                                      })),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      controller: (_changeImageIcon.text ==
                                                  "" ||
                                              _changeImageIcon.text == "null")
                                          ? _imageIcon
                                          : _changeImageIcon,
                                      decoration: InputDecoration(
                                          labelText: 'Image Icon',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter an imageIcon';
                                        }
                                        return null;
                                      })),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                  width: 350,
                                  child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Is Active',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      value: _active,
                                      items: const [
                                        DropdownMenuItem(
                                            value: true, child: Text('True')),
                                        DropdownMenuItem(
                                            value: false, child: Text('False'))
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
                                      })),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      controller: _timeDuration,
                                      decoration: InputDecoration(
                                          labelText: 'Time Duration',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          suffix: const Text('min')),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the timeDuration';
                                        }
                                        return null;
                                      })),
                              const SizedBox(height: 16.0),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 138.0,
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  child: SizedBox(
                                      width: 100,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              FirebaseFirestore.instance
                                                  .collection("typeOfWashes")
                                                  .doc(
                                                      widget.typeOfWashData!.id)
                                                  .update({
                                                "bgColor": _bgColor.text,
                                                "cost": _cost.text,
                                                "discountedCost":
                                                    _discountedCost.text,
                                                "id": _id.text,
                                                "imageIcon": (_changeImageIcon
                                                                .text ==
                                                            "" ||
                                                        _changeImageIcon.text ==
                                                            "null")
                                                    ? _imageIcon.text
                                                    : _changeImageIcon.text,
                                                "isActive": _active,
                                                "name": _name.text,
                                                "timeDuration":
                                                    _timeDuration.text,
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text('Submit')))),
                            ]),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
