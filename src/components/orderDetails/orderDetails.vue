<template>
  <transition name="slide">
    <div id="orderDetails-container" v-show="showFlag">
      <div>
        <div class="box">
          <div class="title" @click="back()">
            <span class="icon"><i class="icon-arrow_lift"></i></span>
            订单详情
          </div>
          <div class="food-item" v-for="food in selectFoods">
            <div class="icon">
              <img v-lazy="food.icon">
            </div>
            <div class="content">
              <h2 class="name">{{food.name}}</h2>
              <p class="desc">x{{food.number}}</p>
              <div class="price">
                <div class="now">￥{{food.price}}</div>
              </div>
            </div>
          </div>
          <div class="infos" >
            <p>
              <span class="textLabel">配送费</span>
              <span class="deliveryPrice">￥4</span>

            </p>
            <p v-show="totalPrice>28">
              <span class="textLabel">在线支付满28减5</span>
              <span class="deliveryPrice">-￥5</span>
            </p>
          </div>
          <div class="infos">
            <div class="totalPriceStyle">￥{{actualPrice}}元</div>
          </div>
          <div class="last" v-show="badgeIdentity">
            <span class="buttonStyle"  @click="toRatingPage">确认收货</span>
          </div>
        </div>

      </div>
    </div>
  </transition>
</template>

<script>
    export default {
      name: "order-details",
      data(){
        return{
          showFlag:false,
          selectFoods:[],
          foodArr:[],
          obj:{},

        }
      },
      mounted(){
        this.foodArr = JSON.parse(sessionStorage.getItem('foodArr'))
      },
      computed:{
        totalPrice(){
          let total = 0;
          for(let i of this.selectFoods){
            total += i.price*i.number;
          }
          //配送费4元,满28减5元
          return total;
        },
        actualPrice(){
          if(this.totalPrice>=28){
            return this.totalPrice - 1;
          }else{
            return this.totalPrice + 4;
          }
        },
        badgeIdentity(){
          if(sessionStorage.getItem('identity')){
            let obj = JSON.parse(sessionStorage.getItem('identity'))
            if(obj.identity=='顾客'&&this.obj.orderStatus=='2'){
              return true;
            }
          }
          return false;
        }

      },
      methods:{
        show(obj){
          this.obj = obj;
          this.showFlag = true;
        },
        back(){
          this.showFlag = false;
        },
        _initSelectFood(obj){
          let arr = []
          let item = {
            name:'',
            price:'',
            number:'',
            icon:'',
          }
          let nameArr = obj.goodsName.split(',')
          let priceArr = obj.price.split(',')
          let numberArr = obj.numbers.split(',')
          let iconArr = obj.icon.split(',')
          for(let i = 0 ;i<=nameArr.length-1;i++){
            item.name = nameArr[i]
            item.price = priceArr[i]
            item.number = numberArr[i]
            item.icon = iconArr[i]
            arr.push(item);
            item = {
              name:'',
              price:'',
              number:'',
              icon:'',
            }
          }
          console.log(arr)
          this.selectFoods =  arr
        },
        toRatingPage(){
          let that = this;
          let obj = JSON.parse(sessionStorage.getItem('delivery'))
          this.$axios.put('/api/PUT/changeOrderStatus',{
            data:{
              createTime:JSON.parse(sessionStorage.getItem('createTime')),
              type:'3',
              name:obj.name,
              mode:'2',
            }
          })
            .then(() =>{
              this.$axios.put('/api/PUT/increateTheFoodCount', {
                data: {
                  arr: this.foodArr,
                }
              })
                .then(()=>{
                  if(confirm('交易成功是否去评价一下')) {
                    this.$router.push({path: "/ratingFoodPage"})
                  }else{
                    this.$router.push({path: "/goods"})
                  }
                })


          }).then(()=>{

                this.$emit('add-finish')
            })

        },

      }
    }
</script>

<style lang="stylus" scoped>
  .slide-leave-active,.slide-enter-active
    transition: all 0.3s linear;
  .slide-leave-to,.slide-enter
    transform: translate3d(100%,0,0);
  #orderDetails-container
    position: fixed;
    left:0;
    top:0;
    bottom: 0;
    z-index:150;
    width:100%;
    background:#fff;
    overflow: hidden;
    text-align left
    .box
      padding-top:px-to-rem(20);
      .title
        height:px-to-rem(30)
        line-height: px-to-rem(30)
        font-weight: 700;
        font-size: px-to-rem(14);
        color:rgb(7,17,27);
        text-align: center
        .icon
          display: inline-block
          position: absolute
          left:px-to-rem(18)
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
            margin-bottom px-to-rem(5);
            height: px-to-rem(20)
            line-height: px-to-rem(20)
            font-size: px-to-rem(14)
            color: rgb(7, 17, 27)
          .desc
            font-size: px-to-rem(12)
            color: rgb(147, 153, 159)
            line-height: px-to-rem(12)
            margin-bottom: px-to-rem(8)
            &:last-child
              margin-bottom 0
          .price
            position: absolute
            top:0
            right:0;
            .now
              font-size: px-to-rem(16)
              color: rgb(240, 20, 20)
            .old
              text-decoration: line-through;
              font-size: px-to-rem(16)
              color: #93999f;
              margin-bottom px-to-rem(10)

      .infos
        margin: px-to-rem(18)
        padding-bottom: px-to-rem(18)
        border-1px(rgba(7, 17, 27, 0.1))
        &>p
          position: relative
        .textLabel,.deliveryPrice
          height:px-to-rem(30)
          line-height:px-to-rem(30)
          font-size px-to-rem(16)
        .deliveryPrice
          position: absolute
          top:0;
          right:0;

        .totalPriceStyle
          text-align: right
          font-size px-to-rem(18)
          color: #f01414

      .last
        padding px-to-rem(30) 0 px-to-rem(50) 0;
        text-align right
        .buttonStyle
          font-size px-to-rem(14)
          padding:px-to-rem(10) px-to-rem(30)
          background-color #f01414
          color: #fff


</style>
