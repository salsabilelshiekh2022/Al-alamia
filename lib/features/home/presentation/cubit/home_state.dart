import 'package:alalamia/features/home/data/models/denominations_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/currency_model.dart';
import '../../data/models/wallet_model.dart';

class HomeState extends Equatable {
  final RequestStatus homeStatus;
  final RequestStatus denominationsStatus;
  final RequestStatus currenciesStatus;
  final List<CurrencyModel> currenciesList;
  final List<WalletModel> walletsList;
  final List<DenominationsModel> denominations;
  const HomeState({
    this.homeStatus = RequestStatus.initial,
    this.denominationsStatus = RequestStatus.initial,
    this.currenciesStatus = RequestStatus.initial,
    this.walletsList = const [],
    this.denominations = const [],
    this.currenciesList = const [],
  });

  HomeState copyWith({
    RequestStatus? homeStatus,
    RequestStatus? denominationsStatus,
    RequestStatus? currenciesStatus,
    List<WalletModel>? walletsList,
    List<DenominationsModel>? denominations,
    List<CurrencyModel>? currenciesList,
  }) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
      denominationsStatus: denominationsStatus ?? this.denominationsStatus,
      currenciesStatus: currenciesStatus ?? this.currenciesStatus,
      walletsList: walletsList ?? this.walletsList,
      denominations: denominations ?? this.denominations,
      currenciesList: currenciesList ?? this.currenciesList,
    );
  }

  @override
  List<Object?> get props => [
    homeStatus,
    denominationsStatus,
    currenciesStatus,
    walletsList,
    denominations,
    currenciesList,
  ];
}
