import 'package:alalamia/features/home/data/models/denominations_model.dart';
import 'package:alalamia/features/home/data/models/transfer_currency_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/currency_model.dart';
import '../../data/models/wallet_model.dart';

class HomeState extends Equatable {
  final RequestStatus homeStatus;
  final RequestStatus denominationsStatus;
  final RequestStatus transferCurrencyStatus;
  final RequestStatus currenciesStatus;
  final List<CurrencyModel> currenciesList;
  final List<WalletModel> walletsList;
  final List<DenominationsModel> denominations;
  final TransferCurrencyModel? transferCurrency;

  static HomeState initial() => const HomeState();

  const HomeState({
    this.homeStatus = RequestStatus.initial,
    this.denominationsStatus = RequestStatus.initial,
    this.currenciesStatus = RequestStatus.initial,
    this.transferCurrencyStatus = RequestStatus.initial,
    this.walletsList = const [],
    this.denominations = const [],
    this.currenciesList = const [],
    this.transferCurrency,
  });

  HomeState copyWith({
    RequestStatus? homeStatus,
    RequestStatus? denominationsStatus,
    RequestStatus? transferCurrencyStatus,
    RequestStatus? currenciesStatus,
    List<WalletModel>? walletsList,
    List<DenominationsModel>? denominations,
    List<CurrencyModel>? currenciesList,
    TransferCurrencyModel? transferCurrency,
  }) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
      denominationsStatus: denominationsStatus ?? this.denominationsStatus,
      transferCurrencyStatus:
          transferCurrencyStatus ?? this.transferCurrencyStatus,
      currenciesStatus: currenciesStatus ?? this.currenciesStatus,
      walletsList: walletsList ?? this.walletsList,
      denominations: denominations ?? this.denominations,
      currenciesList: currenciesList ?? this.currenciesList,
      transferCurrency: transferCurrency ?? this.transferCurrency,
    );
  }

  @override
  List<Object?> get props => [
    homeStatus,
    denominationsStatus,
    currenciesStatus,
    transferCurrencyStatus,
    walletsList,
    denominations,
    currenciesList,
    transferCurrency,
  ];
}
