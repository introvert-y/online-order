
var models = require('./db');
var $sql = require('./sqlMap');
var mysql = require('mysql');
const express = require('express');
const app = express();
var conn = mysql.createConnection(models.mysql);

// 创建 application/x-www-form-urlencoded 解析
var bodyParser = require('body-parser');

// 创建 application/json 解析
var jsonParser = bodyParser.json()

// 创建 application/x-www-form-urlencoded 编码解析
var urlencodedParser = bodyParser.urlencoded({ extended: false })
conn.connect();


//路由端口的RESTful api风格
//GET         /zoos：列出所有动物园
// POST        /zoos：新建一个动物园
// GET         /zoos/ID：获取某个指定动物园的信息
// PUT         /zoos/ID：更新某个指定动物园的信息（提供该动物园的全部信息）
// PATCH       /zoos/ID：更新某个指定动物园的信息（提供该动物园的部分信息）
// DELETE      /zoos/ID：删除某个动物园
// GET         /zoos/ID/animals：列出某个指定动物园的所有动物
// DELETE      /zoos/ID/animals/ID：删除某个指定动物园的指定动物
//
  app.get('/GET/sellerInfo', function (req, res) {
    var sql = 'select * from seller';
    var response='';
    conn.query(sql, function(err, result) {
      if (err) {
        console.log(err);
      }
      if (result) {
        response = JSON.stringify(result)
      }
      res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
      res.end(response);
    })
  })

