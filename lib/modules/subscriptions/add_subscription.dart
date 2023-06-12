// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker_web/image_picker_web.dart';

import '../../widgets/progress_bar.dart';

class AddSubscription extends StatefulWidget {
  const AddSubscription({Key? key}) : super(key: key);

  @override
  State<AddSubscription> createState() => _AddSubscriptionState();
}

class _AddSubscriptionState extends State<AddSubscription> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _color = TextEditingController();
  final TextEditingController _cost = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _duration = TextEditingController();
  final TextEditingController _carImage = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _noOfWash = TextEditingController();
  final TextEditingController _orderIndex = TextEditingController();
  final TextEditingController _textColor = TextEditingController();
  final TextEditingController _title = TextEditingController();
  bool? _active;
  bool? _limited;
  bool carImageSelected = false;
  dynamic mediaInfoCar;
  String carImage = "";
  String? mimeTypeCar;
  bool fileSelected = false;
  dynamic mediaInfo;
  String file = "";
  String? mimeType;

  Future carImagePicker() async {
    mediaInfoCar = await ImagePickerWeb.getImageInfo;
    carImage = mediaInfoCar.fileName;
    if (mediaInfoCar != null) {
      setState(() {
        carImageSelected = true;
      });
      mimeTypeCar = mime(p.basename(mediaInfoCar.fileName));

      uploadCarImage(mediaInfoCar, file);
      ProgressBar.show(context);
    }
  }

  Future uploadCarImage(mediaInfo, String fileName) async {
    try {
      final metadata = SettableMetadata(contentType: mimeTypeCar);
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("subscriptionDetailsCar/$fileName");

      await ref.putData(mediaInfo.data, metadata);
      _carImage.text = await ref.getDownloadURL();
      ProgressBar.dismiss(context);
    } catch (e) {
      return;
    }
  }

  Future<void> deleteCarImage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      _carImage.text = "";
    } catch (e) {
      return;
    }
  }

  Future imagePicker() async {
    mediaInfo = await ImagePickerWeb.getImageInfo;
    file = mediaInfo.fileName;
    if (mediaInfo != null) {
      setState(() {
        fileSelected = true;
      });
      mimeType = mime(p.basename(mediaInfo.fileName));
      uploadFile(mediaInfo, file);
      ProgressBar.show(context);
    } else {
      return;
    }
  }

  Future uploadFile(mediaInfo, String fileName) async {
    try {
      final metadata = SettableMetadata(contentType: mimeType);
      Reference ref =
          FirebaseStorage.instance.ref().child("subscriptionPlans/$fileName");

      await ref.putData(mediaInfo.data, metadata);
      _image.text = await ref.getDownloadURL();
      ProgressBar.dismiss(context);
    } catch (e) {
      return;
    }
  }

  Future<void> deleteImage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      _image.text = "";
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
          Row(children: [
            const BackButton(),
            SizedBox(width: MediaQuery.of(context).size.width * 0.005),
            Text("Add Subscription Details",
                style: GoogleFonts.inter(
                    color: const Color(0xff333333),
                    fontSize: 20,
                    fontWeight: FontWeight.w600))
          ]),
          SizedBox(height: MediaQuery.of(context).size.width * 0.02),
          Expanded(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.02),
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            padding: EdgeInsets.zero,
                            child: (carImageSelected == false)
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
                                                  color: Colors.grey.shade400)),
                                        ),
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
                                              carImagePicker();
                                            },
                                            child: const Text('Pick Image')),
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
                                              deleteImage(_carImage.text);
                                              setState(() {
                                                carImageSelected = false;
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
                                        width: MediaQuery.of(context).size.width *
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
                                            child: Image.memory(
                                                mediaInfoCar.data,
                                                semanticLabel:
                                                    mediaInfoCar.fileName,
                                                fit: BoxFit.contain))),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                    Text(carImage.toString()),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.01)
                                  ])),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
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
                                                        Colors.grey.shade400))),
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
                                            child: const Text('Pick Image')),
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
                                              deleteImage(_image.text);
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
                                    Text(file.toString()),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.01)
                                  ])),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                      ]),
                      Center(
                          child: Form(
                              key: _formKey,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.005),
                                    SizedBox(
                                        width: 350,
                                        child: TextFormField(
                                            controller: _title,
                                            decoration: InputDecoration(
                                                labelText: 'Subscription Title',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a title';
                                              }
                                              return null;
                                            })),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                        width: 350,
                                        child: TextFormField(
                                            controller: _color,
                                            decoration: InputDecoration(
                                                labelText: 'Background Color',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a color';
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
                                                    BorderRadius.circular(10.0),
                                              )),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a cost';
                                            }
                                            return null;
                                          },
                                        )),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                        width: 350,
                                        child: TextFormField(
                                            controller: _description,
                                            decoration: InputDecoration(
                                                labelText: 'Description',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a description';
                                              }
                                              return null;
                                            })),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                        width: 350,
                                        child: TextFormField(
                                            controller: _duration,
                                            decoration: InputDecoration(
                                                labelText: 'Duration',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a duration';
                                              }
                                              return null;
                                            })),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                        width: 350,
                                        child: TextFormField(
                                            controller: _carImage,
                                            decoration: InputDecoration(
                                                labelText: 'Car Image',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter car image';
                                              }
                                              return null;
                                            })),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                        width: 350,
                                        child: TextFormField(
                                            controller: _image,
                                            decoration: InputDecoration(
                                                labelText: 'Image',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter image';
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
                                                        BorderRadius.circular(
                                                            10.0))),
                                            value: _active,
                                            items: const [
                                              DropdownMenuItem(
                                                  value: true,
                                                  child: Text('True')),
                                              DropdownMenuItem(
                                                  value: false,
                                                  child: Text('False'))
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
                                        child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                                labelText: 'Limited Offer',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            value: _limited,
                                            items: const [
                                              DropdownMenuItem(
                                                  value: true,
                                                  child: Text('True')),
                                              DropdownMenuItem(
                                                  value: false,
                                                  child: Text('False'))
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _limited = value!;
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
                                            controller: _noOfWash,
                                            decoration: InputDecoration(
                                                labelText: 'No. of Washes',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter the number of washes';
                                              }
                                              return null;
                                            })),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                        width: 350,
                                        child: TextFormField(
                                            controller: _orderIndex,
                                            decoration: InputDecoration(
                                                labelText: 'Order Index',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter an order index';
                                              }
                                              return null;
                                            })),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                        width: 350,
                                        child: TextFormField(
                                            controller: _textColor,
                                            decoration: InputDecoration(
                                                labelText: 'Text Color',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a text color';
                                              }
                                              return null;
                                            })),
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
                                                    _formKey.currentState!
                                                        .save();
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "subscriptionPlans")
                                                        .add({
                                                      "color": _color.text,
                                                      "cost": _cost.text,
                                                      "description":
                                                          _description.text,
                                                      "duration":
                                                          _duration.text,
                                                      "carImage":
                                                          _carImage.text,
                                                      "image": _image.text,
                                                      "isActive": _active,
                                                      "limitedOffer": _limited,
                                                      "noOfWash":
                                                          _noOfWash.text,
                                                      "orderIndex":
                                                          _orderIndex.text,
                                                      "textColor":
                                                          _textColor.text,
                                                      "title": _title.text
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text('Submit')))),
                                    const SizedBox(height: 16.0),
                                  ]))),
                    ],
                  ))),
        ]),
      ),
    );
  }
}
