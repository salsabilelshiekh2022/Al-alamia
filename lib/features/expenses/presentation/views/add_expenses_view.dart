import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/components/widgets/custom_page.dart';
import '../cubit/expenses_cubit.dart';
import 'widgets/expenses_form.dart';

class AddExpensesView extends StatelessWidget {
  const AddExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context
          .watch<ExpensesCubit>()
          .state
          .expensesStatus
          .isLoading,
      child: CustomPage(
        title: context.expenses,
        hasActions: false,
        isBack: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        body: ExpensesForm(),
      ),
    );
  }
}