app.get('/GET/activityInfo', function (req, res) {
  var sql = $sql.seller_activity;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)
      // response[length] = JSON.stringify(result[1])
      // response =  JSON.stringify(result)//把results对象转为字符串，去掉RowDataPacket
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.get('/GET/goods', function (req, res) {
  var sql = $sql.goods;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response =   JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.get('/GET/goodsMenu', function (req, res) {
  var sql = $sql.goodsMenu;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

//评论相关的接口
//返回总的评论信息
app.get('/GET/ratings', function (req, res) {
  var sql = $sql.ratings;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

//返回特定的商品评论
app.get('/GET/theRatings', function (req, res) {
  let foodName = req.query.name;
  var sql = `SELECT * FROM ratings WHERE orderMenu = "${foodName}"`;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response =   JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})




//Login页面的路由
//判断用户是否存在，在则返回相应信息
app.get('/GET/userExist', function (req, res) {
  let account = req.query.account;
  let password = req.query.password;
  console.log('---------')
  console.log(account)
  console.log(password)
  var sql = `SELECT * FROM user WHERE account = "${account}" and password ="${password}" `;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err)
    }
    if (result) {
      response =   JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

//新建用户信息
app.post('/POST/newUser',jsonParser, function (req, res) {
  let obj = req.body;
  var sql = `INSERT INTO USER (name,account,password,phoneNumber) VALUE ("${obj.name}","${obj.account}","${obj.password}","${obj.phoneNumber}")`;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err)
    }
    if (result) {
      response =   JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

//判断用户信息是否符合
app.get('/GET/isUserFlag', function (req, res) {
  let account = req.query.account;
  let phoneNumber = req.query.phoneNumber;
  console.log('---------')
  console.log(account)
  console.log(phoneNumber)
  var sql = `SELECT * FROM user WHERE account = "${account}" and phoneNumber ="${phoneNumber}" `;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err)
    }
    if (result) {
      response =   JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

//修改（更新）用户密码
app.put('/PUT/updateUserInfo',jsonParser, function (req, res) {
  let account = req.body.account;
  let password = req.body.password;
  console.log('---------')
  console.log(account)
  console.log(password)
  var sql = `update user set password ="${password}"  WHERE account = "${account}" `;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err)
    }
    if (result) {
      response =   JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})





//商家对商品进行增、删、改操作
app.post('/POST/addFood',jsonParser, function (req, res) {
  let obj = req.body.data
  console.log(obj)
  var sql = `INSERT INTO goods(id,name,price,description,info,icon,image) VALUE ("${obj.id}","${obj.name}","${obj.price}","${obj.description}","${obj.info}","${obj.image}","${obj.image}")`;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)

    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.delete('/DELETE/theFood', function (req, res) {
  let name = req.query.name;
  var sql = `delete  FROM goods WHERE name = "${name}" `;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err)
    }
    if (result) {
      response =   JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.put('/PUT/updateTheFood',jsonParser, function (req, res) {
  let obj = req.body.data
  console.log(obj)
  var sql = `update goods set id = "${obj.id}",name = "${obj.name}" , price = "${obj.price}",description = "${obj.description}" ,info = "${obj.info}",icon = "${obj.image}",image = "${obj.image}" where name = "${obj.actualName}"`;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)

    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})




//订单的相关操作
app.post('/POST/addOrder',jsonParser, function (req, res) {
  let obj = req.body.data
  console.log(obj)
  var sql = `INSERT INTO orderManager(id,createTime,userName,goodsName,numbers,price,icon,totalPrice,address,orderStatus) VALUE ("${obj.createTime}","${obj.createTime}","${obj.userName}","${obj.nameArr}","${obj.numberArr}","${obj.priceArr}","${obj.iconArr}","${obj.totalPrice}","${obj.address}","${obj.orderStatus}")`;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)

    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.delete('/DELETE/cancelTheOrder', function (req, res) {
  let obj = req.query
  console.log(obj)
  var sql = `update orderManager set orderStatus = "4" where id = "${obj.creatTime}"`;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)

    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.get('/GET/theOrderStatus', function (req, res) {
  var obj = req.query;
  var sql = '';
  if(obj.mode=='1'){
    //查询已下单，但没支付的订单
    sql = `SELECT * FROM orderManager WHERE orderStatus = "${obj.type}"`;
  }else if(obj.mode=='2'){
    //查询当前订单是否已支付
    sql = `SELECT * FROM orderManager WHERE orderStatus = "1" and createTime = ${obj.createTime}`;
  }


  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)

    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.get('/GET/totalOrder', function (req, res) {
  var sql = `SELECT * FROM orderManager ORDER BY id DESC`;
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)

    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.get('/GET/theUserOrder', function (req, res) {
  var obj = req.query;
  var sql = `SELECT * FROM orderManager where userName = "${obj.userName}" ORDER BY id DESC`;
  console.log(sql)
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)

    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.put('/PUT/changeOrderStatus',jsonParser, function (req, res) {
  console.log('/PUT/changeOrderStatus方法')
  var obj = req.body.data;
  console.log(obj)
  if(obj.mode=='1'){
    //仅改变订单状态
    var sql = `update orderManager set orderStatus = "${obj.type}" where createTime = "${obj.createTime}"`;
  }else if(obj.mode =='2'){
    //改变订单状态的同时，改变配送员的状态
    var sql = `update orderManager set orderStatus = "${obj.type}" where createTime = "${obj.createTime}";update delivery set type = "0" where name = "${obj.name}"`;
  }
  console.log(sql)
  var response='';
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      response = JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })
})

//购买商品后的，商品评论的提交与相应商品销量的更新
app.post('/POST/submitRatings',jsonParser, function (req, res) {
  let name = req.body.name;
  let arr = req.body.arr;
  let creatTime = req.body.creatTime;
  let deliveryTime = req.body.deliveryTime;
  let score = '';
  var sql = '';
  var response='';
  console.log(name)
  console.log(creatTime)
  console.log(deliveryTime)
  console.log(arr)
  for(let i = 0 ;i<=arr.length-1 ;i++){
    let obj = arr[i]
    if(obj.score>3){
      score = 0
    }else{
      score = 1
    }
    sql += `INSERT INTO ratings (orderMenu,username,score,text,deliveryTime,rateTime,rateType) 
     VALUE ("${obj.name}","${name}","${obj.score}","${obj.text}","${deliveryTime}","${creatTime}","${score}");
     update goods set sellCount = sellCount+${obj.count} where name = "${obj.name}";`
  }
  // console.log(sql)
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err)
    }
    if (result) {
      response =   JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})

app.put('/PUT/increateTheFoodCount',jsonParser, function (req, res) {
  console.log('/PUT/increateTheFoodCount方法')
  console.log()
  let arr = req.body.data.arr;
  var sql = '';
  var response='';

  for(let i = 0 ;i<=arr.length-1 ;i++){
    let obj = arr[i]
    sql += `update goods set sellCount = sellCount+${obj.count} where name = "${obj.name}";`
  }
  console.log(sql)
  conn.query(sql, function(err, result) {
    if (err) {
      console.log(err)
    }
    if (result) {
      response =   JSON.stringify(result)
    }
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end(response);
  })

})


//先选出第一个处于空闲的配送员，再把他的状态变为忙碌
app.get('/GET/changeDeliveryType',function (req, res) {
  var sql = `SELECT * FROM delivery where type = '0' LIMIT 0,1`;
  console.log(sql)
  var response = '';
  var promise = new Promise(function (resolve, reject) {
    conn.query(sql, function (err, result) {
      if (err) {
        console.log(err)
      }
      if (result.length>0) {
        console.log(result)
        resolve(result[0]);
      }else{
        reject(new Error('condition no fit'))
      }
    })


  });
  promise.then(function (obj) {
    console.log('11111111',obj)
      var sql = `update delivery set type = '1' where name = '${obj.name}'`;
      console.log(sql)
      conn.query(sql, function(err, result) {
        if (err) {
          console.log(err);
        }
        if (result) {
          // response = JSON.stringify(obj)

        }
        res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
        res.end(JSON.stringify(obj));
      })
    }).catch(function(error) {
    res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
    res.end('500');
  });

})




app.listen(3000,'127.0.0.1');
console.log('success listen at port: 127.0.0.1:3000')
