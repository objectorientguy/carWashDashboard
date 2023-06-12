import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_type_of_wash.dart';
import 'edit_typse_of_washes.dart';

class TypesOfWashes extends StatefulWidget {
  const TypesOfWashes({Key? key}) : super(key: key);

  @override
  State<TypesOfWashes> createState() => _TypesOfWashesState();
}

class _TypesOfWashesState extends State<TypesOfWashes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        const BackButton(),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005),
                        Text("Types Of Washes",
                            style: GoogleFonts.inter(
                                color: const Color(0xff333333),
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddTypeOfWash()));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xff606CCB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.08,
                            MediaQuery.of(context).size.width * 0.033)),
                    child: Text('Add New',
                        style: GoogleFonts.inter(
                            color: const Color(0xffFFFFFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.01),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("typeOfWashes")
                      .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 200 / 105,
                                  mainAxisSpacing: 20.0, // spacing between rows
                                  crossAxisSpacing: 20.0),
                          itemBuilder: (context, index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditTypeOfWash(
                                            typeOfWashData:
                                                snapshot.data!.docs[index])));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                color: Color(int.parse(
                                    snapshot.data!.docs[index]['bgColor'])),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return CupertinoAlertDialog(
                                                        title: const Text(
                                                            "Delete"),
                                                        content: const Text(
                                                            "Are you sure you want to delete this?"),
                                                        actions: <
                                                            CupertinoDialogAction>[
                                                          CupertinoDialogAction(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "No"),
                                                          ),
                                                          CupertinoDialogAction(
                                                            onPressed: () {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "typeOfWashes")
                                                                  .doc(snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id)
                                                                  .delete();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Yes"),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              icon: Icon(
                                                CupertinoIcons.delete_simple,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.012,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        ),
                                        child: Row(children: [
                                          CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: snapshot
                                                  .data!.docs[index]
                                                  .get("imageIcon")
                                                  .toString(),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.04,
                                                            right: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.04),
                                                        child:
                                                            const CircularProgressIndicator(),
                                                      ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                    child: const Text(
                                                      "oops!",
                                                    ),
                                                  )),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${snapshot.data!.docs[index]['name']}",
                                                    style: GoogleFonts.inter(
                                                        color: const Color(
                                                            0xff333333),
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.015,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                Text(
                                                    "Time: ${snapshot.data!.docs[index]['timeDuration']} mins",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01)),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.008),
                                                (snapshot.data!.docs[index][
                                                            'discountedCost'] ==
                                                        0)
                                                    ? Text(
                                                        "Cost:  \u20B9 ${snapshot.data!.docs[index]['cost']}",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.01))
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                            Text("Cost:  ",
                                                                style: TextStyle(
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.01)),
                                                            Text(
                                                              "\u20B9 ${snapshot.data!.docs[index]['cost']} ",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.01),
                                                            ),
                                                            Text(
                                                                " \u20B9 ${snapshot.data!.docs[index]['discountedCost']}",
                                                                style: TextStyle(
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.01))
                                                          ]),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.005),
                                                Row(
                                                  children: [
                                                    Text("Active:  ",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.01)),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                      child: Switch(
                                                        activeColor:
                                                            Colors.white,
                                                        inactiveThumbColor:
                                                            Colors.white,
                                                        activeTrackColor:
                                                            CupertinoColors
                                                                .activeGreen,
                                                        inactiveTrackColor:
                                                            CupertinoColors
                                                                .systemGrey,
                                                        value: snapshot.data!
                                                                .docs[index]
                                                            ['isActive'],
                                                        onChanged:
                                                            (bool value) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "typeOfWashes")
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id)
                                                              .update({
                                                            "bgColor": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['bgColor'],
                                                            "cost": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['cost'],
                                                            "discountedCost": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                [
                                                                'discountedCost'],
                                                            "id": snapshot.data!
                                                                    .docs[index]
                                                                ['id'],
                                                            "imageIcon": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['imageIcon'],
                                                            "isActive": value,
                                                            "name": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['name'],
                                                            "timeDuration": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                [
                                                                'timeDuration'],
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ])
                                        ]),
                                      ),
                                    ]),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return const Text("Error");
                    } else {
                      return const SizedBox();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
