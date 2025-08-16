const fs = require("fs").promises;

module.exports = async (fileName) => {
  let sql;
  try {
    sql = await fs.readFile(fileName);
  } catch (err) {
    console.error(`Cannot read file ${fileName} due to ${err}`);
  }
  return sql.toString();
};
