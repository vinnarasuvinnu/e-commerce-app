import 'package:equatable/equatable.dart';
import 'package:fins_user/Models/bannersData.dart';
import 'package:fins_user/Models/bestSellers.dart';
import 'package:fins_user/Models/homeCategoryProducts.dart';
import 'package:fins_user/Models/searchItems.dart';
import 'package:fins_user/Models/user_location.dart';


abstract class HomeState extends Equatable {
  const HomeState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomeUninitalized extends HomeState {}

class HomeStateError extends HomeState {}

class HomeStateLoaded extends HomeState {
  final String cartCount;
  final bool countLoading;
  final String userAddress;
  // final SearchData searchData;
  final BannerData bannerData;
   final BestSellersData bestSellersData ;
   final HomeCategoryProducts homeCategoryProducts;
   final UserLocationInfo userLocationInfo;
   const HomeStateLoaded({required this.userLocationInfo,required this.cartCount,required this.countLoading,required this.bestSellersData,required this.bannerData,required this.userAddress,required this.homeCategoryProducts});
   @override
  // TODO: implement props
  List<Object> get props => [userLocationInfo,bestSellersData,homeCategoryProducts,countLoading,bannerData,userAddress];
}

class ClosedSession extends HomeState {}
