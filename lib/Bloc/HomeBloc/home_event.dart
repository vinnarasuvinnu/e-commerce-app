import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchHomeScreen extends HomeEvent {}
class FetchReHome extends HomeEvent{}
class FetchReStoreLocation extends HomeEvent {}

class FetchStoreLocation extends HomeEvent{
  final String token;
  const FetchStoreLocation({required this.token});

  @override
  // TODO: implement props
  List<Object> get props => [token];
}

class FetchCategoryEvent extends HomeEvent{
  final String id;
  const FetchCategoryEvent({required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class AddProduct extends HomeEvent{

  final String productId;
  const AddProduct({required this.productId});
}
class AddMenuProduct extends HomeEvent{
  final String categoryId;

  final String productId;
  const AddMenuProduct({required this.productId,required this.categoryId});
}

class SubtractProduct extends HomeEvent{

  final String productId;
  const SubtractProduct({required this.productId});
}
class SubtractMenuProduct extends HomeEvent{

final String categoryId;
  final String productId;
  const SubtractMenuProduct({required this.productId,required this.categoryId});
}

class HomeLocationError extends HomeEvent{}

class SearchScreen extends HomeEvent {}


