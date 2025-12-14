class BranchModel {
  final int? id ;
  final String? name;
  final double? transferFee;
  final double? commissionRatePercentage;

  BranchModel({required this.id, required this.name, required this.transferFee, required this.commissionRatePercentage});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'] as int,
      name: json['name'] as String,
      transferFee: json['transfer_fee'] as double,
      commissionRatePercentage: json['commission_rate_percentage'] as double,
    );
  }

}

 