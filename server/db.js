/*数据库入口文件*/
module.exports = {
  mysql: {
    host: 'localhost',//本地数据库
    user: 'root',//数据库用户名
    password: '',//数据库连接密码
    database: 'sale_data',//连接的是哪个数据库
    port: 3306,
    multipleStatements: true//执行多条mysql指令
  }
}
