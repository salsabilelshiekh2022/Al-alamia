import 'package:alalamia/features/home/data/models/denominations_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/currency_model.dart';

class HomeState extends Equatable {
  final RequestStatus homeStatus;
  final List<CurrencyModel> currenciesList;
  final List<DenominationsModel> denominations;
  const HomeState({
    this.homeStatus = RequestStatus.initial,
    this.currenciesList = const [],
    this.denominations = const [],
  });

  HomeState copyWith({
    RequestStatus? homeStatus,
    List<CurrencyModel>? currenciesList,
    List<DenominationsModel>? denominations,
  }) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
      currenciesList: currenciesList ?? this.currenciesList,
      denominations: denominations ?? this.denominations,
    );
  }

  @override
  List<Object?> get props => [homeStatus, currenciesList, denominations];
}
