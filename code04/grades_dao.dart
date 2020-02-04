Future<List<Grade>> getGradesBySemester(int semester) async {
  final db = await DBProvider.db.database;
  var res =
      await db.query('grade', where: 'semester = ?', whereArgs: [semester]);
  List<Grade> list =
      res.isNotEmpty ? res.map((c) => Grade.fromMap(c)).toList() : [];
  return list;
}