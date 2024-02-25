
import 'package:equatable/equatable.dart';
import 'package:fins_user/Models/cartProduct.dart';
import 'package:fins_user/Models/cartStore.dart';

abstract class CartStoreState extends Equatable{
  const CartStoreState();

  @override
  // TODO: implement props
  List<Object> get props => [];

  get product => null;

  get hasReachedMax => null;
}

class CartStoreUninitialized extends CartStoreState{}

class CartStoreError extends CartStoreState{}

class CartStoreLoaded extends CartStoreState{
  final List<ProductList> product;
  final bool hasReachedMax;
  final bool countLoading;
  const CartStoreLoaded({required this.product,required this.hasReachedMax,required this.countLoading});


  @override
  // TODO: implement props
  List<Object> get props => [product,hasReachedMax,countLoading];
}