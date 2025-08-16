const mysql = require("mysql");
const util = require("util");
const retry = require("async-await-retry");
require("dotenv").config();

const createConnection = async (sql, username, password) => {
  console.log(
    `Connecting to MySQL server as ${username || process.env.DB_USERNAME}`
  );

  const connection = mysql.createConnection(
    {
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      user: username || process.env.DB_USERNAME,
      password: password || process.env.DB_PASSWORD,
      database: username && password ? "" : process.env.DB_DATABASE_NAME,
    },
    { multipleStatements: true }
  );

  const query = util.promisify(connection.query).bind(connection);

  let results;
  try {
    results = await query(sql);
  } catch (error) {
    console.error(error.message);
    throw error;
  } finally {
    connection.end();
  }
  return results;
};

const connect = async (sql, username, password) => {
  let results;
  try {
    results = await retry(createConnection, [sql, username, password], {
      retriesMax: 10,
      interval: 10000,
    });
  } catch (error) {
    console.error(error);
  }
  return results;
};

module.exports = connect;
