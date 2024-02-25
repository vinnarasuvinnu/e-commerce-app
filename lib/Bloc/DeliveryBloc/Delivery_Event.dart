import 'package:equatable/equatable.dart';
import 'package:fins_user/Models/DeliveryAddress.dart';
import 'package:fins_user/Models/cartStore.dart';

abstract class DeliveryEvent extends Equatable {
  const DeliveryEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadDeliveryInfo extends DeliveryEvent {}
class PaymentSuccessEvent extends DeliveryEvent {}

class SaveOrderDelivery extends DeliveryEvent {
  final String paymentId;
  final int paymentType;
  final String deliveryAddressInfo;
  final String home_no;
  final String landmark;
  final String orderType;

  // final int storeType;
  final String addressId;

  const SaveOrderDelivery(
      {required this.orderType,
      required this.paymentId,
      required this.paymentType,
      required this.deliveryAddressInfo,
      required this.addressId,
      required this.home_no,
      required this.landmark});

  @override
  // TODO: implement props
  List<Object> get props => [
        paymentId,
        orderType,
        paymentType,
        deliveryAddressInfo,
        addressId,
        landmark,
        home_no
      ];
}

class RazorPayError extends DeliveryEvent {}

class FetchDeliveryAddress extends DeliveryEvent {
  final String deliveryAddress;

  const FetchDeliveryAddress({required this.deliveryAddress});

  @override
  // TODO: implement props
  List<Object> get props => [deliveryAddress];
}

class SaveAddress extends DeliveryEvent {
  final String flatNumber;
  final String landMark;
  final String latitude;
  final String longitude;
  final String mapAddress;
  final String addressType;

  const SaveAddress(
      {required this.flatNumber,
      required this.landMark,
      required this.latitude,
      required this.longitude,
      required this.mapAddress,
      required this.addressType});

  @override
  // TODO: implement props
  List<Object> get props =>
      [flatNumber, landMark, latitude, longitude, mapAddress, addressType];
}

class SaveNewAddress extends DeliveryEvent {
  final String flatNumber;
  final String landMark;
  final String latitude;
  final String longitude;
  final String mapAddress;
  final String addressType;

  const SaveNewAddress(
      {required this.flatNumber,
      required this.landMark,
      required this.latitude,
      required this.longitude,
      required this.mapAddress,
      required this.addressType});

  @override
  // TODO: implement props
  List<Object> get props =>
      [flatNumber, landMark, latitude, longitude, mapAddress, addressType];
}

class FetchSavedDeliveryAddress extends DeliveryEvent {}

class GetAddressCount extends DeliveryEvent {}

class DeleteDeliveryAddress extends DeliveryEvent {
  final int addressId;

  const DeleteDeliveryAddress({required this.addressId});

  @override
  // TODO: implement props
  List<Object> get props => [this.addressId];
}

class EditDeliveryAddress extends DeliveryEvent {
  final DeliveryAddress deliveryAddress;

  const EditDeliveryAddress({required this.deliveryAddress});

  @override
  // TODO: implement props
  List<Object> get props => [deliveryAddress];
}

class SaveEditedAddress extends DeliveryEvent {
  final String landMark;
  final String homeNumber;
  final String addressId;

  const SaveEditedAddress(
      {required this.landMark,
      required this.homeNumber,
      required this.addressId});

  @override
  // TODO: implement props
  List<Object> get props => [landMark, homeNumber, addressId];
}
