import '../../../utilities/api_provider.dart';
import '../model/dashboard_model.dart';
import '../model/edit_booking_model.dart';
import 'bookings_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final ApiProvider apiProvider;

  const BookingRepositoryImpl({required this.apiProvider});

  @override
  Future<GetDashboardBookingsModel> fetchBookings(String id) async {
    try {
      final response = await apiProvider
          .get("https://carwashdev.onrender.com/getBookings?id=$id");
      return GetDashboardBookingsModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<EditBookingsModel> editBooking(String id, Map editBookingMap) async {
    try {
      final response = await apiProvider
          .put("https://carwashdev.onrender.com/editBookings?id=$id", editBookingMap);
      return EditBookingsModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
