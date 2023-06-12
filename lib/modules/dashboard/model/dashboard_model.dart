import 'dart:convert';

GetDashboardBookingsModel getDashboardBookingsModelFromJson(String str) =>
    GetDashboardBookingsModel.fromJson(json.decode(str));

String getDashboardBookingsModelToJson(GetDashboardBookingsModel data) =>
    json.encode(data.toJson());

class GetDashboardBookingsModel {
  final int? status;
  final List<BookingData>? data;
  final String? message;

  GetDashboardBookingsModel({this.status, this.data, this.message});

  factory GetDashboardBookingsModel.fromJson(Map<String, dynamic> json) =>
      GetDashboardBookingsModel(
          status: json["status"],
          data: List<BookingData>.from(
              json["data"].map((x) => BookingData.fromJson(x))),
          message: json["message"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message
      };
}

class BookingData {
  final int? bookingId;
  final int? userContact;
  final int? addressId;
  final String? bookingTime;
  final DateTime? bookingDate;
  final String? services;
  final String? finalAmount;
  final String? paymentMode;
  final dynamic employee;
  final Customer? customer;
  final Address? address;

  BookingData(
      {this.bookingId,
      this.userContact,
      this.addressId,
      this.bookingTime,
      this.bookingDate,
      this.services,
      this.finalAmount,
      this.paymentMode,
      this.employee,
      this.customer,
      this.address});

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
      bookingId: json["booking_id"],
      userContact: json["user_contact"],
      addressId: json["address_id"],
      bookingTime: json["booking_time"],
      bookingDate: DateTime.parse(json["booking_date"]),
      services: json["services"],
      finalAmount: json["final_amount"],
      paymentMode: json["payment_mode"],
      employee: json["employee"],
      customer: Customer.fromJson(json["customer"]),
      address: Address.fromJson(json["address"]));

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "user_contact": userContact,
        "address_id": addressId,
        "booking_time": bookingTime,
        "booking_date":
            "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "services": services,
        "final_amount": finalAmount,
        "payment_mode": paymentMode,
        "employee": employee,
        "customer": customer!.toJson(),
        "address": address!.toJson()
      };
}

class Address {
  final int? addressId;
  final int? userContact;
  final String? addressTitle;
  final String? addressName;
  final String? city;
  final int? pincode;

  Address(
      {this.addressId,
      this.userContact,
      this.addressTitle,
      this.addressName,
      this.city,
      this.pincode});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      addressId: json["address_id"],
      userContact: json["user_contact"],
      addressTitle: json["address_title"],
      addressName: json["address_name"],
      city: json["city"],
      pincode: json["pincode"]);

  Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "user_contact": userContact,
        "address_title": addressTitle,
        "address_name": addressName,
        "city": city,
        "pincode": pincode
      };
}

class Customer {
  final String? customerId;
  final String? customerName;
  final dynamic customerBirthdate;
  final bool? isNewCustomer;

  Customer(
      {this.customerId,
      this.customerName,
      this.customerBirthdate,
      this.isNewCustomer});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
      customerId: json["customer_id"],
      customerName: json["customer_name"],
      customerBirthdate: json["customer_birthdate"],
      isNewCustomer: json["is_new_customer"]);

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_name": customerName,
        "customer_birthdate": customerBirthdate,
        "is_new_customer": isNewCustomer
      };
}
