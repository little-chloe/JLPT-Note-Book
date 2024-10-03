import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_web_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_side_bar.dart';

class AdminPageWeb extends StatelessWidget {
  const AdminPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminPageWebCubit>(
      create: (context) => getIt<AdminPageWebCubit>()..checkIfUserIsLoggedIn(),
      child: Scaffold(
        body: ResponsiveUtil.isDesktop(context)
            ? _desktopRender(context)
            : _mobileAndTabletRender(context),
      ),
    );
  }

  Widget _desktopRender(BuildContext context) {
    return BlocConsumer<AdminPageWebCubit, AdminPageWebState>(
      listener: (context, state) {
        if (state is AdminPageWebUserNotLoggedIn) {
          context.go('/login');
        }
      },
      builder: (BuildContext context, AdminPageWebState state) {
        if (state is AdminPageWebInitial) {
          return Row(
            children: [
              const AdminPageSideBar(),
              Expanded(
                child: Container(),
              ),
            ],
          );
        }
        if (state is AdminPageWebLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.kDFD3C3,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _mobileAndTabletRender(BuildContext context) {
    return Center(
      child: Text(
        textAlign: TextAlign.center,
        "Chỉ hỗ trợ trình duyệt web trên máy tính",
        style: TextStyle(
          fontSize: ResponsiveUtil.isTablet(context) ? 20 : 16,
          color: AppColors.kF8EDE3,
        ),
      ),
    );
  }
}
