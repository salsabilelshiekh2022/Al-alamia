class DenominationsResponseModel {
  List<DenominationsModel>? data;
  bool? success;
  DenominationsMeta? meta;

  DenominationsResponseModel({this.data, this.success, this.meta});

  DenominationsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DenominationsModel>[];
      json['data'].forEach((v) {
        data!.add(DenominationsModel.fromJson(v));
      });
    }
    success = json['success'];
    meta = json['meta'] != null
        ? DenominationsMeta.fromJson(json['meta'])
        : null;
  }
}

class DenominationsMeta {
  String? balance;
  BalanceDetails? balanceDetails;
  String? message;

  DenominationsMeta({this.balance, this.balanceDetails, this.message});

  DenominationsMeta.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    balanceDetails = json['balance_details'] != null
        ? BalanceDetails.fromJson(json['balance_details'])
        : null;
    message = json['message'];
  }
}

class BalanceDetails {
  String? baseBalance;
  String? commissionValue;
  int? pendingBalance;
  String? surplusBalance;
  String? deficitBalance;

  BalanceDetails({
    this.baseBalance,
    this.commissionValue,
    this.pendingBalance,
    this.surplusBalance,
    this.deficitBalance,
  });

  BalanceDetails.fromJson(Map<String, dynamic> json) {
    baseBalance = json['base_balance'];
    commissionValue = json['commission_value'];
    pendingBalance = json['pending_balance'];
    surplusBalance = json['surplus_balance'];
    deficitBalance = json['deficit_balance'];
  }
}

class DenominationsModel {
  String? name;
  String? value;
  num? quantity;
  num? total;

  DenominationsModel({this.name, this.value, this.quantity, this.total});

  DenominationsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['quantity'] = quantity;
    data['total'] = total;
    return data;
  }
}

List<DenominationsModel> get dummyDenominations => List.generate(
  6,
  (index) => DenominationsModel(
    name: 'Denomination ${index + 1}',
    value: '\$${(index + 1) * 100}',
    quantity: 10,
    total: (index + 1) * 1000,
  ),
);
