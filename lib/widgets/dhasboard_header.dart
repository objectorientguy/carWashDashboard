// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../modules/dashboard/dashboard.dart';
import '../modules/dashboard/management.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const Management(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(38, 30, 20, 10),
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _selectedIndex == 0;
                  },
                  child: SizedBox(
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/Vector.png'),
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Car Wash',
                          style: GoogleFonts.inter(
                            color: const Color(0xff333333),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: Text(
                      'Dashboard',
                      style: GoogleFonts.inter(
                        color: _selectedIndex == 0
                            ? const Color(0xff000000)
                            : const Color(0xffBDBDBD),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: Text(
                      'Management',
                      style: GoogleFonts.inter(
                        color: _selectedIndex == 1
                            ? const Color(0xff000000)
                            : const Color(0xffBDBDBD),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 14, color: Color(0xFFF2F2F2)),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }
}
