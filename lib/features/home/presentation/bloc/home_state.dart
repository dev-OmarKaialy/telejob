part of 'home_bloc.dart';

class HomeState {
  final CubitStatus indexRequests;
  final CubitStatus indexJobs;
  final CubitStatus indexWorkers;
  final List<JobCategory> categories;
  final List<WorkersModel> workers;
  final List<RequestModel> request;
  const HomeState({
    this.indexRequests = CubitStatus.init,
    this.indexJobs = CubitStatus.init,
    this.indexWorkers = CubitStatus.init,
    this.categories = const [],
    this.workers = const [],
    this.request = const [],
  });

  HomeState copyWith({
    CubitStatus? indexRequests,
    CubitStatus? indexJobs,
    CubitStatus? indexWorkers,
    List<JobCategory>? categories,
    List<WorkersModel>? workers,
    List<RequestModel>? request,
  }) {
    return HomeState(
      indexRequests: indexRequests ?? this.indexRequests,
      indexJobs: indexJobs ?? this.indexJobs,
      indexWorkers: indexWorkers ?? this.indexWorkers,
      categories: categories ?? this.categories,
      workers: workers ?? this.workers,
      request: request ?? this.request,
    );
  }
}
