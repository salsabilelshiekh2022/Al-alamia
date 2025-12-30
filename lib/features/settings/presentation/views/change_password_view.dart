import 'package:alalamia/core/components/widgets/custom_modal_hub.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/widgets/custom_page.dart';
import '../../../../core/enums/request_status.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import 'widgets/change_password/change_password_form.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomModelProgressIndecator(
      inAsyncCall: context.watch<AuthCubit>().state.authStatus.isLoading,
      child: CustomPage(
        title: context.changePassword,
        hasActions: false,
        isBack: true,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        body: ChangePasswordForm(),
      ),
    );
  }
}

