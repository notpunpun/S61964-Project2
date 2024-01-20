class Complaint {
  final String complaint;

  Complaint({
    required this.complaint,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      complaint: json['complaint'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'complaint': complaint,
    };
  }
}
