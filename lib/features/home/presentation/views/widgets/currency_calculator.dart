import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_currency_dropdown.dart';
import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/currency_model.dart';
import '../../../data/models/transfer_currency_request_params.dart';
import '../../cubit/home_state.dart';
import 'calculator_text_field.dart';

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({super.key});

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  late final TextEditingController _amountController;
  late final TextEditingController _resultController;

  CurrencyModel? _fromCurrency;
  CurrencyModel? _toCurrency;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _resultController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _calculateExchangeRate();
    });
  }

  void _onAmountChanged(String value) {
    final homeState = context.read<HomeCubit>().state;
    final double amount = double.tryParse(value) ?? 0;
    final num exchangeRate = homeState.transferCurrency?.exchangePriceUsed ?? 0;
    final result = (amount * exchangeRate).toStringAsFixed(2);
    _resultController.text = result;
  }

  void _onFromCurrencyChanged(CurrencyModel? currency) {
    if (currency == null || _toCurrency == null) return;

    setState(() {
      _fromCurrency = currency;
      _calculateExchangeRate();
    });
  }

  void _onToCurrencyChanged(CurrencyModel? currency) {
    if (currency == null || _fromCurrency == null) return;

    setState(() {
      _toCurrency = currency;
      _calculateExchangeRate();
    });
  }

  void _calculateExchangeRate() {
    if (_fromCurrency == null || _toCurrency == null) return;

    final cubit = context.read<HomeCubit>();
    cubit.transferCurrency(
      transferCurrencyRequestParams: TransferCurrencyRequestParams(
        fromCurrencyId: _fromCurrency!.id!,
        toCurrencyId: _toCurrency!.id!,
      ),
    );
  }

  void _initializeCurrencies(HomeState state) {
    if (state.currenciesList.length >= 2 &&
        _fromCurrency == null &&
        _toCurrency == null) {
      _fromCurrency = state.currenciesList.first;
      _toCurrency = state.currenciesList[1];
      _calculateExchangeRate();
    }
  }

  void _updateResultFromExchangeRate(HomeState state) {
    if (state.transferCurrencyStatus.isSuccess) {
      final double amount = double.tryParse(_amountController.text) ?? 0;
      final num exchangeRate = state.transferCurrency?.exchangePriceUsed ?? 0;
      final result = (amount * exchangeRate).toStringAsFixed(2);
      _resultController.text = result;
    }
  }

  Widget _buildAmountSection(HomeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.amount, style: context.textStyles.font15MediumGrayColor),
        16.verticalSizedBox,
        Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomCurrencyDropdown(
                items: state.currenciesList,
                selectedItem: _fromCurrency,
                onChanged: _onFromCurrencyChanged,
              ),
            ),
            12.horizontalSpace,
            CalculatorTextField(
              controller: _amountController,
              enabled: true,
              onChanged: _onAmountChanged,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDividerWithSwapButton() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Divider(color: Color(0xffE7E7EE), thickness: 1),
        PositionedDirectional(top: -13, child: _buildSwapButton()),
      ],
    );
  }

  Widget _buildSwapButton() {
    return InkWell(
      onTap: _swapCurrencies,
      borderRadius: BorderRadius.circular(19),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          color: context.colors.primaryColor,
        ),
        child: CustomSvgBuilder(
          path: AppAssets.svgsTransfarIcon,
          width: 21,
          height: 21,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  Widget _buildResultSection(HomeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.transeferedAmount,
          style: context.textStyles.font15MediumGrayColor,
        ),
        16.verticalSizedBox,
        Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomCurrencyDropdown(
                items: state.currenciesList,
                selectedItem: _toCurrency,
                onChanged: _onToCurrencyChanged,
              ),
            ),
            12.horizontalSpace,
            CalculatorTextField(controller: _resultController, enabled: false),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        _initializeCurrencies(state);
        _updateResultFromExchangeRate(state);
      },
      builder: (context, state) {
        _initializeCurrencies(state);

        return Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0x11000000),
                blurRadius: 44,
                offset: const Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAmountSection(state),
              35.verticalSpace,
              _buildDividerWithSwapButton(),
              5.verticalSizedBox,
              _buildResultSection(state),
            ],
          ),
        );
      },
    );
  }
}
