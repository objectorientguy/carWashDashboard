import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../model/dashboard_model.dart';
import '../model/edit_booking_model.dart';

abstract class DashboardStates extends Equatable {}

class DashboardInitial extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class DashboardLoaded extends DashboardStates {
  final GetDashboardBookingsModel getDashboardBookingsModel;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> washData;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> employeeData;

  DashboardLoaded(
      {required this.getDashboardBookingsModel,
      required this.washData,
      required this.employeeData});

  @override
  List<Object?> get props => [];
}

class DashboardError extends DashboardStates {
  final String message;

  DashboardError({required this.message});

  @override
  List<Object?> get props => [];
}

class AddEmployeeLoading extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class AddEmployeeLoaded extends DashboardStates {
  final EditBookingsModel editBookingsModel;

  AddEmployeeLoaded({required this.editBookingsModel});

  @override
  List<Object?> get props => [];
}

class AddEmployeeError extends DashboardStates {
  final String message;

  AddEmployeeError({required this.message});

  @override
  List<Object?> get props => [];
}
