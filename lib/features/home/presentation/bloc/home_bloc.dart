import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telejob/core/utils/toaster.dart';
import 'package:telejob/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:telejob/features/home/data/models/job_categories.dart';
import 'package:telejob/features/home/data/models/requests_model.dart';
import 'package:telejob/features/home/data/models/workers_model.dart';
import 'package:telejob/features/home/data/repositories/home_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<IndexJobCategoriesEvent>((event, emit) async {
      emit(state.copyWith(indexJobs: CubitStatus.loading));
      final result = await HomeRepo().indexJobCateogries();
      result.fold((l) {
        emit(state.copyWith(indexJobs: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(
            indexJobs: CubitStatus.success, categories: r.jobCategories));
      });
    });
    on<IndexWorkeresEvent>((event, emit) async {
      emit(state.copyWith(indexWorkers: CubitStatus.loading));
      final result = await HomeRepo().indexWorkers({
        if (event.cateId != null) "jobCategoryId": event.cateId!,
      });
      result.fold((l) {
        emit(state.copyWith(indexWorkers: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(
            indexWorkers: CubitStatus.success, workers: r.workers));
      });
    });
    on<IndexRequestsEvent>((event, emit) async {
      emit(state.copyWith(indexRequests: CubitStatus.loading));
      final result = await HomeRepo().indexRequests();
      result.fold((l) {
        emit(state.copyWith(indexRequests: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(
            indexRequests: CubitStatus.success, request: r.requests));
      });
    });
    on<SendRequestEvent>((event, emit) async {
      emit(state.copyWith(sendRequest: CubitStatus.loading));
      final result = await HomeRepo()
          .createRequest(event.params['body'], event.params['images']);
      result.fold((l) {
        emit(state.copyWith(sendRequest: CubitStatus.failed));
        Toaster.showToast(l.message);
      }, (r) {
        emit(state.copyWith(
          sendRequest: CubitStatus.success,
        ));
        add(IndexRequestsEvent());
      });
    });
  }
}
