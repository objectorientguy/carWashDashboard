import '../model/dashboard_model.dart';
import '../model/edit_booking_model.dart';

abstract class BookingRepository {
  Future<GetDashboardBookingsModel> fetchBookings(String id);

  Future<EditBookingsModel> editBooking(String id, Map editBookingMap);
}
