import 'package:travel_log/features/auth/domain/entity/user_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final List<UserEntity> user;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    required this.user,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      user: [],
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    List<UserEntity>? user,
  }) {
    return AuthState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        imageName: imageName ?? this.imageName,
        user: user ?? this.user);
  }
}
