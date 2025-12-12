import 'package:alalamia/core/components/widgets/card_with_purple_shadow.dart';
import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/custom_text_field_with_label.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/general/data/models/fee_details_request_params.dart';
import '../../../../core/utils/validator.dart';
import '../../../../generated/app_assets.dart';
import '../../../home/presentation/views/widgets/calculator/currency_calculator.dart';
import '../../../send_money/presentation/views/widgets/fee_details_card.dart';
import 'widgets/client_info_section.dart';
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
            MainButton(title: context.confirm, onTap: () {}),
            40.verticalSizedBox,
          ],
        ),
      ),
    );
  }
}

class AmountSection extends StatelessWidget {
  const AmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.amount,
            style: context.textStyles.font17SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: TextEditingController(),
            label: context.amountByChar,
            hintText: context.amountHint,
            isRequired: true,
            prefixWidget: AppAssets.svgsDollarIcon,
            keyboardType: TextInputType.text,
            validator: (val) => Validator.validateAnotherField(val, context),
          ),
        ],
      ),
    );
  }
}

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldWithLabel(
            controller: TextEditingController(),
            label: context.addNotes,
            hintText: context.notesHint,
            maxLines: 3,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
