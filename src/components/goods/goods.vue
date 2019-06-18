<template>
    <div id="goods-container">
      <div class="menu-wrapper" ref="menuWrapper">
        <ul>
          <li v-for="(item,index) in goods" class="menu-item"
              :class="{'current':currentIndex==index}" :key="index"
              @click="selectMenu(index)">
            <span class="text">
              <i v-show="item.type>0" class="icon" :class="classMap[item.type]"></i>{{item.name}}
            </span>
          </li>
        </ul>
      </div>
      <div class="foods-wrapper" ref="foodsWrapper">
        <ul>
          <li v-for="item in goods" class="food-list" ref="foodList">
            <h1 class="title">{{item.name}}</h1>
            <ul>
              <li v-for="food in item.foods" @click="toFoodDetails(food)" class="food-item">
                <div class="icon">
                  <img v-lazy ="food.icon">
                </div>
                <div class="content">
                  <h2 class="name">{{food.name}}</h2>
                  <p class="desc">{{food.description}}</p>
                  <div class="extra">
                    <span class="count">月售{{food.sellCount}}</span><span>好评率{{food.rating}}%</span>
                  </div>
                  <div class="price">
                    <span class="now">￥{{food.price}}</span><span class='old' v-show="food.oldPrice">￥{{food.oldPrice}}</span>
                  </div>
                  <div class="cartcontrol-wrapper" v-if="!showIdentity">
                    <cart-control :food="food" v-on:get-dom="getDom"></cart-control>
                  </div>
                  <div class="icon-position" v-if="showIdentity">
                    <span class="iconfont iconedit-1-copy item" @click.stop.prevent="addFoodPage(2,food)"></span>
                    <span class="iconfont icondelete item" @click.stop.prevent="deleteFood(food.name)"></span>
                  </div>
                </div>
              </li>
            </ul>
          </li>
        </ul>
      </div>
      <shop-cart ref="shopCart" :select-foods="selectFoods"
                :delivery-price="seller.deliveryPrice"
                :min-price="seller.minPrice"
                v-if="!showIdentity">
      </shop-cart>
      <div class="addGood" v-if="showIdentity" @click="addFoodPage(1)">
          <span class="iconfont icontianjiajiahaowubiankuang"></span>
          <span>添加菜品</span>
      </div>

      <food-details ref="foodDetails" :food="detailFood" @receiveDom="getDom"></food-details>

      <delete-confirm-box  ref="deleteConfiremBox" v-on:add-finish="receiveGoodsData"/>
    </div>
</template>

