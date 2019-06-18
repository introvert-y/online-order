<template>
  <transition name="slide">
    <div id="confirm-order-container" ref="confirmOrderContainer">
      <div>
        <div class="box">
          <div class="title" @click="back()">
            <span class="icon"><i class="icon-arrow_lift"></i></span>
            订单信息
          </div>
          <div class="food-item" v-for="food in selectFoods">
            <div class="icon">
              <img v-lazy="food.icon">
            </div>
            <div class="content">
              <h2 class="name">{{food.name}}</h2>
              <p class="desc">{{food.description}}</p>
              <p class="desc">x{{food.count}}</p>
              <div class="price">
                <div class='old' v-show="food.oldPrice">￥{{food.oldPrice}}</div>
                <div class="now">￥{{food.price}}</div>
              </div>
            </div>
          </div>
          <div class="infos">
            <p>
              <span class="textLabel">配送费</span>
              <span class="deliveryPrice">￥{{deliveryPrice}}</span>
            </p>
            <p v-if="totalPrice>=28">
              <span class="textLabel">在线支付满28减5</span>
              <span class="deliveryPrice">-￥5</span>
            </p>
          </div>
          <div class="infos">
            <div class="totalPriceStyle">￥{{actualPrice}} 元</div>
          </div>
          <div class="input-box">
            <h2 id="title">配送地址:</h2>
            <el-input
              type="textarea"
              autosize
              placeholder="请输入内容"
              v-model="text">
            </el-input>
          </div>
          <div class="last">
            <span class="buttonStyle" @click="pay">确认支付</span>
          </div>
        </div>

      </div>
    </div>
  </transition>
</template>

<script>
  import BScroll from 'better-scroll';

  export default {
      name: "confirm-order",
      data(){
        return{
          selectFoods:[],
          deliveryPrice:'',
          foodArr:[],
          nameArr:[],
          numberArr:[],
          priceArr:[],
          iconArr:[],
          text:'',
        }
      },
      created(){
        this.$nextTick(() =>{
          this._initScroll();
        })
      },
      mounted(){
        this.deliveryPrice = JSON.parse(sessionStorage.getItem('deliveryPrice'))
        this.selectFoods = JSON.parse(sessionStorage.getItem('selectFoods'))
        if(this.selectFoods.length>0){
          this._formateData(this.selectFoods)
        }

      },

    computed:{
        totalPrice(){
          let total = 0;
          for(let i of this.selectFoods){
            total += i.price*i.count;
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
        }
      },
      methods:{
        pay(){
          if(this.text==''){
            alert('配送地址不能为空')
            return;
          }

          sessionStorage.setItem('createTime',JSON.stringify(Date.parse(new Date())))
          this.$axios.post('/api/POST/addOrder',{
            data:{
              createTime:Date.parse(new Date()),
              userName:JSON.parse(sessionStorage.getItem('identity')).name,
              nameArr:this.nameArr.join(','),
              numberArr:this.numberArr.join(','),
              priceArr:this.priceArr.join(','),
              iconArr:this.iconArr.join(','),
              totalPrice:this.actualPrice,
              orderStatus:'0',
              address:this.text
            }
          })
          .then( response => {
            alert('支付成功，等待商家接单')
            this.$router.push({path:'/waitForTime'})
          });
        },
        back(){
          this.$router.push({path:'/goods'})
        },

        _initScroll() {
          if(!this.confirmContainer){
            this.confirmContainer = new BScroll(this.$refs.confirmOrderContainer,{
              click:true
            })
          }else{
            this.confirmContainer.refresh();
          }
        },
        _formateData(newData){
          let arr = [];
          let obj = {
            name:'',
            score:0,
            text:'',
            count:'',
            price:'',
            icon:''
          }
          for(let i of newData){
            obj.name = i.name;
            obj.count = i.count;
            this.nameArr.push(i.name)
            this.numberArr.push(i.count)
            this.priceArr.push(i.price)
            this.iconArr.push(i.icon)
            arr.push(obj)
            obj = {
              name:'',
              score:0,
              text:'',
              count:'',
              price:'',
              icon:''
            }
          }
          this.foodArr = arr
          sessionStorage.setItem('foodArr',JSON.stringify(this.foodArr))
        }
      }
    }
</script>

<style lang="stylus" scoped>
  .slide-leave-active,.slide-enter-active
    transition: all 0.3s linear;
  .slide-leave-to,.slide-enter
    transform: translate3d(100%,0,0);
  #confirm-order-container
    position: fixed;
    left:0;
    top:0;
    bottom: 0;
    z-index:100;
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
      .input-box
        margin: px-to-rem(18)
        #title
          font-size px-to-rem(16)
          height:px-to-rem(30)
          line-height:px-to-rem(30)
      .last
        padding px-to-rem(30) 0 px-to-rem(50) 0;
        text-align right
        .buttonStyle
          font-size px-to-rem(14)
          padding:px-to-rem(10) px-to-rem(30)
          background-color #f01414
          color: #fff

</style>
