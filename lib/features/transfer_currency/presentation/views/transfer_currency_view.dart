import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/general/data/models/fee_details_request_params.dart';
import '../../../home/presentation/views/widgets/calculator/currency_calculator.dart';
import '../../../send_money/presentation/views/widgets/fee_details_card.dart';
import 'widgets/all_denominations_bottom_sheet.dart';
import 'widgets/amount_section.dart';
import 'widgets/client_info_section.dart';
import 'widgets/notes_section.dart';
import 'widgets/total_section.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/cubit/home_state.dart';

class TransferCurrencyView extends StatefulWidget {
  const TransferCurrencyView({super.key});

  @override
  State<TransferCurrencyView> createState() => _TransferCurrencyViewState();
}

class _TransferCurrencyViewState extends State<TransferCurrencyView> {
  late TextEditingController _amountController;
  late TextEditingController _resultController;
  CurrencyModel? _fromCurrency;
  CurrencyModel? _toCurrency;

  @override
  void initState() {
    _amountController = TextEditingController();
    _resultController = TextEditingController();
    context.read<HomeCubit>().getCurrencies();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  void _getFeeDetails() {
    if (_fromCurrency != null && _toCurrency != null) {
      context.read<GeneralCubit>().getFeeDetails(
        params: FeeDetailsRequestParams(
          amount: _amountController.text,
          fromCurrencyId: _fromCurrency!.id!,
          toCurrencyId: _toCurrency!.id!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.currenciesList.isNotEmpty &&
            _fromCurrency == null &&
            _toCurrency == null) {
          setState(() {
            _fromCurrency = state.currenciesList[0];
            _toCurrency = state.currenciesList.length > 1
                ? state.currenciesList[1]
                : state.currenciesList[0];
          });
          _getFeeDetails();
        }
      },
      child: CustomPage(
        title: context.currencyTransfer,
        isBack: true,
        hasActions: false,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClientInfoSection(),
            20.verticalSizedBox,
            CurrencyCalculator(
              title: context.conversionData,
              amountController: _amountController,
              resultController: _resultController,
              onAmountChanged: (val) {
                _getFeeDetails();
              },
              onFromCurrencyChanged: (c) {
                setState(() => _fromCurrency = c);
                _getFeeDetails();
              },
              onToCurrencyChanged: (c) {
                setState(() => _toCurrency = c);
                _getFeeDetails();
              },
              boxShadow: [
                BoxShadow(
                  color: Color(0x336E0084),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            20.verticalSizedBox,
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _resultController,
              builder: (_, value, __) => TotalSection(
                fromCurrency: _fromCurrency!,
                toCurrency: _toCurrency!,
                total: value.text,
                exchangePrice: 0.0,
              ),
            ),
            20.verticalSizedBox,
            AmountSection(),
            20.verticalSizedBox,
            NotesSection(),
            20.verticalSizedBox,
            FeeDetailsCard(),
            24.verticalSizedBox,
            MainButton(
              title: context.confirm,
              onTap: () {
                GlobalUiUtils.showBottomSheet(
                  context,
                  child: BlocProvider.value(
                    value: getIt<GeneralCubit>(),
                    child: AllDenominationsBottomSheet(),
                  ),
                );
              },
            ),
            40.verticalSizedBox,
          ],
        ),
      ),
    );
  }
}
