
class Task {
  int id;
  String title;
  String task;
  String date;

  Task(
      { this.id,
        this.title,
        this.task,
        this.date});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    task = json['note'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> note = <String, dynamic>{};
    note['id'] = id;
    note['title'] = title;
    note['note'] = this.task;
    note['date'] = this.date;
    return note;
  }
}
