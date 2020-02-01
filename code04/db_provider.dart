class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'universityHelper.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(CREATE_USER_TABLE);
      await db.execute(CREATE_CALENDAR_EVENT_TABLE);
      await db.execute(CREATE_GRADE_TABLE);
      await db.execute(CREATE_MESSAGE_TABLE);
      await db.execute(CREATE_PAYMENT_TABLE);
    });
  }
}
