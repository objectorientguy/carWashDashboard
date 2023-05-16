import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../employee/employee_details.dart';
import '../promotional_banner/promotional_banner.dart';
import '../subscriptions/subscription_plans.dart';
import '../support_details/support_details.dart';
import '../type_of_wash/types_of_wash_screen.dart';

class Management extends StatefulWidget {
  const Management({super.key});

  @override
  _ManagementState createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Management",
                  style: GoogleFonts.inter(
                      color: const Color(0xff333333),
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: MediaQuery.of(context).size.width * 0.01),
              Expanded(
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 1.72,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PromotionalBannerScreen.routeName);
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.star, size: 50),
                                    Text('Promotional Banners')
                                  ]))),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TypesOfWashes()));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.local_car_wash, size: 50),
                                    Text('Types of Washes')
                                  ]))),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SubscriptionPlans()));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.subscriptions, size: 50),
                                    Text('Subscription Plan')
                                  ]))),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EmployeeDetails()));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.person, size: 50),
                                    Text('Employee details')
                                  ]))),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SupportDetails()));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.support_agent, size: 50),
                                    Text('Support Details')
                                  ]))),
                    ]),
              ),
            ],
          )),
    );
  }
}
