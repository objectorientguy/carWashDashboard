import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPromotionalBanner extends StatefulWidget {
  const AddPromotionalBanner({Key? key}) : super(key: key);

  @override
  State<AddPromotionalBanner> createState() => _AddPromotionalBannerState();
}

class _AddPromotionalBannerState extends State<AddPromotionalBanner> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bannerController = TextEditingController();
  String? banner;

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
            Text("Add Promotional Banner",
                style: GoogleFonts.inter(
                    color: const Color(0xff333333),
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            Center(
              child: Form(
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
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                FirebaseFirestore.instance
                                    .collection("promotionalBanners")
                                    .add({
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
