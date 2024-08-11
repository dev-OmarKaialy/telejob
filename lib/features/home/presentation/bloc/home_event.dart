part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class IndexJobCategoriesEvent extends HomeEvent {}

class IndexRequestsEvent extends HomeEvent {}

class IndexWorkeresEvent extends HomeEvent {
  final String? cateId;
  const IndexWorkeresEvent({this.cateId});
}

class SendRequestEvent extends HomeEvent {
  final Map<String, dynamic> params;
  const SendRequestEvent({
    required this.params,
  });
}
