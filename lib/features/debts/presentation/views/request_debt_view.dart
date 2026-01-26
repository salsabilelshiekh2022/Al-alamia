import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/debts/presentation/views/widgets/request_debt_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubit/debts_cubit.dart';

class RequestDebtView extends StatelessWidget {
  const RequestDebtView({super.key, required this.debetType});
  final DebetsTypeEnum debetType;
 
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context.watch<DebtsCubit>().state.debtsStatus.isLoading,
      child: CustomPage(
        title: "${context.requestDebt} ${debetType == DebetsTypeEnum.debt_inside ? "(${context.inside})" : "(${context.outside})"}",
        hasActions: false,
        isBack: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        body: RequestDebtForm(
          debetType: debetType,
        ),
      ),
    );
  }
}
