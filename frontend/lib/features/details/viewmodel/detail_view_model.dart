import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entity/detail_entity.dart';
import '../domain/use_case/detail_usecase.dart';
import '../presentation/state/detail_state.dart';

final detailViewModelProvider =
    StateNotifierProvider<DetailViewModel, DetailState>(
  (ref) {
    return DetailViewModel(
      ref.watch(detailUseCaseProvider),
    );
  },
);

class DetailViewModel extends StateNotifier<DetailState> {
  final DetailUseCase _detailUseCase;

  DetailViewModel(this._detailUseCase) : super(DetailState.initial()) {
    getAllDetails();
  }

  uploadCoverPhoto(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _detailUseCase.uploadCoverPhoto(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null, image: r);
      },
    );
  }

  addDetails(BuildContext context, DetailEntity details) async {
    state = state.copyWith(isLoading: true);
    var data = await _detailUseCase.addDetails(details);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  deleteDetails(BuildContext context, DetailEntity details) async {
    state.copyWith(isLoading: true);
    var data = await _detailUseCase.deleteDetails(details.tripId!);

    data.fold(
      (l) {
        // showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.details.remove(details);
        state = state.copyWith(isLoading: false, error: null);
        // showSnackBar(
        // message: 'Course delete successfully',
        // context: context,
        // );
      },
    );
  }

  getAllDetails() async {
    state = state.copyWith(isLoading: true);
    var data = await _detailUseCase.getAllDetails();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, details: r, error: null),
    );
  }
}
