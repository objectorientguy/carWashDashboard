import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSubscription extends StatefulWidget {
  const AddSubscription({Key? key}) : super(key: key);

  @override
  State<AddSubscription> createState() => _AddSubscriptionState();
}

class _AddSubscriptionState extends State<AddSubscription> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _color = TextEditingController();
  final TextEditingController _cost = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _duration = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _noOfWash = TextEditingController();
  final TextEditingController _orderIndex = TextEditingController();
  final TextEditingController _textColor = TextEditingController();
  final TextEditingController _title = TextEditingController();
  bool? _active;
  bool? _limited;

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
            Text("Add Subscription Details",
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: _color,
                            decoration: InputDecoration(
                              labelText: 'Color',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a color';
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
                            controller: _duration,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: _duration,
                            decoration: InputDecoration(
                              labelText: 'Duration',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a duration';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: _image,
                            decoration: InputDecoration(
                              labelText: 'Image',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an image';
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
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Limited Offer',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            value: _limited,
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
                                _limited = value!;
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
                            controller: _noOfWash,
                            decoration: InputDecoration(
                              labelText: 'No. of Washes',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the number of washes';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: _orderIndex,
                            decoration: InputDecoration(
                              labelText: 'Order Index',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an order index';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: _textColor,
                            decoration: InputDecoration(
                              labelText: 'Text Color',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a text color';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: _title,
                            decoration: InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a title';
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
                                      .collection("subscriptionPlans")
                                      .add({
                                    "color": _color.text,
                                    "cost": _cost.text,
                                    "description": _description.text,
                                    "duration": _duration.text,
                                    "image": _image.text,
                                    "isActive": _active,
                                    "limitedOffer": _limited,
                                    "noOfWash": _noOfWash.text,
                                    "orderIndex": _orderIndex.text,
                                    "textColor": _textColor.text,
                                    "title": _title.text,
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
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
