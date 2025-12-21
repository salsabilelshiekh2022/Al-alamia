class BranchModel {
  final int? id ;
  final String? name;
  final num? transferFee;
  final String? commissionRatePercentage;

  BranchModel({required this.id, required this.name, required this.transferFee, required this.commissionRatePercentage});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'] as int,
      name: json['name'] as String,
      transferFee: json['transfer_fee'] as num,
      commissionRatePercentage: json['commission_rate_percentage'] as String,
    );
  }

}

 