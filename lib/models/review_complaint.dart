import 'package:tourist_guide/models/complaint.dart';

class ReviewComplaint {
  final String complaint;

  ReviewComplaint({
    required this.complaint,
  });

  factory ReviewComplaint.fromJson(Map<String, dynamic> json) {
    return ReviewComplaint(
      complaint: json['complaint'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'complaint': complaint,
    };
  }
}