<script>
  import BScroll from 'better-scroll';
  import shopCart from '../shopCart/shopCart.vue';
  import cartControl from '../cartControl/cartControl.vue';

  import FoodDetails from "../foodDetails/foodDetails";
  import AddFoodPage from "../addFoodPage/addFoodPage";
  import DeleteConfirmBox from "../deleteConfirmBox/deleteConfirmBox";
  import {mapGetters} from 'vuex'

  export default {
      name: "goods",
      props:{
        seller:{
          type:Object
        }
      },
      data(){
        return{
          goods:[],
          goodsMenu:[],
          scrollY:0,
          listHeight:[],
          detailFood:{},
          showFlag:false,
          showIdentity:false,
        }
      },
      created(){
        if(sessionStorage.getItem("identity") != null){
          let sesstionObj = JSON.parse(sessionStorage.getItem('identity'));
          if(sesstionObj.identity === '商家'){
            this.showIdentity = true
          }
        }
        this.classMap = ['decrease','discount','special','invoice','guarantee']
        this.receiveGoodsData()
        if(this.obj.identity=='商家'){
          this.showIdentity = true
        }
      },
      computed:{
        currentIndex() {
          for (let i = 0; i < this.listHeight.length; i++) {
            let height1 = this.listHeight[i];
            let height2 = this.listHeight[i + 1];
            if ( (this.scrollY >= height1 && this.scrollY < height2) ||!height2) {
              return i;
            }
          }
          return 0;
        },
        selectFoods(){
          let foods = [];
          for(let good of this.goods){
            for(let food of good.foods){
              if(food.count){
                foods.push(food);
              }
            }
          }
          return foods;
        },
        ...mapGetters([
          'obj'
        ]),
      },
      methods:{
        receiveGoodsData(){
          let _this = this;
          this.$axios.get('/api/GET/goodsMenu')
            .then( response => {
              //获得商品类类名
              console.log('goodsMenu',response)
              _this.goodsMenu = response.data
              response = null;
            })
            .then(()=>{
              _this.$axios.get('/api/GET/goods')
                .then( response => {
                  //获得所有商品并进行分类
                  let arr = _this._formatGoods(response.data);
                  for(let i = 0 ; i<= _this.goodsMenu.length-1;i++){
                    _this.$set(_this.goodsMenu[i],'foods',arr[i])
                  }
                  _this.goods = _this.goodsMenu;
                  _this.goodsMenu = null;
                  response = null;
                  //完成数据获取后，执行
                  _this.$nextTick(()=>{
                    _this._initScroll();
                    _this._calculateHeight();
                  })
                });
            })
        },

        deleteFood(name) {
          this.$refs.deleteConfiremBox._initData(name);
        },
        _formatGoods(arr){
          var myarr = []; //先声明一维
          for ( var i = 0; i <= this.goodsMenu.length ; i++) {
            myarr[i] = []; //再声明二维
          }
          //1.热销榜放销量前6的
          for(var i = 0 ; i <= 5; i++ ){
            // console.log(arr[i])
            // console.log(Object.assign(arr[i]))
            myarr[0].push(JSON.parse(JSON.stringify(arr[i])))
            let index = this._formatString(arr[i].id).map(Number)
            //字符串转化为数字
            for(let j of index){
              myarr[j].push(JSON.parse(JSON.stringify(arr[i])))
            }
          }
          for(let num = 6; num <= arr.length-1; num++){
            let index = this._formatString(arr[num].id).map(Number)
            for(let j of index){
              // 复制数组副本，因为可能存在一个商品对应多个数组
              myarr[j].push(JSON.parse(JSON.stringify(arr[num])))
            }
          }
          console.log('格式化数据',myarr)
          arr = null;
          return myarr;
        },
        _formatString(string){
         return string.split(',');
        },
        _initScroll(){
          this.menuScroll = new BScroll(this.$refs.menuWrapper,{
            click:true
          });
          this.foodsScroll = new BScroll(this.$refs.foodsWrapper, {
            click: true,
            probeType: 3
          });
          let _this = this;
          this.foodsScroll.on('scroll',(pos)=>{
            _this.scrollY = Math.abs(Math.round(pos.y));
            // 测试是否实时获取Y值
            // console.log(_this.scrollY);
          })
        },
        _calculateHeight(){
          // console.log('-------',document.getElementsByClassName('food-list'))
          let foodList = document.getElementsByClassName('food-list');
          let height = 0;
          this.listHeight.push(height);
          for(let i = 0; i<foodList.length;i++){
            let item = foodList[i];
            height+=item.clientHeight;
            this.listHeight.push(height);
          }
          //测试是否获取每一个DIV的高
          // console.log('测试测试',this.listHeight);

        },

        selectMenu(index){
          let foodList = this.$refs.foodList;
          let el = foodList[index];
          this.foodsScroll.scrollToElement(el,200);
        },

        getDom(dom){
          this.$refs.shopCart.getPosition(dom);
        },

        toFoodDetails(obj){
          console.log('传入foodDetails对象',obj)
          this.detailFood = obj;
          this.$refs.foodDetails.receiveFoodRatings(obj);
          this.$refs.foodDetails.show();
        },

        addFoodPage(type,obj){
          let title = '';
          if(type == 1){
            title = '添加商品'
          }else{
            title = '修改商品信息'
            sessionStorage.setItem('food',JSON.stringify(obj))
          }
          sessionStorage.setItem('title',JSON.stringify(title))
          this.$router.push({path:'/addFoodPage'})
        },
      },
      components:{
        DeleteConfirmBox,
        AddFoodPage,
        FoodDetails,
        shopCart,
        cartControl,
      }
    }
