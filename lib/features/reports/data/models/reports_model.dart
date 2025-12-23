class ReportsModel {
  String? period;
  String? date;
  List<Disk>? disk;
  Expenses? expenses;
  Debts? debts;
  String? deficit;
  String? surplus;
  BranchCurrency? branchCurrency;
  String? link;

  ReportsModel({
    this.period,
    this.date,
    this.disk,
    this.expenses,
    this.debts,
    this.deficit,
    this.surplus,
    this.branchCurrency,
    this.link,
  });

  factory ReportsModel.fromJson(Map<String, dynamic> json) => ReportsModel(
        period: json["period"],
        date: json["date"],
        disk: json["disk"] == null
            ? []
            : List<Disk>.from(json["disk"]!.map((x) => Disk.fromJson(x))),
        expenses: json["expenses"] == null
            ? null
            : Expenses.fromJson(json["expenses"]),
        debts: json["debts"] == null ? null : Debts.fromJson(json["debts"]),
        deficit: json["deficit"],
        surplus: json["surplus"],
        branchCurrency: json["branch_currency"] == null
            ? null
            : BranchCurrency.fromJson(json["branch_currency"]),
        link: json["link"],
      );
}


class Disk {
  int? currencyId;
  String? currencyName;
  String? currencyCode;
  double? incoming;
  double? outgoing;
  double? balance;

  Disk({
    this.currencyId,
    this.currencyName,
    this.currencyCode,
    this.incoming,
    this.outgoing,
    this.balance,
  });

  factory Disk.fromJson(Map<String, dynamic> json) => Disk(
        currencyId: json["currency_id"],
        currencyName: json["currency_name"],
        currencyCode: json["currency_code"],
        incoming: json["incoming"]?.toDouble(),
        outgoing: json["outgoing"]?.toDouble(),
        balance: json["balance"]?.toDouble(),
      );
}


class Expenses {
  double? total;
  List<ExpenseItem>? items;

  Expenses({
    this.total,
    this.items,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) => Expenses(
        total: json["total"]?.toDouble(),
        items: json["items"] == null
            ? []
            : List<ExpenseItem>.from(
                json["items"]!.map((x) => ExpenseItem.fromJson(x))),
      );
}

class ExpenseItem {
  int? id;
  String? amount;
  String? notes;

  ExpenseItem({
    this.id,
    this.amount,
    this.notes,
  });

  factory ExpenseItem.fromJson(Map<String, dynamic> json) => ExpenseItem(
        id: json["id"],
        amount: json["amount"],
        notes: json["notes"],
      );
}

class Debts {
  DebtsInside? inside;
  DebtsOutside? outside;

  Debts({
    this.inside,
    this.outside,
  });
  factory Debts.fromJson(Map<String, dynamic> json) => Debts(
        inside: json["inside"] == null
            ? null
            : DebtsInside.fromJson(json["inside"]),
        outside: json["outside"] == null
            ? null
            : DebtsOutside.fromJson(json["outside"]),
      );
}

class DebtsInside {
  double? add;
  double? paid;
  double? balance;

  DebtsInside({
    this.add,
    this.paid,
    this.balance,
  });

  factory DebtsInside.fromJson(Map<String, dynamic> json) => DebtsInside(
        add: json["add"]?.toDouble(),
        paid: json["paid"]?.toDouble(),
        balance: json["balance"]?.toDouble(),
      );
}

class DebtsOutside {
  double? add;
  double? paid;
  double? balance;
  DebtsOutside({
    this.add,
    this.paid,
    this.balance,
  });

  factory DebtsOutside.fromJson(Map<String, dynamic> json) => DebtsOutside(
        add: json["add"]?.toDouble(),
        paid: json["paid"]?.toDouble(),
        balance: json["balance"]?.toDouble(),
      );
}

class BranchCurrency {
  double? incoming;
  double? outgoing;
  double? balance;

  BranchCurrency({
    this.incoming,
    this.outgoing,
    this.balance,
  });

  factory BranchCurrency.fromJson(Map<String, dynamic> json) => BranchCurrency(
        incoming: json["incoming"]?.toDouble(),
        outgoing: json["outgoing"]?.toDouble(),
        balance: json["balance"]?.toDouble(),
      );
}
