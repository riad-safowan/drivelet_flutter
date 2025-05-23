import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/usecases/get_user_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfile getUserProfile;

  ProfileBloc({
    required this.getUserProfile,
  }) : super(ProfileInitial()) {
    on<GetProfileRequested>(_onGetProfileRequested);
  }

  Future<void> _onGetProfileRequested(
      GetProfileRequested event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());

    final result = await getUserProfile(NoParams());

    result.fold(
          (failure) => emit(ProfileError(failure.message)),
          (profile) => emit(ProfileLoaded(profile)),
    );
  }
}