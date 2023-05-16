import 'package:car_wash_dashboard/modules/dashboard/bloc/bloc.dart';
import 'package:car_wash_dashboard/modules/dashboard/bloc/events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'model/dashboard_model.dart';

class DashboardTable extends StatefulWidget {
  final List<BookingData> bookingData;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> washData;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> employeeData;

  DashboardTable(
      {Key? key,
      required this.bookingData,
      required this.washData,
      required this.employeeData})
      : super(key: key);

  @override
  State<DashboardTable> createState() => _DashboardTableState();
}

class _DashboardTableState extends State<DashboardTable> {
  final TextEditingController controller = TextEditingController();
  dynamic selectedEmployee;
  String? id;
  Map editBookingMap = {};

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize:MainAxisSize.min,children: [
      Container(
        decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffF2F2F2)),
              borderRadius: BorderRadius.circular(8)),
        child: DataTable(
              columnSpacing: MediaQuery.of(context).size.width * 0.03,
              dataRowHeight: MediaQuery.of(context).size.width * 0.04,
              columns: [
                DataColumn(
                    label: Text('Date',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff333333),
                            fontSize:
                                MediaQuery.of(context).size.width * 0.01))),
                DataColumn(
                    label: Text('Time',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff333333),
                            fontSize:
                                MediaQuery.of(context).size.width * 0.01))),
                DataColumn(
                    label: Text('Name',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff333333),
                            fontSize:
                                MediaQuery.of(context).size.width * 0.01))),
                DataColumn(
                    label: Text('Address',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff333333),
                            fontSize:
                                MediaQuery.of(context).size.width * 0.01))),
                DataColumn(
                    label: Text('Wash Type',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff333333),
                            fontSize:
                                MediaQuery.of(context).size.width * 0.01))),
                DataColumn(
                    label: Text('Employee',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff333333),
                            fontSize: MediaQuery.of(context).size.width * 0.01),
                        maxLines: 2)),
                DataColumn(
                    label: Text('Payment',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff333333),
                            fontSize: MediaQuery.of(context).size.width * 0.01),
                        maxLines: 2)),
                DataColumn(
                    label: Text('',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff333333),
                            fontSize:
                                MediaQuery.of(context).size.width * 0.01)))
              ],
              rows: widget.bookingData.map((entry) {
                var service = entry.services!.split(",");

                String? dropdownValue = (entry.employee.toString() == "null")
                    ? null
                    : widget.employeeData
                        .elementAt(widget.employeeData.indexWhere((element) =>
                            element.data()["id"].toString() ==
                            entry.employee.toString()))
                        .data()["name"];

                return DataRow(cells: [
                  DataCell(Text(
                      DateFormat("dd.MM.yyyy").format(entry.bookingDate!),
                      style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.008,
                          color: const Color(0xff828282),
                          fontWeight: FontWeight.w500),
                      maxLines: 1)),
                  DataCell(Text(
                      DateFormat('hh:mm a').format(DateFormat("hh:mm:ss")
                          .parse(entry.bookingTime.toString())),
                      style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.008,
                          color: const Color(0xff828282),
                          fontWeight: FontWeight.w500),
                      maxLines: 1)),
                  DataCell(Text(entry.customer!.customerName.toString(),
                      style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.008,
                          color: const Color(0xff828282),
                          fontWeight: FontWeight.w500),
                      maxLines: 1)),
                  DataCell(Text(
                      "${entry.address!.addressName}, ${entry.address!.city}-${entry.address!.pincode}",
                      style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.008,
                          color: const Color(0xff828282),
                          fontWeight: FontWeight.w500))),
                  DataCell(SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: (service.length == 1)
                          ? Text(
                              widget.washData.elementAt(widget.washData
                                      .indexWhere((element) => element.data()['id'] == service[0].trim()))[
                                  "name"],
                              style: GoogleFonts.inter(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.008,
                                  color: const Color(0xff828282),
                                  fontWeight: FontWeight.w500),
                              maxLines: 1)
                          : Text("${widget.washData.elementAt(widget.washData.indexWhere((element) => element.data()['id'] == service[0].trim()))["name"]}, ${widget.washData.elementAt(widget.washData.indexWhere((element) => element.data()['id'] == service[1].trim()))["name"]}",
                              style: GoogleFonts.inter(
                                  fontSize: MediaQuery.of(context).size.width * 0.008,
                                  color: const Color(0xff828282),
                                  fontWeight: FontWeight.w500),
                              maxLines: 2))),
                  DataCell(DropdownButtonFormField(
                    decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(12))),
                    items: widget.employeeData.map((data) {
                      return DropdownMenuItem<
                          QueryDocumentSnapshot<Map<String, dynamic>>>(
                        value: data,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              data.data()["name"],
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    hint: Text(
                        (dropdownValue.toString() == "null")
                            ? "Assign Employee"
                            : dropdownValue.toString(),
                        style: GoogleFonts.inter(
                            fontSize: MediaQuery.of(context).size.width * 0.008,
                            color: const Color(0xff828282),
                            fontWeight: FontWeight.w500),
                        maxLines: 1),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (newValue) {
                      setState(() {
                        selectedEmployee = newValue!;
                        dropdownValue = selectedEmployee.data()["name"];
                        id = selectedEmployee.data()["id"];
                        editBookingMap["employee"] = id;
                      });
                      context.read<DashboardBloc>().add(
                          AddEmployee(id: id.toString(), bookingData: entry));
                    },
                  )),
                  DataCell(Container(
                      child: Text(entry.paymentMode.toString(),
                          style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.008,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff359A73))))),
                  DataCell(PopupMenuButton(
                      itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'remove',
                              child: Text('Remove'),
                            ),
                            const PopupMenuItem(
                                value: 'done', child: Text('Done'))
                          ],
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            break;
                          case 'remove':
                            break;
                          case 'done':
                            break;
                        }
                      },
                      offset: const Offset(10, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text("...",
                              style: GoogleFonts.inter(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.01,
                                  color: const Color(0xffBDBDBD))))))
                ]);
              }).toList()),
      ),
    ]);
  }
}
