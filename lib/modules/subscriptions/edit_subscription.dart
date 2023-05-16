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

class EditSubscription extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>? subscriptionData;

  const EditSubscription({Key? key, this.subscriptionData}) : super(key: key);

  @override
  State<EditSubscription> createState() => _EditSubscriptionState();
}

class _EditSubscriptionState extends State<EditSubscription> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _color = TextEditingController();
  final TextEditingController _cost = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _duration = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _carImage = TextEditingController();
  final TextEditingController _noOfWash = TextEditingController();
  final TextEditingController _orderIndex = TextEditingController();
  final TextEditingController _textColor = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _changeCarImage = TextEditingController();
  final TextEditingController _changeImage = TextEditingController();
  bool? _active;
  bool? _limited;
  bool carImageSelected = false;
  var mediaInfoCar;
  String carImage = "";
  String? mimeTypeCar;
  bool fileSelected = false;
  var mediaInfo;
  String file = "";
  String? mimeType;

  @override
  void initState() {
    super.initState();
    _color.text = widget.subscriptionData!["color"].toString();
    _cost.text = widget.subscriptionData!["cost"].toString();
    _description.text = widget.subscriptionData!["description"].toString();
    _duration.text = widget.subscriptionData!["duration"].toString();
    _image.text = widget.subscriptionData!["image"].toString();
    _noOfWash.text = widget.subscriptionData!["noOfWash"].toString();
    _orderIndex.text = widget.subscriptionData!["orderIndex"].toString();
    _textColor.text = widget.subscriptionData!["textColor"].toString();
    _title.text = widget.subscriptionData!["title"].toString();
    _active = widget.subscriptionData!["isActive"];
    _limited = widget.subscriptionData!["limitedOffer"];
    _carImage.text = widget.subscriptionData!["carImage"];

  }

  Future carImagePicker() async {
    mediaInfoCar = await ImagePickerWeb.getImageInfo;
    carImage = mediaInfoCar.fileName;
    if (mediaInfoCar != null) {
      setState(() {
        carImageSelected = true;
      });
      mimeTypeCar = mime(p.basename(mediaInfoCar.fileName));
      html.File mediaFile = html.File(
          mediaInfoCar.data, mediaInfoCar.fileName, {'type': mimeTypeCar});
      uploadCarImage(mediaInfoCar, carImage);ProgressBar.show(context);
    }
  }

  Future uploadCarImage(mediaInfo, String fileName) async {
    try {
      final String? extension = extensionFromMime(mimeTypeCar!);
      final metadata = SettableMetadata(contentType: mimeTypeCar);
      Reference ref =
      FirebaseStorage.instance.ref().child("subscriptionDetailsCar/$fileName");

      await ref.putData(mediaInfo.data, metadata);
      _changeCarImage.text = await ref.getDownloadURL();
      ProgressBar.dismiss(context);
    } catch (e) {
      print("File Upload Error $e");
    }
  }
  Future<void> deleteCarImage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      _changeCarImage.text = "";
    } catch (e) {
      print("Error deleting db from cloud: $e");
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
      html.File mediaFile =
      html.File(mediaInfo.data, mediaInfo.fileName, {'type': mimeType});
      uploadCarImage(mediaInfo, file);ProgressBar.show(context);
    }
  }

  Future uploadFile(mediaInfo, String fileName) async {
    try {
      final String? extension = extensionFromMime(mimeType!);
      final metadata = SettableMetadata(contentType: mimeType);
      Reference ref =
      FirebaseStorage.instance.ref().child("subscriptionPlans/$fileName");

      await ref.putData(mediaInfo.data, metadata);
      _changeImage.text = await ref.getDownloadURL();
      ProgressBar.dismiss(context);
    } catch (e) {
      print("File Upload Error $e");
    }
  }
  Future<void> deleteImage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      _changeImage.text = "";
    } catch (e) {
      print("Error deleting db from cloud: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery
                .of(context)
                .size
                .height * 0.05,
            right: MediaQuery
                .of(context)
                .size
                .height * 0.05,
            top: MediaQuery
                .of(context)
                .size
                .height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BackButton(),
                SizedBox(width: MediaQuery.of(context).size.width*0.005),
                Text("Edit Subscription Details",
                    style: GoogleFonts.inter(
                        color: const Color(0xff333333),
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .width * 0.02),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.55,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02),
                              border: Border.all(
                                  color: Colors.grey.shade400)),
                          padding: EdgeInsets.zero,
                          child: (carImageSelected == false)
                              ? Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .center,
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              children: [
                                SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.015),
                                Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.35,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius
                                            .circular(
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.02),
                                        border: Border.all(
                                            color: Colors.grey
                                                .shade400)),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: _carImage.text,
                                        imageBuilder:
                                            (context,
                                            imageProvider) =>
                                            Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.4,
                                                height: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.25,
                                                decoration: BoxDecoration(

                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        12),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit
                                                            .contain))),
                                        progressIndicatorBuilder: (context,
                                            url,
                                            downloadProgress) => const SizedBox(),
                                        errorWidget: (context,
                                            url,
                                            error) =>
                                            Padding(
                                                padding: EdgeInsets
                                                    .all(
                                                    MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .width *
                                                        0.01),
                                                child: const Center(
                                                    child: Text(
                                                        "oops!"))))),
                                SizedBox(
                                    height: MediaQuery
                                        .of(context)
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
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.28,
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.03)),
                                    onPressed: () {
                                      carImagePicker();
                                    },
                                    child: const Text(
                                        'Change Image')),
                                SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.02)
                              ],)
                              : Column(children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      deleteCarImage(_changeCarImage.text);
                                      setState(() {
                                        carImageSelected = false;
                                      });
                                    },
                                    splashRadius: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.02,
                                    icon: Icon(
                                        Icons.highlight_remove_sharp,
                                        size: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.025))),
                            Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.35,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(
                                        MediaQuery
                                            .of(context)
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
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.01),
                            Text(carImage.toString()),

                            SizedBox(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.01)
                          ])),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.width *
                              0.02),
                      Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.55,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02),
                              border: Border.all(
                                  color: Colors.grey.shade400)),
                          padding: EdgeInsets.zero,
                          child: (fileSelected == false)
                              ? Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .center,
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              children: [
                                SizedBox(
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.015),
                                Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.35,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius
                                            .circular(
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.02),
                                        border: Border.all(
                                            color: Colors.grey
                                                .shade400)),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: _image.text,
                                        imageBuilder: (context,
                                            imageProvider) =>
                                            Container(
                                                width:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.4,
                                                height: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.25,
                                                decoration: BoxDecoration(

                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        12),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit
                                                            .contain))),
                                        progressIndicatorBuilder: (context,
                                            url,
                                            downloadProgress) =>SizedBox(),
                                        errorWidget: (context,
                                            url,
                                            error) =>
                                            Padding(
                                                padding: EdgeInsets
                                                    .all(
                                                    MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .width *
                                                        0.01),
                                                child: const Center(
                                                    child: Text(
                                                        "oops!"))))),
                                SizedBox(
                                    height:
                                    MediaQuery
                                        .of(context)
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
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.28,
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.03)),
                                    onPressed: () {
                                      imagePicker();
                                    },
                                    child: const Text(
                                        'Change Image')),
                                SizedBox(
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.02)
                              ])
                              : Column(children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      deleteImage(_changeImage.text);
                                      setState(() {
                                        fileSelected = false;
                                      });
                                    },
                                    splashRadius:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.02,
                                    icon: Icon(
                                        Icons.highlight_remove_sharp,
                                        size: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.025))),
                            Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.35,
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.02),
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius
                                        .circular(4),
                                    child: Image.memory(
                                        mediaInfo.data,
                                        semanticLabel: mediaInfo
                                            .fileName,
                                        fit: BoxFit.contain))),
                            SizedBox(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01),
                            Text(file.toString()),

                            SizedBox(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01)
                          ]))
                    ]),
                    Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: <Widget>[
                            SizedBox(height: MediaQuery
                                .of(context)
                                .size
                                .width * 0.005),
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
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a color';
                                      }
                                      return null;
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: TextFormField(
                                    controller: _cost,
                                    decoration: InputDecoration(
                                        labelText: 'Cost',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    keyboardType: TextInputType
                                        .number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a cost';
                                      }
                                      return null;
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: TextFormField(
                                    controller: _duration,
                                    decoration: InputDecoration(
                                        labelText: 'Description',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a description';
                                      }
                                      return null;
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: TextFormField(
                                    controller: _duration,
                                    decoration: InputDecoration(
                                        labelText: 'Duration',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a duration';
                                      }
                                      return null;
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: TextFormField(
                                    controller: (_changeCarImage.text=="null"||_changeCarImage.text=="")?_carImage:_changeCarImage,
                                    decoration: InputDecoration(
                                        labelText: 'Car Image',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter car image';
                                      }
                                      return null;
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: TextFormField(
                                    controller: (_changeImage.text==""||_changeImage.text=="null")?_image:_changeImage,
                                    decoration: InputDecoration(
                                        labelText: 'Image',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter image';
                                      }
                                      return null;
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Is Active',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    value: _active,
                                    items: const [
                                      DropdownMenuItem(
                                          value: true,
                                          child: Text('True')
                                      ),
                                      DropdownMenuItem(
                                          value: false,
                                          child: Text('False')
                                      )
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
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Limited Offer',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    value: _limited,
                                    items: const [
                                      DropdownMenuItem(
                                          value: true,
                                          child: Text('True')
                                      ),
                                      DropdownMenuItem(
                                          value: false,
                                          child: Text('False')
                                      )
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
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: TextFormField(
                                    controller: _noOfWash,
                                    decoration: InputDecoration(
                                        labelText: 'No. of Washes',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    keyboardType: TextInputType
                                        .number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the number of washes';
                                      }
                                      return null;
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: TextFormField(
                                    controller: _orderIndex,
                                    decoration: InputDecoration(
                                        labelText: 'Order Index',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    keyboardType: TextInputType
                                        .number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter an order index';
                                      }
                                      return null;
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                                width: 350,
                                child: TextFormField(
                                    controller: _textColor,
                                    decoration: InputDecoration(
                                        labelText: 'Text Color',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(10.0)
                                        )
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a text color';
                                      }
                                      return null;
                                    }
                                )
                            ),
                            const SizedBox(height: 16.0),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 138.0),
                                child: SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey
                                              .currentState!
                                              .validate()) {
                                            _formKey
                                                .currentState!
                                                .save();
                                            FirebaseFirestore
                                                .instance
                                                .collection(
                                                "subscriptionPlans")
                                                .doc(widget
                                                .subscriptionData!
                                                .id)
                                                .update({
                                              "color": _color
                                                  .text,
                                              "cost": _cost
                                                  .text,
                                              "description": _description
                                                  .text,
                                              "duration": _duration
                                                  .text,
                                              "carImage": (_changeCarImage.text==""||_changeCarImage.text=="null")?_carImage
                                                  .text:_changeCarImage.text,
                                              "image": (_changeImage.text==""||_changeImage.text=="null")?_image.text:_changeImage.text,
                                              "isActive": _active,
                                              "limitedOffer": _limited,
                                              "noOfWash": _noOfWash
                                                  .text,
                                              "orderIndex": _orderIndex
                                                  .text,
                                              "textColor": _textColor
                                                  .text,
                                              "title": _title
                                                  .text
                                            });
                                            Navigator.pop(
                                                context);
                                          }
                                        },
                                        child: const Text(
                                            'Submit')
                                    )
                                )
                            ),
                            const SizedBox(height: 16.0)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
