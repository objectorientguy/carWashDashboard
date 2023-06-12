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
      body: Padding(
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
                      Text("Subscriptions",
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
                    return Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            splashRadius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.012,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CupertinoAlertDialog(
                                                      title:
                                                          const Text("Delete"),
                                                      content: const Text(
                                                          "Are you sure you want to delete this?"),
                                                      actions: <
                                                          CupertinoDialogAction>[
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("No"),
                                                        ),
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "subscriptionPlans")
                                                                .doc(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id)
                                                                .delete();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("Yes"),
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
                                                    0.012))),
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
                                                    ['carImage'],
                                                imageBuilder: (context, imageProvider) => Container(
                                                    height: MediaQuery.of(context).size.width *
                                                        0.1,
                                                    width: MediaQuery.of(context).size.width *
                                                        0.15,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(
                                                            12),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit
                                                                .fitWidth))),
                                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget: (context, url, error) =>
                                                    Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01), child: const Text("oops!"))),
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
                                                    snapshot.data!.docs[index]
                                                        ['title'],
                                                    style: GoogleFonts.inter(
                                                        fontSize:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.015,
                                                        color: Color(int.parse(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get(
                                                                    'textColor'))),
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.005),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: Text(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .get('description')
                                                            .toString()
                                                            .replaceAll(
                                                                "\\n", "\n"),
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.01,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.005),
                                                Row(children: [
                                                  Text("\u20B9 ",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.01)),
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
                                                Row(children: [
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
                                                      snapshot.data!.docs[index]
                                                          .get('noOfWash')
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.015,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(" wash",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.01))
                                                ]),
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
                                                            "image": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["image"],
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
                                                            "carImage": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["carImage"],
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
                                                            "carImage": snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["carImage"],
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
                          }),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    return const SizedBox();
                  }
                })
          ],
        ),
      ),
    );
  }
}
