import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String? banner;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit Promotional Banner",
                style: GoogleFonts.inter(
                    color: const Color(0xff333333),
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            Row(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                    controller: _bannerController,
                                    decoration: InputDecoration(
                                      labelText: 'Banner',
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
                                  padding: const EdgeInsets.only(left: 138.0),
                                  child: SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          FirebaseFirestore.instance
                                              .collection("promotionalBanners")
                                              .doc(widget
                                                  .promotionalBannerData!.id)
                                              .update({
                                            "banner": _bannerController.text,
                                          });
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
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
