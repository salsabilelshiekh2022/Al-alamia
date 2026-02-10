import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../core/general/data/models/fee_details_request_params.dart';
import '../../../../core/routes/routes.dart';
import '../../../home/presentation/views/widgets/calculator/currency_calculator.dart';
import '../../../send_money/presentation/views/widgets/fee_details_card.dart';
import '../../data/models/transfer_money_data_params.dart';
import 'widgets/amount_section.dart';
import 'widgets/client_info_section.dart';
import 'widgets/notes_section.dart';
import 'widgets/total_section.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/cubit/home_state.dart';

class TransferMoneyView extends StatefulWidget {
  const TransferMoneyView({super.key});

  @override
  State<TransferMoneyView> createState() => _TransferMoneyViewState();
}

class _TransferMoneyViewState extends State<TransferMoneyView> {
  // Currency calculator controllers
  late TextEditingController _amountController;
  late TextEditingController _resultController;
  
  // Client info controllers
  late TextEditingController _phoneController;
  late TextEditingController _nameController;
  
  // Amount by char controller
  late TextEditingController _amountByCharController;
  
  // Notes controller
  late TextEditingController _notesController;
  
  CurrencyModel? _fromCurrency;
  CurrencyModel? _toCurrency;

  /// The from-currency name that must always be selected.
  static const _lockedFromCurrencyName = 'دينار ليبي';

  @override
  void initState() {
    _amountController = TextEditingController();
    _resultController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
    _amountByCharController = TextEditingController();
    _notesController = TextEditingController();
    context.read<HomeCubit>().getCurrencies();
    super.initState();
  }

  /// Finds the "دينار ليبي" currency from the loaded list.
  CurrencyModel? _findLibyanDinar(List<CurrencyModel> currencies) {
    try {
      return currencies.firstWhere(
        (c) => c.name == _lockedFromCurrencyName,
      );
    } catch (_) {
      return currencies.isNotEmpty ? currencies.first : null;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _resultController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _amountByCharController.dispose();
    _notesController.dispose();
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

  /// Validate all required fields and navigate to denomination view
  void _handleConfirm() {
    // Validate required fields
    if (_phoneController.text.trim().isEmpty) {
      _showError('يرجى إدخال رقم الهاتف');
      return;
    }
    if (_nameController.text.trim().isEmpty) {
      _showError('يرجى إدخال اسم العميل');
      return;
    }
    if (_amountController.text.trim().isEmpty) {
      _showError('يرجى إدخال المبلغ');
      return;
    }
    if (_amountByCharController.text.trim().isEmpty) {
      _showError('يرجى إدخال المبلغ بالحروف');
      return;
    }
    if (_fromCurrency == null || _toCurrency == null) {
      _showError('يرجى اختيار العملات');
      return;
    }

    // Create transfer data params
    final transferData = TransferMoneyDataParams(
      clientPhone: _phoneController.text.trim(),
      clientName: _nameController.text.trim(),
      fromCurrencyId: _fromCurrency!.id!,
      toCurrencyId: _toCurrency!.id!,
      amount: _amountController.text.trim(),
      totalPrice: _resultController.text.trim(),
      amountByChar: _amountByCharController.text.trim(),
      note: _notesController.text.trim().isNotEmpty 
          ? _notesController.text.trim() 
          : null,
    );

    // Navigate to denomination view with data
    context.pushNamed(
      Routes.addAmountByDenominationView,
      arguments: transferData,
    );
  }

  void _showError(String message) {
    AppSnackBar.showSnackBar(
      context: context,
      message: message,
      state: SnackBarStates.error,
    );
  }

  /// Initializes currencies if not already set.
  void _initializeCurrencies(List<CurrencyModel> currenciesList) {
    if (currenciesList.isEmpty ||
        _fromCurrency != null ||
        _toCurrency != null) {
      return;
    }

    final libyanDinar = _findLibyanDinar(currenciesList);
    _fromCurrency = libyanDinar;
    _toCurrency = currenciesList.firstWhere(
      (c) => c.id != libyanDinar?.id,
      orElse: () => currenciesList.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.currenciesList.isNotEmpty &&
            _fromCurrency == null &&
            _toCurrency == null) {
          setState(() {
            _initializeCurrencies(state.currenciesList);
          });
          _getFeeDetails();
        }
      },
      builder: (context, state) {
        // Also try to initialize on build in case the listener missed it
        if (_fromCurrency == null && _toCurrency == null) {
          _initializeCurrencies(state.currenciesList);
        }

        return CustomPage(
        title: context.currencyTransfer,
        isBack: true,
        hasActions: false,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClientInfoSection(
              phoneController: _phoneController,
              nameController: _nameController,
            ),
            20.verticalSizedBox,
            CurrencyCalculator(
              title: context.conversionData,
              amountController: _amountController,
              resultController: _resultController,
              isFromCurrencyLocked: true,
              initialFromCurrency: _fromCurrency,
              onAmountChanged: (val) {
                _getFeeDetails();
              },
              onFromCurrencyChanged: (c) {
                // From currency is locked — no action needed.
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
            if (_fromCurrency != null && _toCurrency != null)
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
            AmountSection(
              amountByCharController: _amountByCharController,
            ),
            20.verticalSizedBox,
            NotesSection(
              notesController: _notesController,
            ),
            20.verticalSizedBox,
            FeeDetailsCard(),
            24.verticalSizedBox,
            MainButton(
              title: context.confirm,
              onTap: _handleConfirm,
            ),
            40.verticalSizedBox,
          ],
        ),
      );
      },
    );
  }
}