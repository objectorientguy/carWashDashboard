// ignore_for_file: library_private_types_in_public_api

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:intl/intl.dart';
import '../Class/dashBoardItem.dart';
import '../Class/list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DateTime _selectedDate;
  List<DashboardItem> _allEntries = [];
  List<DashboardItem> _filteredEntries = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _allEntries = generateDummyData(300).cast<DashboardItem>();
    _filteredEntries = filterEntriesByDate(_allEntries, _selectedDate);
  }

  List<DashboardItem> filterEntriesByDate(
      List<DashboardItem> entries, DateTime date) {
    return entries
        .where((entry) =>
            entry.date ==
            '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}')
        .toList();
  }

  void updateFilteredEntries() {
    setState(() {
      _filteredEntries = filterEntriesByDate(_allEntries, _selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 33),
                  child: Text(
                    'Car Wash Dashboard',
                    style: GoogleFonts.inter(
                      color: const Color(0xff333333),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 31.0, top: 40),
                    child: Container(
                      height: 40,
                      width: 107,
                      decoration: BoxDecoration(
                        color: const Color(0xff606CCB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Text(
                        'New Booking',
                        style: GoogleFonts.inter(
                          color: const Color(0xffFFFFFF),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 92),
                    child: Text(
                      'SUMMARY',
                      style: GoogleFonts.inter(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 88),
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.03,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffffffff),
                        border: Border.all(color: const Color(0xffe0e0e0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              final DateTime? selectedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2024),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: Colors.redAccent,
                                      buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.normal,
                                      ),
                                      colorScheme: const ColorScheme.light(
                                              primary: Colors.red)
                                          .copyWith(secondary: Colors.red),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (selectedDate != null &&
                                  selectedDate != _selectedDate) {
                                _selectedDate = selectedDate;
                                updateFilteredEntries();
                              }
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.082, // change this value as needed
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedDate.day == DateTime.now().day &&
                                              _selectedDate.month ==
                                                  DateTime.now().month &&
                                              _selectedDate.year ==
                                                  DateTime.now().year
                                          ? 'Today'
                                          : DateFormat('dd MMMM')
                                              .format(_selectedDate),
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: const Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xffe0e0e0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 84,
                        width: 403.5,
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.01),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: const Color(0xffF4F4F4),
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset(
                                      'assets/images/Vector1.png',
                                      width: 5,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Today\'s total bookings',
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          color: const Color(0xff828282),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.0595,
                                        )),
                                    const SizedBox(height: 5),
                                    Text("45",
                                        style: GoogleFonts.inter(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff000000))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 35),
                    Expanded(
                      child: Container(
                        height: 84,
                        width: 403.5,
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.01),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: const Color(0xffF4F4F4),
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset(
                                      'assets/images/Vector3.png',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Today\'s Completed bookings',
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: const Color(0xff828282),
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.0595,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '33',
                                      style: GoogleFonts.inter(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff000000)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 35),
                    Expanded(
                      child: Container(
                        height: 84,
                        width: 403.5,
                        color: const Color(0xffFFFFFF),
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.01),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: const Color(0xffF4F4F4),
                                    padding: const EdgeInsets.all(12),
                                    child: const Icon(
                                        Icons.watch_later_outlined,
                                        size: 28,
                                        color: Color(0xff000000)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Today\'s Pending bookings',
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          color: const Color(0xff828282),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.0595,
                                        )),
                                    const SizedBox(height: 5),
                                    Text(
                                      '12',
                                      style: GoogleFonts.inter(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff000000)),
                                    ),
                                  ],
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
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 39),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffF2F2F2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DataTable(
                      columnSpacing: 100,
                      columns: [
                        DataColumn(
                          label: Text(
                            'Booking Date',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff828282),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Time',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff828282),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff828282),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Wash Type',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff828282),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Payment Status',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff828282),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Progress',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff828282),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            '',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff828282),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                      rows: _filteredEntries.map((entry) {
                        return DataRow(cells: [
                          DataCell(Text(
                            entry.date,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w500),
                          )),
                          DataCell(Text(
                            entry.time,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w500),
                          )),
                          DataCell(Text(
                            entry.address,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w500),
                          )),
                          DataCell(Text(
                            entry.typeOfWash,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w500),
                          )),
                          DataCell(Text(
                            entry.username,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w500),
                          )),
                          DataCell(Container(
                            padding: const EdgeInsets.all(8.0),
                            // optional padding for the container
                            decoration: BoxDecoration(
                              color: entry.paymentStatus == 'Complete'
                                  ? const Color(0xffF5FBF8)
                                  : const Color(0xffFFFAF1),
                              // desired background color
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              entry.paymentStatus,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: entry.paymentStatus == 'Complete'
                                    ? const Color(0xff359A73)
                                    : const Color(0xffCB8A14),
                              ),
                            ),
                          )),
                          DataCell(
                            PopupMenuButton(
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
                                  value: 'done',
                                  child: Text('Done'),
                                ),
                              ],
                              onSelected: (value) {
                                switch (value) {
                                  case 'edit':
                                    // Perform edit action
                                    break;
                                  case 'remove':
                                    // Perform remove action
                                    break;
                                  case 'done':
                                    // Perform done action
                                    break;
                                }
                              },
                              offset: const Offset(10, 40),
                              // Add an offset of 20 pixels to the bottom
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Add rounded edges
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 100,
                                ),
                                child: Text(
                                  "...",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xffBDBDBD),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
