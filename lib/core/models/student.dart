class Student {
  int? id;
  String name;
  String course;
  String mobile;
  int totalFee;
  int feePaid;

  Student({
    this.id,
    required this.name,
    required this.course,
    required this.mobile,
    required this.totalFee,
    required this.feePaid,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      course: json['course'],
      mobile: json['mobile'],
      totalFee: json['totalFee'],
      feePaid: json['feePaid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'course': course,
      'mobile': mobile,
      'totalFee': totalFee,
      'feePaid': feePaid,
    };
  }
}
