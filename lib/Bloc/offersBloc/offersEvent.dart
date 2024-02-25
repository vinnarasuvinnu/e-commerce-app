import 'package:equatable/equatable.dart';

abstract class OfferEvent extends Equatable{
  const OfferEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchOffers extends OfferEvent{


}


class AddOfferProduct extends OfferEvent{

  final String productId;
  const AddOfferProduct({required this.productId});
  @override
  // TODO: implement props
  List<Object> get props => [productId];
}

class SubtractOfferProduct extends OfferEvent{

  final String productId;
  const SubtractOfferProduct({required this.productId});
  @override
  // TODO: implement props
  List<Object> get props => [productId];

}


