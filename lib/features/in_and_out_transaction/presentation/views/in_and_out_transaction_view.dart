import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubit/in_and_out_transaction_cubit.dart';
import 'widgets/in_and_out_transaction_form.dart';

class InAndOutTransactionView extends StatelessWidget {
  const InAndOutTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context
          .watch<InAndOutTransactionCubit>()
          .state
          .inAndOutTransactionStatus
          .isLoading,
      child: CustomPage(
        title:context.inOut,
        hasActions: false,
        isBack: true,
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        body: InAndOutTransactionForm(),
      ),
    );
  }
}

