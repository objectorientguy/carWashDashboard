import 'package:equatable/equatable.dart';

import '../model/dashboard_model.dart';

abstract class DashboardEvent extends Equatable {}

class GetBookings extends DashboardEvent {
  final String id;

  GetBookings({required this.id});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddEmployee extends DashboardEvent {
  final String id;
  final BookingData bookingData;

  AddEmployee({required this.id, required this.bookingData});

  @override
  List<Object?> get props => throw UnimplementedError();
}
