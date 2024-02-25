
import 'package:equatable/equatable.dart';
import 'package:fins_user/Models/DeliveryAddress.dart';
import 'package:fins_user/Models/User.dart';
import 'package:fins_user/Models/cartStore.dart';

abstract class DeliveryState extends Equatable{
  const DeliveryState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DeliveryUninitialized extends DeliveryState{}

class DeliveryError extends DeliveryState{}

class DeliveryLoaded extends DeliveryState{
  final CartStore store;
  
  // final String razorPayKey;
  const DeliveryLoaded({required this.store});

  @override
  // TODO: implement props
  List<Object> get props => [store,];
}

class DeliveryPaymentLoading extends DeliveryState{}


class DeliveryPaymentSuccess extends DeliveryState{
  // final int storeType;

//   const DeliveryPaymentSuccess({required this.storeType});
//   @override
//   // TODO: implement props
//   List<Object> get props => [storeType];
}

class DeliveryPaymentError extends DeliveryState{}



class DeliveryAddressLoaded extends DeliveryState{
  final String deliveryAddress;
  const DeliveryAddressLoaded({required this.deliveryAddress});
  @override
  // TODO: implement props
  List<Object> get props => [deliveryAddress];
}

class DeliverySavedAddressLoaded extends DeliveryState{

  // final List<DeliveryAddress> deliverAddress;
  // const DeliverySavedAddressLoaded({required this.deliverAddress});

  // @override
  // // TODO: implement props
  // List<Object> get props => [deliverAddress];

}

class EditDeliveryAddressLoaded extends DeliveryState{
  // final DeliveryAddress deliveryAddress;
  // const EditDeliveryAddressLoaded({required this.deliveryAddress});

  // @override
  // // TODO: implement props
  // List<Object> get props => [deliveryAddress];
}


class DeletedAddressState extends DeliveryState{}