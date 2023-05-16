import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/dashboard_model.dart';

class SummaryCards extends StatelessWidget {
  final List<BookingData> bookingData;

  const SummaryCards({Key? key, required this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
        Widget>[
      Expanded(
          child: Container(
              height: MediaQuery.of(context).size.width * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            height: MediaQuery.of(context).size.width * 0.03,
                            width: MediaQuery.of(context).size.width * 0.03,
                            color: const Color(0xffF4F4F4),
                            padding: const EdgeInsets.all(12),
                            child: Image.asset('assets/images/Vector1.png',
                                width: 5, height: 1)))),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Today\'s total bookings',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              color: const Color(0xff828282),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.0595)),
                      const SizedBox(height: 5),
                      Text(bookingData.length.toString(),
                          style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff000000)))
                    ])
              ]))),
      const SizedBox(width: 35),
      Expanded(
          child: Container(
              height: MediaQuery.of(context).size.width * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            height: MediaQuery.of(context).size.width * 0.03,
                            width: MediaQuery.of(context).size.width * 0.03,
                            color: const Color(0xffF4F4F4),
                            padding: const EdgeInsets.all(12),
                            child: Image.asset('assets/images/Vector3.png')))),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text('Today\'s Completed bookings',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              color: const Color(0xff828282),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.0595)),
                      const SizedBox(height: 5),
                      Text('0',
                          style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff000000)))
                    ]))
              ]))),
      const SizedBox(width: 35),
      Expanded(
          child: Container(
              height: MediaQuery.of(context).size.width * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            color: const Color(0xffF4F4F4),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(Icons.watch_later_outlined,
                                size: 28, color: Color(0xff000000))))),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text('Today\'s Pending bookings',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: const Color(0xff828282),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.0595,
                          )),
                      const SizedBox(height: 5),
                      Text(bookingData.length.toString(),
                          style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff000000)))
                    ]))
              ])))
    ]);
  }
}
