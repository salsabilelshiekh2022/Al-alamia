import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/enums/debets_enum.dart';
import '../../../../core/enums/request_status.dart';
import '../cubit/debts_cubit.dart';
import 'widgets/pay_debt_form.dart';

class PaymentDebtView extends StatelessWidget {
  const PaymentDebtView({super.key, required this.debtType});
   final DebetsTypeEnum debtType;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: context.watch<DebtsCubit>().state.debtsStatus.isLoading,
      child: CustomPage(
        title: "${context.paymentDebt} ${debtType == DebetsTypeEnum.debt_inside ? "(${context.inside})" : "(${context.outside})"}",
        hasActions: false,
        isBack: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        body: PayDebtForm(
          debtType: debtType,
        ),
      ),
    );
  }
}
