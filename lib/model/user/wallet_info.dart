import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class WalletInfo {
  String? id;
  String? userId;
  String? amount;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? bonus;

  WalletInfo({
    this.id,
    this.userId,
    this.amount,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.bonus,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
        id: json['id'] as String?,
        userId: json['userId'] as String?,
        amount: json['amount'] as String?,
        isBlocked: json['isBlocked'] as bool?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        bonus: json['bonus'] as int?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'amount': amount,
        'isBlocked': isBlocked,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'bonus': bonus,
      };
}
