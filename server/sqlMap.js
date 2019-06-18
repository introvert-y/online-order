var sqlMap = {
  add: 'insert into aaa (name, age, sex) values (?,?,?)',
  seller: 'select * from seller',
  seller_activity:'select * from seller_activity',
  goods:'select * from goods order by  sellCount desc',
  goodsMenu:'SELECT * FROM goodsmenu ORDER BY rank',
  ratings: 'SELECT * FROM ratings ORDER BY rateTime DESC ',
}

module.exports = sqlMap;
