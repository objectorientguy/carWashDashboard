import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_employee_details.dart';
import 'employee_details_form.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({Key? key}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
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
                  SizedBox(
                    child: Row(children: [
                      const BackButton(),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.005),
                      Text("Employee Details",
                          style: GoogleFonts.inter(
                              color: const Color(0xff333333),
                              fontSize: 20,
                              fontWeight: FontWeight.w600))
                    ]),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddEmployeeDetails()));
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
                      .collection("employeeDetails")
                      .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 1.5,
                                  mainAxisSpacing: 20.0, // spacing between rows
                                  crossAxisSpacing: 20.0),
                          itemBuilder: (context, index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditEmployeeDetails(
                                                employeeData: snapshot
                                                    .data!.docs[index])));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.015,
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              0.01),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            splashRadius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
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
                                                                    "employeeDetails")
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
                                                  0.012,
                                            )),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.015,
                                            child: Icon(Icons.person,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                child: Text(
                                                  "${snapshot.data!.docs[index]['name']}",
                                                  style: GoogleFonts.inter(
                                                      color: const Color(
                                                          0xff333333),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.0135,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Text(
                                                "${snapshot.data!.docs[index]['gender']} - ${snapshot.data!.docs[index]['age']}",
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          thickness: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.001,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.call,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.018,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.028),
                                          Text(
                                              "${snapshot.data!.docs[index]['number']}",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.01)),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.home_outlined,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.018,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.028),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            child: Text(
                                                "${snapshot.data!.docs[index]['address']}",
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
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
