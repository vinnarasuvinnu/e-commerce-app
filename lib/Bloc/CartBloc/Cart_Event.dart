import 'package:equatable/equatable.dart';

abstract class CartStoreEvent extends Equatable{
  const CartStoreEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchCartStoreProduct extends CartStoreEvent{
  const FetchCartStoreProduct();


  @override
  // TODO: implement props
  List<Object> get props => [];

}

class ScrollCartStoreProduct extends CartStoreEvent{

}



class AddProductStoreEvent extends CartStoreEvent{
  final int productId;
  const AddProductStoreEvent({required this.productId});
  @override
  // TODO: implement props
  List<Object> get props => [productId];
}



class MinusProductStoreEvent extends CartStoreEvent{
  final int productId;
  const MinusProductStoreEvent({required this.productId});

  @override
  // TODO: implement props
  List<Object> get props => [productId];
}