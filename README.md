

# online-order

> A Vue.js project 需要用到node的express框架和mysql

首先导入sale_data.sql数据表导入到你的mysql里新建的数据库，这里默认的数据库名称为sale_data，，若导入不成功，你可以用记事本打开此文件，手动复制到该数据

库的执行环境去执行创建数据库操作，若你的数据库名称不是sale_data需要在大概18行的位置把USE `sale_data`改为你的数据库名称;

导入成功后在server文件夹下的db.js，把database=‘sale_data’改为你的数据库名称。

然后执行在server文件下执行node index.js

## Build Setup
``` bash
# install dependencies安装依赖
npm install

# serve with hot reload at localhost:8080
npm run dev

商家的账号为user 密码为123456
顾客的账号为wu7276 密码为123456

该项目实现了移动端适配，大家可以在项目打开后，切换相应的移动设备或者responsive自行拖拽页面大小

大致效果如图所示，购物流程还未演示 
![image](https://github.com/introvert-y/online-order/raw/master/images.gif)
https://github.com/introvert-y/online-order/raw/master/images.gif
