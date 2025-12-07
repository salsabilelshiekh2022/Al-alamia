import 'package:equatable/equatable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/currency_model.dart';

class HomeState extends Equatable {
  final RequestStatus homeStatus;
  final List<CurrencyModel> currenciesList;
  const HomeState({
    this.homeStatus = RequestStatus.initial,
    this.currenciesList = const [],
  });

  HomeState copyWith({
    RequestStatus? homeStatus,
    List<CurrencyModel>? currenciesList,
  }) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
      currenciesList: currenciesList ?? this.currenciesList,
    );
  }

  @override
  List<Object?> get props => [homeStatus, currenciesList];
}