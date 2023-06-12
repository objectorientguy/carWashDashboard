import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_promotional_banner.dart';
import 'edit_promotional_banner.dart';

class PromotionalBannerScreen extends StatefulWidget {
  static const routeName = "PromotionalBannerScreen";

  const PromotionalBannerScreen({Key? key}) : super(key: key);

  @override
  State<PromotionalBannerScreen> createState() =>
      _PromotionalBannerScreenState();
}

class _PromotionalBannerScreenState extends State<PromotionalBannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          child: Row(children: [
                        const BackButton(),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.005),
                        Text("Promotional Banner",
                            style: GoogleFonts.inter(
                                color: const Color(0xff333333),
                                fontSize: 20,
                                fontWeight: FontWeight.w600))
                      ])),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddPromotionalBanner()));
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
                                  fontWeight: FontWeight.w400)))
                    ]),
                SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("promotionalBanners")
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
                                      crossAxisCount: 3,
                                      childAspectRatio: 1.5,
                                      mainAxisSpacing: 20.0,
                                      crossAxisSpacing: 20.0),
                              itemBuilder: (context, index) {
                                return InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPromotionalBanner(
                                                      promotionalBannerData:
                                                          snapshot.data!
                                                              .docs[index])));
                                    },
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Column(children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return CupertinoAlertDialog(
                                                            title: const Text("Delete"),
                                                            content: const Text("Are you sure you want to delete this?"),
                                                            actions: <CupertinoDialogAction>[
                                                              CupertinoDialogAction(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child: const Text("No"),
                                                              ),
                                                              CupertinoDialogAction(
                                                                onPressed: () {
                                                                  FirebaseFirestore.instance
                                                                      .collection(
                                                                      "promotionalBanners")
                                                                      .doc(snapshot.data!
                                                                      .docs[index].id)
                                                                      .delete();
                                                                  Navigator.pop(context);
                                                                },
                                                                child: const Text(
                                                                    "Yes"),
                                                              ),
                                                            ],
                                                          );
                                                        });

                                                  },
                                                  icon: Icon(
                                                      CupertinoIcons
                                                          .delete_simple,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.012))),
                                          CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: snapshot.data!.docs[index]
                                                  ['banner'],
                                              imageBuilder: (context, imageProvider) => Container(
                                                  width: MediaQuery.of(context).size.width *
                                                      0.275,
                                                  height: MediaQuery.of(context).size.width *
                                                      0.15,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(
                                                          12),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit
                                                              .fitWidth))),
                                              progressIndicatorBuilder:
                                                  (context, url, downloadProgress) => Padding(
                                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.06, bottom: MediaQuery.of(context).size.width * 0.05),
                                                      child: const Center(child: CircularProgressIndicator())),
                                              errorWidget: (context, url, error) => Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07), child: const Text("oops!"))),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.005)
                                        ])));
                              }),
                        );
                      } else if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        return const SizedBox();
                      }
                    })
              ])),
    );
  }
}
