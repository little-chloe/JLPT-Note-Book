import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/login/cubits/login_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/login/cubits/login_page_web_state.dart';
import 'package:note_book_app/presentation/web_version/login/widgets/login_button.dart';
import 'package:note_book_app/presentation/web_version/login/widgets/text_input_field.dart';

class LoginPageWeb extends StatefulWidget {
  const LoginPageWeb({super.key});

  @override
  State<LoginPageWeb> createState() => _LoginPageWebState();
}

class _LoginPageWebState extends State<LoginPageWeb> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late LoginPageWebCubit _loginPageWebCubit;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginPageWebCubit = getIt<LoginPageWebCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLoginEmailAndPassword() {
    final email = _emailController.value.text.toLowerCase().trim();
    final password = _passwordController.value.text;
    _loginPageWebCubit.loginWithGoogleAccount(
      email: email,
      password: password,
    );
  }

  void _handleShowOrHidePassword() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginPageWebCubit>(
      create: (context) => _loginPageWebCubit,
      child: Scaffold(
        body: Center(
          child: BlocListener<LoginPageWebCubit, LoginPageWebState>(
            listener: (context, state) {
              if (state is LoginPageWebSuccess) {
                if (state.user.role == 'admin') {
                  context.go('/admin');
                }
              }
            },
            child: Stack(
              children: [
                ResponsiveUtil.isDesktop(context)
                    ? _desktopRender(context)
                    : _mobileAndTabletRender(context),
                ResponsiveUtil.isDesktop(context)
                    ? BlocBuilder<LoginPageWebCubit, LoginPageWebState>(
                        builder: (context, state) {
                          if (state is LoginPageWebFailure) {
                            return Container(
                              margin: const EdgeInsets.only(top: 32),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.failureColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              width: 480,
                              child: Text(
                                state.message,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopRender(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInputField(
            controller: _emailController,
            hintText: "Email",
          ),
          const SizedBox(height: 16),
          TextInputField(
            controller: _passwordController,
            hintText: "Password",
            obcureText: true,
          ),
          const SizedBox(height: 16),
          BlocBuilder<LoginPageWebCubit, LoginPageWebState>(
            builder: (context, state) {
              return LoginButton(
                onPressed: _handleLoginEmailAndPassword,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _mobileAndTabletRender(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      "Chỉ hỗ trợ trình duyệt web trên máy tính",
      style: TextStyle(
        fontSize: ResponsiveUtil.isTablet(context) ? 20 : 16,
        color: AppColors.kF8EDE3,
      ),
    );
  }
}
