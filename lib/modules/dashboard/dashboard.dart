// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:intl/intl.dart';

import 'bloc/bloc.dart';
import 'bloc/events.dart';
import 'bloc/states.dart';
import 'dashboard_summary_cards.dart';
import 'dashboard_table.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime? _selectedDate;

  @override
  void initState() {
    context
        .read<DashboardBloc>()
        .add(GetBookings(id: DateFormat("yyyy-MM-dd").format(DateTime.now())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.width * 0.01),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Car Wash Dashboard',
                    style: GoogleFonts.inter(
                        color: const Color(0xff333333),
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xff606CCB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.07,
                            MediaQuery.of(context).size.width * 0.03)),
                    child: Text('New Booking',
                        style: GoogleFonts.inter(
                            color: const Color(0xffFFFFFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w400)))
              ]),
          SizedBox(height: MediaQuery.of(context).size.width * 0.025),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
                width: MediaQuery.of(context).size.width * 0.1,
                child: OutlinedButton(
                  onPressed: () async {
                    final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate.toString() == "null"
                          ? DateTime.now()
                          : _selectedDate!,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2024),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                            data: ThemeData.light().copyWith(
                              buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.normal,
                              ),
                            ),
                            child: child!);
                      },
                    );
                    if (selectedDate != null && selectedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = selectedDate;
                      });
                      context.read<DashboardBloc>().add(GetBookings(
                          id: "${selectedDate.year.toString().padLeft(4, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}"));
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: const Color(0xffffffff),
                      side: const BorderSide(color: Color(0xffe0e0e0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          _selectedDate.toString() == "null"
                              ? 'Today'
                              : DateFormat('dd MMMM, yyyy')
                                  .format(_selectedDate!),
                          style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.008,
                              color: const Color(0xff333333))),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: const Color(0xffe0e0e0),
                        size: MediaQuery.of(context).size.width * 0.016,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
                child: OutlinedButton(
                    onPressed: () {
                      context.read<DashboardBloc>().add(GetBookings(id: ""));
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: const Color(0xffffffff),
                        side: const BorderSide(color: Color(0xffe0e0e0))),
                    child: Text("All Bookings",
                        style: GoogleFonts.inter(
                            fontSize: MediaQuery.of(context).size.width * 0.008,
                            color: const Color(0xff333333)))),
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.025),
          BlocConsumer<DashboardBloc, DashboardStates>(
              builder: (context, state) {
            if (state is DashboardLoading) {
              return const CircularProgressIndicator();
            } else if (state is AddEmployeeLoading) {
              return const CircularProgressIndicator();
            } else if (state is DashboardLoaded) {
              if (state.getDashboardBookingsModel.data!.isNotEmpty) {
                return Expanded(
                  child: Column(children: [
                    SummaryCards(
                        bookingData: state.getDashboardBookingsModel.data!),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: DashboardTable(
                            bookingData: state.getDashboardBookingsModel.data!,
                            washData: state.washData,
                            employeeData: state.employeeData),
                      ),
                    )
                  ]),
                );
              } else {
                return Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFDADADA)),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                              height: MediaQuery
                                                          .of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              color: const Color(0xffF4F4F4),
                                              padding: const EdgeInsets.all(12),
                                              child: Image.asset(
                                                'assets/images/Vector1.png',
                                                width: 5,
                                                height: 1,
                                              )))),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Today\'s total bookings',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            color: const Color(0xff828282),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.0595,
                                          )),
                                      const SizedBox(height: 5),
                                      Text(
                                          state.getDashboardBookingsModel.data!
                                              .length
                                              .toString(),
                                          style: GoogleFonts.inter(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff000000))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 35),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFDADADA)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              8),
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              color: const Color(0xffF4F4F4),
                                              padding: const EdgeInsets.all(12),
                                              child: Image.asset(
                                                  'assets/images/Vector3.png')))),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Today\'s Completed bookings',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color: const Color(0xff828282),
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.0595,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '0',
                                            style: GoogleFonts.inter(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xff000000)),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 35),
                          Expanded(
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.05,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFDADADA)),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                                color: const Color(0xffF4F4F4),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: const Icon(
                                                    Icons.watch_later_outlined,
                                                    size: 28,
                                                    color:
                                                        Color(0xff000000))))),
                                    const SizedBox(width: 16),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                          Text('Today\'s Pending bookings',
                                              style: GoogleFonts.inter(
                                                fontSize: 10,
                                                color: const Color(0xff828282),
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.0595,
                                              )),
                                          const SizedBox(height: 5),
                                          Text(
                                              state.getDashboardBookingsModel
                                                  .data!.length
                                                  .toString(),
                                              style: GoogleFonts.inter(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff000000)))
                                        ]))
                                  ])))
                        ]),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const Text("No bookings"),
                  ],
                );
              }
            } else {
              return Container();
            }
          }, listener: (BuildContext context, state) {
            if (state is AddEmployeeLoaded) {
              context.read<DashboardBloc>().add(GetBookings(
                  id: (_selectedDate != null)
                      ? "${_selectedDate!.year.toString().padLeft(4, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}"
                      : ""));
            }
            if (state is AddEmployeeError) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          child:
                              const Text("Something went wrong!\nPlease Try again!")),
                    );
                  });
              context.read<DashboardBloc>().add(GetBookings(
                  id: (_selectedDate != null)
                      ? "${_selectedDate!.year.toString().padLeft(4, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}"
                      : ""));
            }
          }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02)
        ],
      ),
    );
  }
}
