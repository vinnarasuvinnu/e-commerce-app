import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{
  const SearchEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SearchUserEvent extends SearchEvent{

  final searchController;
  const SearchUserEvent({required this.searchController});
  @override
  // TODO: implement props
  List<Object> get props => [searchController];

}
class AddSearchProduct extends SearchEvent{

  final String productId;
  const AddSearchProduct({required this.productId});
  @override
  // TODO: implement props
  List<Object> get props => [productId];
}

class SubtractSearchProduct extends SearchEvent{

  final String productId;
  const SubtractSearchProduct({required this.productId});
@override
  // TODO: implement props
  List<Object> get props => [productId];

}