</script>

<style lang="stylus" scoped>
#goods-container
  display: flex;
  position: absolute;
  top:px-to-rem(174)
  width:100%;
  bottom: px-to-rem(46)
  overflow: hidden;
  .menu-wrapper
    flex: 0 0 px-to-rem(80)
    width: px-to-rem(80)
    background: #f3f5f7
    .menu-item
      flex:0 0 px-to-rem(56)
      width:px-to-rem(56)
      line-height: px-to-rem(14)
      padding:px-to-rem(20) px-to-rem(12)
      border-1px(rgba(7, 17, 27, 0.1))
      &.current
        position: relative
        z-index: 10
        margin-top: -1px
        background: #fff
        font-weight: 700
        border-none()
      .text
        vertical-align: middle;
        width: px-to-rem(56)
        font-size: px-to-rem(12)
        no-more-than-two()
        .icon
          display: inline-block
          vertical-align: top;
          width: px-to-rem(12)
          height: px-to-rem(12)
          margin-right: px-to-rem(2)
          background-size: px-to-rem(12) px-to-rem(12)
          background-repeat: no-repeat
          &.decrease
            bg-image('decrease_3')
          &.discount
            bg-image('discount_3')
          &.guarantee
            bg-image('guarantee_3')
          &.invoice
            bg-image('invoice_3')
          &.special
            bg-image('special_3')

  .foods-wrapper
    flex: 1
    text-align left
    .title
      padding-left: px-to-rem(14)
      height: px-to-rem(26)
      line-height: px-to-rem(26)
      border-left: px-to-rem(2) solid #d9dde1
      font-size: px-to-rem(12)
      color: rgb(147, 153, 159)
      background: #f3f5f7
    .food-item
      display: flex
      margin: px-to-rem(18)
      padding-bottom: px-to-rem(18)
      border-1px(rgba(7, 17, 27, 0.1))
      &:last-child
        border-none()
        margin-bottom: 0
      .icon
        flex: 0 0 px-to-rem(57)
        margin-right: px-to-rem(10)
        &>img
          width:px-to-rem(57)
          height:px-to-rem(57)
      .content
        flex: 1
        position: relative
        text-align: left;
        .name
          margin: px-to-rem(2) 0 px-to-rem(8) 0
          height: px-to-rem(14)
          line-height: px-to-rem(14)
          font-size: px-to-rem(14)
          color: rgb(7, 17, 27)
        .desc, .extra
          line-height: px-to-rem(10)
          font-size: px-to-rem(10)
          color: rgb(147, 153, 159)
        .desc
          line-height: px-to-rem(12)
          margin-bottom: px-to-rem(8)
        .extra
          .count
            margin-right: px-to-rem(12)
        .price
          font-weight: 700
          line-height: px-to-rem(24)
          .now
            margin-right: px-to-rem(8)
            font-size: px-to-rem(14)
            color: rgb(240, 20, 20)
          .old
            text-decoration: line-through
            font-size: px-to-rem(10)
            color: rgb(147, 153, 159)
        .cartcontrol-wrapper
          position: absolute
          right: 0
          bottom: px-to-rem(12)
        .icon-position
          position: absolute
          top:0
          right:0
          .item
            display: inline-block
          .iconfont
            font-size px-to-rem(16)
  .addGood
    position: fixed
    left: 0
    bottom: 0
    z-index: 50
    width: 100%
    height: px-to-rem(48)
    line-height: px-to-rem(48)
    font-size px-to-rem(20);
    background-color #FF7F24
    color: #fff
    .iconfont
      font-size px-to-rem(16);

</style>
