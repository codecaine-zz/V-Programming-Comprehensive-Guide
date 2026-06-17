module sqlite

import db.sqlite as dbsqlite

pub type DB = dbsqlite.DB

pub fn connect(path string) !DB {
	return dbsqlite.connect(path)!
}
