/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.6.42 : Database - sale_data
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sale_data` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sale_data`;

/*Table structure for table `delivery` */

DROP TABLE IF EXISTS `delivery`;

CREATE TABLE `delivery` (
  `name` char(20) DEFAULT NULL,
  `phone` char(15) DEFAULT NULL,
  `type` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `delivery` */

insert  into `delivery`(`name`,`phone`,`type`) values ('王刚','13912345678','1'),('小明','13512345678','1'),('小王','13212345678','1'),('小李','13112345678','0');

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `id` char(6) DEFAULT NULL COMMENT 'rank',
  `name` char(50) NOT NULL,
  `sellCount` int(10) DEFAULT '0',
  `price` char(10) NOT NULL,
  `oldPrice` char(10) DEFAULT NULL,
  `description` char(100) DEFAULT NULL,
  `rating` char(10) DEFAULT '0',
  `info` text,
  `icon` text,
  `image` text,
  PRIMARY KEY (`name`),
  KEY `id` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `goods` */

insert  into `goods`(`id`,`name`,`sellCount`,`price`,`oldPrice`,`description`,`rating`,`info`,`icon`,`image`) values ('7,2','VC无限橙果汁',15,'8','10','','100','','http://fuss10.elemecdn.com/e/c6/f348e811772016ae24e968238bcbfjpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/e/c6/f348e811772016ae24e968238bcbfjpeg.jpeg?imageView2/1/w/750/h/750'),('5','八宝酱菜',84,'4','','','100','这道八宝酱菜是北京的传统名小吃，一道菜能吃出八种宝贝，酱香中透着清香，还有淡淡的甜味和辣味，口感多样，是下饭的好菜。','http://fuss10.elemecdn.com/9/b5/469d8854f9a3a03797933fd01398bjpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/9/b5/469d8854f9a3a03797933fd01398bjpeg.jpeg?imageView2/1/w/750/h/750'),('7','加多宝',7,'6','','','100','','http://fuss10.elemecdn.com/b/9f/5e6c99c593cf65229225c5661bcdejpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/b/9f/5e6c99c593cf65229225c5661bcdejpeg.jpeg?imageView2/1/w/114/h/750'),('9','南瓜粥',91,'9','','甜粥','100','南瓜粥，中医认为，南瓜性味甘、温，归脾、胃经，有补中益气、清热解毒之功，适用于脾虚气弱、营养不良、肺痈、水火烫伤。','http://fuss10.elemecdn.com/8/a6/453f65f16b1391942af11511b7a90jpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/8/a6/453f65f16b1391942af11511b7a90jpeg.jpeg?imageView2/1/w/750/h/750'),('4','娃娃菜炖豆腐',43,'17','','','92','','http://fuss10.elemecdn.com/d/2d/b1eb45b305635d9dd04ddf157165fjpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/d/2d/b1eb45b305635d9dd04ddf157165fjpeg.jpeg?imageView2/1/w/114/h/750'),('3','扁豆焖面',232,'14','','','96','扁豆焖面，一种传统面食，是将细面条蒸熟后备用，将肉丝、扁豆放入油锅内炒至变色，加入适量的水，等扁豆六七分熟时，将蒸好的面条放入锅中一起翻炒，等水分蒸干后盛盘即可食用','http://fuss10.elemecdn.com/c/6b/29e3d29b0db63d36f7c500bca31d8jpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/c/6b/29e3d29b0db63d36f7c500bca31d8jpeg.jpeg?imageView2/1/w/750/h/750'),('4','手撕包菜',29,'16','','','100','','http://fuss10.elemecdn.com/9/c6/f3bc84468820121112e79583c24efjpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/9/c6/f3bc84468820121112e79583c24efjpeg.jpeg?imageView2/1/w/750/h/750'),('5','拍黄瓜',28,'9','','','100','','http://fuss10.elemecdn.com/6/54/f654985b4e185f06eb07f8fa2b2e8jpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/6/54/f654985b4e185f06eb07f8fa2b2e8jpeg.jpeg?imageView2/1/w/114/h/750'),('3','招牌猪肉白菜锅贴/10个',101,'17','','','78','','http://fuss10.elemecdn.com/7/72/9a580c1462ca1e4d3c07e112bc035jpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/7/72/9a580c1462ca1e4d3c07e112bc035jpeg.jpeg?imageView2/1/w/750/h/750'),('8','牛肉馅饼',118,'14','','','91','牛肉馅饼，是一道营养均衡的点心，也可作为主食。 皮薄馅厚，馅心滋润软滑、味道甜而不腻。而其中用于调馅的小麦面粉、牛肉、大葱、白菜所含的营养物质对身体有着积极的作用，是广大单身、青少年的优质食物。也用于对营养不良、健脾开胃的调理。','http://fuss10.elemecdn.com/d/b9/bcab0e8ad97758e65ae5a62b2664ejpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/d/b9/bcab0e8ad97758e65ae5a62b2664ejpeg.jpeg?imageView2/1/w/750/h/750'),('9','田园蔬菜粥',33,'10','','咸粥','100','','http://fuss10.elemecdn.com/a/94/7371083792c19df00e546b29e344cjpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/a/94/7371083792c19df00e546b29e344cjpeg.jpeg?imageView2/1/w/114/h/750'),('6','皮蛋瘦肉粥',336,'10','','咸粥','100','一碗皮蛋瘦肉粥，总是我到粥店时的不二之选。香浓软滑，饱腹暖心，皮蛋的Q弹与瘦肉的滑嫩伴着粥香溢于满口，让人喝这样的一碗粥也觉得心满意足','http://fuss10.elemecdn.com/c/cd/c12745ed8a5171e13b427dbc39401jpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/c/cd/c12745ed8a5171e13b427dbc39401jpeg.jpeg?imageView2/1/w/750/h/750'),('8','糊塌子',80,'10','','','90','糊塌子是传统面食，指的是把西葫芦擦成丝，和面拌成糊，再和辅料拌匀，饼铛烧热，淋少许油，倒入面糊摊平（圆形），两面烤焦即成。','http://fuss10.elemecdn.com/0/05/097a2a59fd2a2292d08067e16380cjpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/0/05/097a2a59fd2a2292d08067e16380cjpeg.jpeg?imageView2/1/w/750/h/750'),('9','红枣山药糙米粥',81,'10','','','91','美容，补血，养颜','http://fuss10.elemecdn.com/9/b5/469d8854f9a3a03797933fd01398bjpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/9/b5/469d8854f9a3a03797933fd01398bjpeg.jpeg?imageView2/1/w/750/h/750'),('2','红豆薏米美肤粥',86,'12','14','甜粥','100','美容，补血，养颜','http://fuss10.elemecdn.com/d/22/260bd78ee6ac6051136c5447fe307jpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/d/22/260bd78ee6ac6051136c5447fe307jpeg.jpeg?imageView2/1/w/750/h/750'),('8','葱花饼',150,'10','','','85','葱花饼是一种由面粉和小葱为主要食材的中国煎饼。烹饪简单，味道鲜美，将香葱切碎与盐，油拌匀，面剂按扁，擀成薄片，加上葱油，卷起，由两头拧挤起来，用手按扁，擀薄，刷油，平锅烙熟即可。','http://fuss10.elemecdn.com/f/28/a51e7b18751bcdf871648a23fd3b4jpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/f/28/a51e7b18751bcdf871648a23fd3b4jpeg.jpeg?imageView2/1/w/750/h/750'),('7','蜜瓜圣女萝莉杯',1,'6','','','','','http://fuss10.elemecdn.com/b/5f/b3b04c259d5ec9fa52e1856ee50dajpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/b/5f/b3b04c259d5ec9fa52e1856ee50dajpeg.jpeg?imageView2/1/w/114/h/750'),('4','香酥黄金鱼/3条',15,'11','','','100','','http://fuss10.elemecdn.com/4/e7/8277a6a2ea0a2e97710290499fc41jpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/4/e7/8277a6a2ea0a2e97710290499fc41jpeg.jpeg?imageView2/1/w/114/h/750'),('9,1','鲜蔬菌菇粥',125,'11','14','咸粥','100','是一道用大米、鲜香菇、木耳、胡萝卜、菠菜为主料制作的美食，辅料有盐、香油、水等。','http://fuss10.elemecdn.com/e/a3/5317c68dd618929b6ac05804e429ajpeg.jpeg?imageView2/1/w/114/h/114','http://fuss10.elemecdn.com/e/a3/5317c68dd618929b6ac05804e429ajpeg.jpeg?imageView2/1/w/114/h/750');

/*Table structure for table `goodsmenu` */

DROP TABLE IF EXISTS `goodsmenu`;

CREATE TABLE `goodsmenu` (
  `name` char(20) NOT NULL,
  `type` char(5) NOT NULL COMMENT '是否有icon',
  `rank` int(5) DEFAULT NULL COMMENT '排列',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `goodsmenu` */

insert  into `goodsmenu`(`name`,`type`,`rank`) values ('冰爽饮品限时特惠','1',2),('单人精彩套餐','2',1),('小吃主食','-1',7),('果拼果汁','-1',6),('热销榜','-1',0),('爽口凉菜','-1',4),('特色粥品','-1',8),('精选套餐','-1',5),('精选热菜','-1',3);

/*Table structure for table `ordermanager` */

DROP TABLE IF EXISTS `ordermanager`;

CREATE TABLE `ordermanager` (
  `id` char(40) DEFAULT NULL,
  `createTime` char(40) DEFAULT NULL,
  `userName` char(20) DEFAULT NULL,
  `goodsName` text,
  `numbers` text,
  `price` text,
  `icon` text,
  `totalPrice` char(10) DEFAULT NULL,
  `address` text,
  `orderStatus` char(5) DEFAULT NULL COMMENT '//''0''已支付，''1''已接单,在备餐,''2''正在配送，’3‘已送达’‘4’已退款'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ordermanager` */

insert  into `ordermanager`(`id`,`createTime`,`userName`,`goodsName`,`numbers`,`price`,`icon`,`totalPrice`,`address`,`orderStatus`) values ('1559136772000','1559136772000','fox','扁豆焖面','3','14','http://fuss10.elemecdn.com/c/6b/29e3d29b0db63d36f7c500bca31d8jpeg.jpeg?imageView2/1/w/114/h/114','41','uuuuuu','2'),('1559152842000','1559152842000','fox','葱花饼','4','10','http://fuss10.elemecdn.com/f/28/a51e7b18751bcdf871648a23fd3b4jpeg.jpeg?imageView2/1/w/114/h/114','39','xx','3'),('1559202817000','1559202817000','fox','皮蛋瘦肉粥,扁豆焖面','2,1','10,14','http://fuss10.elemecdn.com/c/cd/c12745ed8a5171e13b427dbc39401jpeg.jpeg?imageView2/1/w/114/h/114,http://fuss10.elemecdn.com/c/6b/29e3d29b0db63d36f7c500bca31d8jpeg.jpeg?imageView2/1/w/114/h/114','33','dddd','3'),('1559234802000','1559234802000','fox','皮蛋瘦肉粥,鲜蔬菌菇粥','1,1','10,11','http://fuss10.elemecdn.com/c/cd/c12745ed8a5171e13b427dbc39401jpeg.jpeg?imageView2/1/w/114/h/114,http://fuss10.elemecdn.com/e/a3/5317c68dd618929b6ac05804e429ajpeg.jpeg?imageView2/1/w/114/h/114','25','dddddd','3'),('1559307215000','1559307215000','fox','皮蛋瘦肉粥','6','10','http://fuss10.elemecdn.com/c/cd/c12745ed8a5171e13b427dbc39401jpeg.jpeg?imageView2/1/w/114/h/114','59','ddd','3');

/*Table structure for table `ratings` */

DROP TABLE IF EXISTS `ratings`;

CREATE TABLE `ratings` (
  `orderMenu` char(20) DEFAULT NULL,
  `username` char(20) DEFAULT NULL,
  `rateType` int(5) DEFAULT NULL,
  `score` float DEFAULT NULL,
  `text` char(240) DEFAULT NULL,
  `rateTime` char(20) DEFAULT NULL,
  `deliveryTime` int(10) DEFAULT NULL,
  `avatar` char(100) DEFAULT 'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ratings` */

insert  into `ratings`(`orderMenu`,`username`,`rateType`,`score`,`text`,`rateTime`,`deliveryTime`,`avatar`) values ('皮蛋瘦肉粥','3******c',0,5,'不错,粥很好喝,我经常吃这一家,非常赞,强烈推荐.','1469281964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','3******b',1,3,'','1469261964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','1******c',0,5,'','1469261864000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('牛肉馅饼','2******d',0,4,'','1469251264000',10,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('蜜瓜圣女萝莉杯','9******0',1,1,'','1469241964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','d******c',0,5,'很喜欢的粥店','1469241964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('葱花饼','2******3',0,4,'量给的还可以','1469241964000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('牛肉馅饼','3******8',1,3,'对于男孩子还是不够吃啊','1469241964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('牛肉馅饼','a******a',0,4,'孩子喜欢吃这家','1469241964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('南瓜粥','3******3',0,4,'粥挺好吃的','1469191264000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('葱花饼','t******b',1,3,'送到有点冷了','1469181964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','f******c',0,5,'','1469171964000',15,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('招牌猪肉白菜锅贴/10个','k******3',0,4,'量贼足','1469161264000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('葱花饼','u******b',0,4,'下雨天给快递小哥点个赞','1469151964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('牛肉馅饼','s******c',0,4,'好','1469141964000',15,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','z******3',0,5,'','1469131264000',15,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','n******b',1,3,'发票开的不对','1469121964000',15,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','m******c',0,5,'好吃','1469111964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','l******3',0,4,'还不错吧','1469101264000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('招牌猪肉白菜锅贴/10个','3******o',1,2,'','1469091964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('招牌猪肉白菜锅贴/10个','3******p',0,4,'很喜欢','1469081964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('南瓜粥','o******k',0,5,'','1469071264000',35,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('牛肉馅饼','k******b',0,4,'','1469061964000',24,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('葱花饼','o******k',0,5,'','1469071264000',35,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('南瓜粥','m******c',0,5,'好吃','1469111964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('南瓜粥','z******3',0,5,'','1469131264000',15,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红豆薏米美肤粥','l******3',0,4,'还不错吧','1469101264000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红豆薏米美肤粥','2******3',0,4,'','1469241964000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红豆薏米美肤粥','u******b',0,4,'下雨天给快递小哥点个赞','1469151964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('八宝酱菜','3******p',0,4,'很喜欢','1469081964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('八宝酱菜','1******c',0,5,'良心店铺','1469261864000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红枣山药糙米粥','m******c',0,5,'好吃','1469111964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红枣山药糙米粥','z******3',0,5,'','1469131264000',15,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红枣山药糙米粥','2******3',0,4,'量给的还可以','1469241964000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红枣山药糙米粥','t******b',1,3,'送到有点冷了','1469181964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('糊塌子','l******3',0,4,'','1469101264000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('糊塌子','m******c',0,5,'好吃','1469111964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('糊塌子','z******3',0,5,'吃了还想再吃','1469131264000',15,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('糊塌子','3******b',1,3,'忘记帮我加辣椒了','1469261964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红枣山药粥套餐','l******3',0,4,'还不错吧','1469101264000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红枣山药粥套餐','k******3',0,4,'','1469161264000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('VC无限橙果汁','k******3',0,4,'量贼足','1469161264000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('VC无限橙果汁','3******p',0,4,'','1469081964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('娃娃菜炖豆腐','u******b',0,4,'下雨天给快递小哥点个赞','1469151964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('娃娃菜炖豆腐','s******c',0,4,'好','1469141964000',15,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('娃娃菜炖豆腐','3******b',1,3,'忘记帮我加辣椒了','1469261964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('手撕包菜','2******3',0,4,'','1469241964000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('手撕包菜','m******c',0,5,'好吃','1469111964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('香酥黄金鱼/3条','a******a',0,4,'孩子喜欢吃这家','1469241964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('香酥黄金鱼/3条','l******3',0,4,'','1469101264000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('拍黄瓜','l******3',0,4,'还不错吧','1469101264000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('拍黄瓜','m******c',0,5,'好吃','1469111964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红豆薏米粥套餐','3******3',0,4,'粥挺好吃的','1469191264000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('红豆薏米粥套餐','a******a',0,4,'孩子喜欢吃这家','1469241964000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥套餐','3******3',0,4,'粥挺好吃的','1469191264000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥套餐','2******3',0,4,'','1469241964000',40,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('加多宝','u******b',0,4,'下雨天给快递小哥点个赞','1469151964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('加多宝','3******p',0,4,'很喜欢','1469081964000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('鲜蔬菌菇粥','z******3',0,5,'吃了还想再吃','1469131264000',15,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('鲜蔬菌菇粥','1******c',0,5,'','1469261864000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('田园蔬菜粥','1******c',0,5,'良心店铺','1469261864000',20,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','fox',0,5,'超级暖胃好吃','1554209412000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','fox',0,4,'酱料无敌好吃','1554209412000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('葱花饼','fox',1,3,'太油腻了','1554209412000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','Anny',0,5,'暖胃舒服','1554209294000',45,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','Anny',0,4,'好吃','1554209294000',45,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','fox',0,5,'粥很好喝，很满意','1554301803000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','fox',0,5,'面很香','1554301803000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','fox',0,5,'好吃','1554301834000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','fox',0,4,'还行','1554301834000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','Anny',0,4,'dd','1555594409000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','Anny',0,5,'ffdd','1555594409000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('葱花饼','Anny',0,5,'dd','1555594409000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','Anny',0,5,'好吃','1555595150000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','Anny',0,5,'拌酱超级好吃','1555595376000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','Anny',0,5,'粥很好喝','1555595827000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('鲜蔬菌菇粥','Anny',0,5,'汤很鲜美','1555634668000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','fox',0,5,'111111111111','1559131463000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','fox',0,5,'xxxx','1559202867000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('扁豆焖面','fox',0,4,'1111','1559202867000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','fox',0,5,'dddd','1559234866000',60,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('鲜蔬菌菇粥','fox',0,5,'ddd','1559234866000',60,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png'),('皮蛋瘦肉粥','fox',0,5,'1111111111111','1559307253000',30,'http://static.galileo.xiaojukeji.com/static/tms/default_header.png');

/*Table structure for table `seller` */

DROP TABLE IF EXISTS `seller`;

CREATE TABLE `seller` (
  `name` char(20) DEFAULT NULL,
  `description` char(20) DEFAULT NULL,
  `deliveryTime` int(5) DEFAULT NULL,
  `score` float DEFAULT NULL,
  `serviceScore` float DEFAULT NULL,
  `foodScore` float DEFAULT NULL,
  `rankRate` float DEFAULT NULL,
  `minPrice` int(5) DEFAULT NULL,
  `deliveryPrice` int(5) DEFAULT NULL,
  `ratingCount` int(5) DEFAULT NULL,
  `sellCount` int(5) DEFAULT NULL,
  `bulletin` text,
  `avatar` char(100) DEFAULT NULL,
  `images` text,
  `infos` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `seller` */

insert  into `seller`(`name`,`description`,`deliveryTime`,`score`,`serviceScore`,`foodScore`,`rankRate`,`minPrice`,`deliveryPrice`,`ratingCount`,`sellCount`,`bulletin`,`avatar`,`images`,`infos`) values ('粥品香坊（回龙观）','蜂鸟专送',38,4.2,4.1,4.3,69.2,20,4,24,90,'粥品香坊其烹饪粥料的秘方源于中国千年古法，在融和现代制作工艺，由世界烹饪大师屈浩先生领衔研发。坚守纯天然、0添加的良心品质深得消费者青睐，发展至今成为粥类的引领品牌。是2008年奥运会和2013年园博会指定餐饮服务商。','http://static.galileo.xiaojukeji.com/static/tms/seller_avatar_256px.jpg','http://fuss10.elemecdn.com/8/71/c5cf5715740998d5040dda6e66abfjpeg.jpeg?imageView2/1/w/180/h/180,\n      http://fuss10.elemecdn.com/b/6c/75bd250e5ba69868f3b1178afbda3jpeg.jpeg?imageView2/1/w/180/h/180,\n      http://fuss10.elemecdn.com/f/96/3d608c5811bc2d902fc9ab9a5baa7jpeg.jpeg?imageView2/1/w/180/h/180,\n      http://fuss10.elemecdn.com/6/ad/779f8620ff49f701cd4c58f6448b6jpeg.jpeg?imageView2/1/w/180/h/180','该商家支持发票,请下单写好发票抬头,\n   品类:其他菜系,包子粥店,\n   北京市昌平区回龙观西大街龙观置业大厦底商B座102单元1340,\n   营业时间:10:00-20:30');

/*Table structure for table `seller_activity` */

DROP TABLE IF EXISTS `seller_activity`;

CREATE TABLE `seller_activity` (
  `type` int(5) DEFAULT NULL,
  `description` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `seller_activity` */

insert  into `seller_activity`(`type`,`description`) values (0,'在线支付满28减5'),(1,'VC无限橙果汁全场8折VC无限橙果汁全场8折'),(2,'单人精彩套餐'),(3,'该商家支持发票,请下单写好发票抬头'),(4,'已加入“外卖保”计划,食品安全保障');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `name` char(30) DEFAULT NULL,
  `account` char(20) DEFAULT NULL,
  `password` char(20) DEFAULT NULL,
  `identity` char(10) DEFAULT '顾客',
  `phoneNumber` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`name`,`account`,`password`,`identity`,`phoneNumber`) values ('Ming','user','123456','商家','123'),('Anny','wu7276','123456','顾客','123'),('fox','account','111','顾客','123'),('hahah','qaz','111','顾客','123'),('aa','xxx','123','顾客','1111'),('qaz','1234','123','顾客','1234567');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
