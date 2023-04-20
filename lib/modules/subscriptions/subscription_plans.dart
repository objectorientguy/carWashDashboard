import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_subscription.dart';
import 'edit_subscription.dart';

class SubscriptionPlans extends StatefulWidget {
  const SubscriptionPlans({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlans> createState() => _SubscriptionPlansState();
}

class _SubscriptionPlansState extends State<SubscriptionPlans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subscriptions",
                      style: GoogleFonts.inter(
                          color: const Color(0xff333333),
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddSubscription()));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xff606CCB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.08,
                            MediaQuery.of(context).size.width * 0.033)),
                    child: Text(
                      'Add New',
                      style: GoogleFonts.inter(
                        color: const Color(0xffFFFFFF),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.01),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("subscriptionPlans")
                      .orderBy('orderIndex', descending: false)
                      .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 200 / 100,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20, // spacing between rows
                                  crossAxisSpacing: 30),
                          itemBuilder: (context, index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditSubscription(
                                            subscriptionData:
                                                snapshot.data!.docs[index])));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                color: Color(int.parse(
                                    snapshot.data!.docs[index]['color'])),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("typeOfWashes")
                                                .doc(snapshot
                                                    .data!.docs[index].id)
                                                .delete();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.delete_simple,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: snapshot.data!.docs[index]
                                                    ['image'],
                                                imageBuilder: (context, imageProvider) => Container(
                                                    height: MediaQuery.of(context).size.width *
                                                        0.1,
                                                    width: MediaQuery.of(context).size.width *
                                                        0.15,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit
                                                                .fitWidth))),
                                                progressIndicatorBuilder:
                                                    (context, url, downloadProgress) =>
                                                        const CircularProgressIndicator(),
                                                errorWidget: (context, url, error) => Padding(
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
                                                  0.02,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      ['title'],
                                                  style: GoogleFonts.inter(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.015,
                                                      color: Color(int.parse(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  'textColor'))),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.005),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: Text(
                                                    snapshot.data!.docs[index]
                                                        .get('description')
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.005),
                                                Row(children: [
                                                  Text(
                                                    "\u20B9 ",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                  ),
                                                  Text(
                                                      snapshot.data!.docs[index]
                                                          .get('cost')
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.015,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(
                                                    "/ ${snapshot.data!.docs[index].get('duration')}",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                  )
                                                ]),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "for ",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.01),
                                                    ),
                                                    Text(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .get('noOfWash')
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.015,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    Text(
                                                      " wash",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.01),
                                                    )
                                                  ],
                                                ),
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
                                                                  "subscriptionPlans")
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id)
                                                              .update({
                                                            "color": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['color'],
                                                            "cost": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['cost'],
                                                            "description": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['description'],
                                                            "duration": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['duration'],
                                                            "image": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["image"],
                                                            "isActive": value,
                                                            "limitedOffer": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                [
                                                                'limitedOffer'],
                                                            "noOfWash": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['noOfWash'],
                                                            "orderIndex": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['orderIndex'],
                                                            "textColor": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['textColor'],
                                                            "title": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['title'],
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Limited:  ",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.01),
                                                    ),
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
                                                            ['limitedOffer'],
                                                        onChanged:
                                                            (bool value) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "subscriptionPlans")
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id)
                                                              .update({
                                                            "color": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['color'],
                                                            "cost": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['cost'],
                                                            "description": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['description'],
                                                            "duration": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['duration'],
                                                            "image": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["image"],
                                                            "isActive": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['isActive'],
                                                            "limitedOffer":
                                                                value,
                                                            "noOfWash": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['noOfWash'],
                                                            "orderIndex": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['orderIndex'],
                                                            "textColor": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['textColor'],
                                                            "title": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['title'],
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
