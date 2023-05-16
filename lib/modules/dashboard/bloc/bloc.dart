import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_module.dart';
import '../model/dashboard_model.dart';
import '../model/edit_booking_model.dart';
import '../repository/bookings_repository.dart';
import 'events.dart';
import 'states.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardStates> {
  final BookingRepository _bookingRepository = getIt<BookingRepository>();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  DashboardStates get initialState => DashboardInitial();

  DashboardBloc() : super(DashboardInitial()) {
    on<GetBookings>(_fetchBookings);
    on<AddEmployee>(_addEmployee);
  }

  FutureOr<void> _fetchBookings(
      GetBookings event, Emitter<DashboardStates> emit) async {
    emit(DashboardLoading());
    // try {
      QuerySnapshot<Map<String, dynamic>> washData =
          await fireStore.collection("typeOfWashes").get();
      QuerySnapshot<Map<String, dynamic>> employeeData =
          await fireStore.collection("employeeDetails").get();
      GetDashboardBookingsModel getDashboardBookingsModel =
          await _bookingRepository.fetchBookings(event.id);
      emit(DashboardLoaded(
          getDashboardBookingsModel: getDashboardBookingsModel,
          washData: washData.docs,
          employeeData: employeeData.docs));
      log("Bloc DashboardLoaded");
    // } catch (e) {
    //   log('Error in DashboardError --> $e');
    //   emit(DashboardError(message: e.toString()));
    // }
  }

  FutureOr<void> _addEmployee(
      AddEmployee event, Emitter<DashboardStates> emit) async {
    emit(AddEmployeeLoading());
    // try {
      Map editBookingMap = {
        "booking_time": event.bookingData.bookingTime.toString(),
        "services": event.bookingData.services.toString(),
        "payment_mode": event.bookingData.paymentMode.toString(),
        "user_contact": event.bookingData.userContact.toString(),
        "address_id": event.bookingData.addressId.toString(),
        "booking_date":
        "${event.bookingData.bookingDate!.year.toString().padLeft(4, '0')}-${event.bookingData.bookingDate!.month.toString().padLeft(2, '0')}-${event.bookingData.bookingDate!.day.toString().padLeft(2, '0')}",


        "final_amount": event.bookingData.finalAmount.toString(),
        "employee": event.id
      };
      EditBookingsModel editBookingsModel =
          await _bookingRepository.editBooking(event.bookingData.bookingId.toString(), editBookingMap);
      if (editBookingsModel.status == 200) {
        emit(AddEmployeeLoaded(editBookingsModel: editBookingsModel));
      } else {
        emit(AddEmployeeError(message: "Something Went Wrong"));
      }
      log("Bloc AddEmployeeLoaded");
    // } catch (e) {
    //   log('Error in AddEmployeeError --> $e');
    //   emit(AddEmployeeError(message: e.toString()));
    // }
  }
}
