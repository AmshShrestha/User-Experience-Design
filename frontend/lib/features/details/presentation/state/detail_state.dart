import 'package:travel_log/features/details/domain/entity/detail_entity.dart';

class DetailState {
  final bool isLoading;
  final String? image;
  final String? error;
  final List<DetailEntity> details;

  DetailState({
    required this.isLoading,
    this.error,
    this.image,
    required this.details,
  });

  factory DetailState.initial() {
    return DetailState(
      isLoading: false,
      error: null,
      image: null,
      details: [],
    );
  }

  DetailState copyWith({
    bool? isLoading,
    String? error,
    List<DetailEntity>? details,
    String? image,
  }) {
    return DetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      image: image ?? this.image,
      details: details ?? this.details,
    );
  }
}
