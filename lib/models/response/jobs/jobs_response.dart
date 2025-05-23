import 'dart:convert';

// FIX: Error Occurred: -------------- type '(Map<String, dynamic>) => JobsResponse' is not a subtype of type '(dynamic) => dynamic' of 'f' ---------------
List<JobsResponse> jobsResponseFromJson(String str) =>
    (json.decode(str) as List)
        .cast<Map<String, dynamic>>()
        .map(JobsResponse.fromJson)
        .toList();

class JobsResponse {

  final String id;
  final String title;
  final String location;
  final String company;
  final bool hiring;
  final String description;
  final String salary;
  final String period;
  final String contract;
  final List<String> requirements;
  final String imageUrl;
  final String agentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  JobsResponse({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.hiring,
    required this.description,
    required this.salary,
    required this.period,
    required this.contract,
    required this.requirements,
    required this.imageUrl,
    required this.agentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobsResponse.fromJson(Map<String, dynamic> json) => JobsResponse(
        id: json['_id'],
        title: json['title'],
        location: json['location'],
        company: json['company'],
        hiring: json['hiring'],
        description: json['description'],
        salary: json['salary'],
        period: json['period'],
        contract: json['contract'],
        requirements: List<String>.from(json['requirements'].map((x) => x)),
        imageUrl: json['imageUrl'],
        // Fix: Type 'Null' is not a subtype 'String' in type cast
        agentId: json['agentId'] ?? '',
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );
}
