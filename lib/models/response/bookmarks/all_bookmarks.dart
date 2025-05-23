import 'dart:convert';

// Function to parse JSON string into a list of AllBookmark objects
List<AllBookmark> allBookmarkFromJson(String str) => List<AllBookmark>.from(
  json.decode(str).map((x) => AllBookmark.fromJson(x)), // Correctly map each item
);

class AllBookmark {
  final String id;
  final Job job;
  final String userId;

  AllBookmark({
    required this.id,
    required this.job,
    required this.userId,
  });

  // Factory method to create an AllBookmark instance from JSON
  factory AllBookmark.fromJson(Map<String, dynamic> json) => AllBookmark(
    id: json['_id'],
    job: Job.fromJson(json['job']),
    userId: json['userId'],
  );
}

class Job {
  final String id;
  final String title;
  final String location;
  final String company;
  final String salary;
  final String period;
  final String contract;
  final String imageUrl;
  final String agentId;

  Job({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.salary,
    required this.period,
    required this.contract,
    required this.imageUrl,
    required this.agentId,
  });

  // Factory method to create a Job instance from JSON
  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['_id'],
    title: json['title'],
    location: json['location'],
    company: json['company'],
    salary: json['salary'],
    period: json['period'],
    contract: json['contract'],
    imageUrl: json['imageUrl'],
    agentId: json['agentId'] ?? '',
  );
}