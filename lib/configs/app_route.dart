import 'package:car_wash_dashboard/modules/dashboard/dashboard_top_bar.dart';
import 'package:car_wash_dashboard/modules/promotional_banner/promotional_banner.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case PromotionalBannerScreen.routeName:
        return _materialRoute(const PromotionalBannerScreen());

      default:
        return _materialRoute(const DashboardScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
