class PopActor {
  final int person_id;
  final String person_name;

  PopActor({required this.person_id, required this.person_name});
  factory PopActor.fromJson(Map<String, dynamic> json) {
    return PopActor(
      person_id: json['person_id'] as int,
      person_name: json['person_name'] as String,
    );
  }

  @override
  String toString() {
    return person_name;
  }
}
