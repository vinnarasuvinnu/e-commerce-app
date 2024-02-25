

import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchOrders extends OrderEvent{}

class ScrollOrders extends OrderEvent{}