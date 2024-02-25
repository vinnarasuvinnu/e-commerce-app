import 'package:equatable/equatable.dart';
import 'package:fins_user/Models/couponList.dart';
import 'package:fins_user/Models/offersList.dart';


abstract class OfferState extends Equatable{
  const OfferState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OfferUninitialized extends OfferState{}

class OfferError extends OfferState{}

class OfferLoaded extends OfferState{
  final OffersData offersData;
  final bool countLoading;

  const OfferLoaded({required this.offersData,required this.countLoading});
  @override
  // TODO: implement props
  List<Object> get props => [offersData,countLoading];
}

