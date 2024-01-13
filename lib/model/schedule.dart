class Schedule{
  String schedule_id;
  String date; // Format?
  String status;

  Schedule({
    this.schedule_id= '',
    required this.date,
    required this.status,
  });

  // Named constructor to create a Bin instance from a JSON object
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      schedule_id: json['id'] ?? '', // Use 'id' as the key if that's what's used in your JSON
      date: json['date'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson()=>{
    'id' : schedule_id,
    'date' : date,
    'status' : status,
  };
}