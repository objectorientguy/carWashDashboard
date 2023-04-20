// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool? _active;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit Type Of Wash",
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
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _bgColor,
                          decoration: InputDecoration(
                            labelText: 'bgColor',
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
                            labelText: 'discountedCost',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a discounted cost';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _id,
                          decoration: InputDecoration(
                            labelText: 'id',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a id';
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
                            labelText: 'imageIcon',
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
                          controller: _name,
                          decoration: InputDecoration(
                            labelText: 'name',
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
                          controller: _timeDuration,
                          decoration: InputDecoration(
                            labelText: 'timeDuration',
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                FirebaseFirestore.instance
                                    .collection("typeOfWashes")
                                    .doc(widget.typeOfWashData!.id)
                                    .update({
                                  "bgColor": _bgColor.text,
                                  "cost": _cost.text,
                                  "discountedCost": _discountedCost.text,
                                  "id": _id.text,
                                  "imageIcon": _imageIcon.text,
                                  "isActive": _active,
                                  "name": _name.text,
                                  "timeDuration": _timeDuration.text,
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
