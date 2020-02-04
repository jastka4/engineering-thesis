factory Payment.fromMap(Map<String, dynamic> json) => new Payment(
      id: json["id"],
      value: json["value"],
      title: json["title"],
      description: json["description"],
      instalment: json["instalment"],
      paymentDate: DateTime.parse(json["paymentDate"]),
      issueDate: DateTime.parse(json["issueDate"]),
      status: PaymentStatus.values[json["status"]],
    );