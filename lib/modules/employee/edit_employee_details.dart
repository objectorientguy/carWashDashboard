// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditEmployeeDetails extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>? employeeData;

  const EditEmployeeDetails({super.key, this.employeeData});

  @override
  _EditEmployeeDetailsState createState() => _EditEmployeeDetailsState();
}

class _EditEmployeeDetailsState extends State<EditEmployeeDetails> {
  final employee = FirebaseFirestore.instance.collection("employeeDetails");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _age = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.text = widget.employeeData!["name"].toString();
    _number.text = widget.employeeData!["number"].toString();
    _address.text = widget.employeeData!["address"].toString();
    _gender.text = widget.employeeData!["gender"].toString();
    _age.text = widget.employeeData!["age"].toString();
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
            Text("Edit Employee Details",
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
                                  controller: _name,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Name';
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
                                child: TextFormField(
                                  controller: _address,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: _gender,
                                  decoration: InputDecoration(
                                    labelText: 'Gender',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Gender';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: _age,
                                  decoration: InputDecoration(
                                    labelText: 'Age',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter an Age';
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
                                            .collection("employeeDetails")
                                            .doc(widget.employeeData!.id)
                                            .update({
                                          "address": _address.text,
                                          "age": _age.text,
                                          "gender": _gender.text,
                                          "name": _name.text,
                                          "number": _number.text,
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
