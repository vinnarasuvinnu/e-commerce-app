

import 'package:equatable/equatable.dart';
import 'package:fins_user/Models/Order.dart';

abstract class OrderState extends Equatable{
  const OrderState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
  
class OrderStateUnInitilized extends OrderState{}
class OrderStateError extends OrderState{}

class OrderStateLoaded extends OrderState{
  final List<ToOrderList> to_order;
  final bool hasReachedMax;
  const OrderStateLoaded({required this.to_order,required this.hasReachedMax});
  @override
  // TODO: implement props
  List<Object> get props => [to_order,hasReachedMax];
}
