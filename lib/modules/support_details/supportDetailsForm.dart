// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSupportDetails extends StatefulWidget {
  const AddSupportDetails({Key? key}) : super(key: key);

  @override
  State<AddSupportDetails> createState() => _AddSupportDetailsState();
}

class _AddSupportDetailsState extends State<AddSupportDetails> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _email = TextEditingController();
  bool? _active;

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
            Text("Add Support Details",
                style: GoogleFonts.inter(
                    color: const Color(0xff333333),
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            Expanded(
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
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
                                  controller: _email,
                                  decoration: InputDecoration(
                                    labelText: 'E-mail',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a E-mail';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: _number,
                                  decoration: InputDecoration(
                                    labelText: 'Number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Number';
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
                              Padding(
                                padding: const EdgeInsets.only(left: 138.0),
                                child: SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        FirebaseFirestore.instance
                                            .collection("supportDetails")
                                            .add({
                                          "number": _number.text,
                                          "email": _email.text,
                                          "isActive": _active
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
                    ))),
          ],
        ),
      ),
    );
  }
}
