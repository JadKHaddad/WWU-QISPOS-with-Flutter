class Lecture {
  String number;
  String name;
  String semester;
  String grade;
  String status;
  String achievementPoints;
  String examiner;
  String note;
  String tries;
  String date;

  Lecture(
      {this.number,
      this.name,
      this.semester,
      this.grade,
      this.status,
      this.achievementPoints,
      this.examiner,
      this.note,
      this.tries,
      this.date});

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'semester': semester,
      'grade': grade,
      'status': status,
      'achievementPoints': achievementPoints,
      'examiner': examiner,
      'note': note,
      'tries': tries,
      'date': date
    };
  }

  @override
  String toString() {
    return 'Lecture{number: $number, name: $name, semester: $semester, grade: $grade, status: $status, achievementPoints: $achievementPoints, examiner: $examiner, note: $note, tries: $tries, date: $date}';
  }
}
