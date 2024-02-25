import 'package:equatable/equatable.dart';
import 'package:fins_user/Models/searchItems.dart';

abstract class SearchState extends Equatable{
  const SearchState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SearchUninitialized extends SearchState{}

class SearchError extends SearchState{

}

class SearchSuccess extends SearchState{
  final SearchData searchData;
  final bool countLoading;

  const SearchSuccess({required this.searchData,required this.countLoading});
  @override
  // TODO: implement props
  List<Object> get props => [searchData,countLoading];
}

class SearchLoading extends SearchState{}