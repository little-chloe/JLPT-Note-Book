import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/admin/is_logged_in_usecase.dart';
import 'package:note_book_app/domain/usecases/admin/login_with_email_and_password_usecase.dart';
import 'package:note_book_app/presentation/web_version/login/cubits/login_page_web_state.dart';

class LoginPageWebCubit extends Cubit<LoginPageWebState> {
  final LoginWithEmailAndPasswordUsecase _loginWithEmailAndPasswordUsecase =
      getIt<LoginWithEmailAndPasswordUsecase>();
  final IsLoggedInUsecase _isLoggedInUsecase = getIt<IsLoggedInUsecase>();

  LoginPageWebCubit() : super(LoginPageWebInitial());

  void checkIfUserIsLoggedIn() async {
    final result = await _isLoggedInUsecase();
    result.fold(
      (failure) => emit(LoginPageWebInitial()),
      (user) => emit(LoginPageWebSuccess(user: user)),
    );
  }

  void loginWithGoogleAccount(
      {required String email, required String password}) async {
    emit(LoginPageWebLoading());
    final result = await _loginWithEmailAndPasswordUsecase(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(LoginPageWebFailure(message: failure.message)),
      (user) => emit(LoginPageWebSuccess(user: user)),
    );
  }
}
