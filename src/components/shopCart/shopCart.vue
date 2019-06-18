<template>
    <div id="shopCart-container">
    <div class="content" @click=toggleList>
      <div class="content-left">
        <div class="logo-wrapper">
          <div class="logo" :class="{highLight:totalCount>0}" ref="logoCart">
            <span class="icon-shopping_cart"></span>
          </div>
          <div class="number" v-show="totalCount>0">{{totalCount}}</div>
        </div>
        <div class="price" :class="{highLight:totalPrice>0}">￥{{totalPrice}}元</div>
        <div class="desc">另需配送费￥{{deliveryPrice}}元</div>
      </div>
      <!-- click.stop.prevent阻止其他点击事件 -->
      <div class="content-right" @click.stop.prevent="pay">
        <div class="pay" :class="payClass">
          {{payDesc}}
        </div>
      </div>
    </div >
    <div class="ball-container">
      <transition-group @before-enter="beforeEnter"
                        @enter="enter" @after-enter='afterEnter'>
        <div class="ball" v-for="ball in balls"
             v-show="ball.show" :key="ball.index">
        </div>
      </transition-group>
    </div>
    <transition name="slide">
      <div class="shopcart-list" v-show="listShow">
        <div class="list-header">
          <h1 class="title">购物车</h1>
          <span class="empty" @click="empty">清空</span>
        </div>
        <div class="list-content" ref="listContent">
          <ul>
            <li class="food" v-for="food in selectFoods">
              <span class="name">{{food.name}}</span>
              <div class="price">
                <span>￥{{food.price*food.count}}</span>
              </div>
              <div class="cartcontrol-wrapper">
                <cart-control :food="food" v-on:get-dom="getPosition"></cart-control>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </transition>
    <transition name="fade">
      <div class="list-mask" v-show="listShow" @click="fold=true"></div>
    </transition>
    </div>
</template>

<script>
  import BScroll from 'better-scroll';
  import cartControl from '../cartControl/cartControl.vue';

  export default {
      name: "shop-cart",
      data(){
        return{
          balls:[
            {
              index:0,
              show:false
            },
            {
              index:1,
              show:false
            },
            {
              index:2,
              show:false
            },
            {
              index:3,
              show:false
            },
            {
              index:4,
              show:false
            },
            {
              index:5,
              show:false
            },
            {
              index:6,
              show:false
            },
            {
              index:8,
              show:false
            },
            {
              index:9,
              show:false
            },

          ],
          domLeft:0,
          domTop:0,
          fold:true,
        }
      },
      props:{
        selectFoods:{
          type:Array,
          default(){
            return [
              {

              }
            ];
          }
        },
        deliveryPrice:{
          type:Number,
          default:0
        },
        minPrice:{
          type:Number,
          default:0
        }
      },
      computed:{
        totalPrice(){
          let total = 0;
          for(let i of this.selectFoods){
            total += i.price*i.count;
          }
          return total;
        },
        totalCount(){
          let count = 0;
          for(let i of this.selectFoods){
            count += i.count;
          }
          return count;
        },
        payDesc(){
          if(this.totalPrice===0){
            return `￥${this.minPrice}元起送`;
          }else if(this.totalPrice<this.minPrice){
            let diff = this.minPrice - this.totalPrice;
            return `还差${diff}元起送`;
          }else{
            return '去结算';
          }
        },
        payClass(){
          if(this.totalPrice<this.minPrice){
            return 'not-enough';
          }else{
            return 'enough';
          }
        },
        listShow(){
          if(!this.totalCount){
            this.fold = true;
            return false;
          }
          let show = !this.fold;
          if(show){
            this.$nextTick(()=>{
              if(!this.scroll){
                this.scroll = new BScroll(this.$refs.listContent,{
                  click:true
                })
              }else{
                this.scroll.refresh();
              }

            })
          }
          return show;
        }
      },
      methods: {
          pay() {
          if (this.totalPrice < this.minPrice) {
            return;
          }
          sessionStorage.setItem('deliveryPrice',this.deliveryPrice)
          sessionStorage.setItem('selectFoods',JSON.stringify(this.selectFoods))
          //vuex没有获取到值，或者sessionStorage没有获取到值就跳转到登录页面。
          let Flag = JSON.parse(sessionStorage.getItem('identity'))
          if(Flag==null||Flag=='undefined'){
            alert('还没登录，请先登录')
            this.$router.push({path:'/login'})
          }else{
            this.$router.push({path:'/confirmOrder'})
          }


        },
        getPosition(target) {
          // console.log("我是shopcart的getPosition方法");
          // console.log(target);
          this.domLeft = target.getBoundingClientRect().left + 12;
          this.domTop = target.getBoundingClientRect().top + 12;
          // console.log(this.domLeft);
          // console.log(this.domTop);
          //设置小球
          for (let i = 0; i < this.balls.length; i++) {
            let ball = this.balls[i];
            if (!ball.show) {
              ball.show = true;
              return;
            }
          }
        },
        beforeEnter(el) {
          // console.log(el)
          // console.log('我是beforeEnter', this.domLeft, this.domTop);
          el.style.left = this.domLeft + 'px';
          el.style.top = this.domTop + 'px';
        },
        enter(el, done) {
          let ballWidth = this.$refs.logoCart.clientWidth / 2;
          let ballHeight = this.$refs.logoCart.clientHeight / 2;
          let totalLeft = this.$refs.logoCart.getBoundingClientRect().left;
          let totalTop = this.$refs.logoCart.getBoundingClientRect().top;
          // console.log('我是Enter', totalLeft, totalTop);
          el.style.left = totalLeft + ballWidth + 'px';
          el.style.top = totalTop + ballHeight + 'px';
          el.style.transition = 'all 0.8s ease';
          setTimeout(function () {
            done()
          }, 200);
          // console.log('---------', el)
        },
        afterEnter(el) {
          // console.log('我是afterEnter');
          let _this = this;
          setTimeout(function () {
            for (let i = 0; i < _this.balls.length; i++) {
              let ball = _this.balls[i]
              if (ball) {
                ball.show = false;
                el.style.display = 'none';
              }
            }
          }, 600);
        },
        toggleList() {
          if (!this.totalCount) {
            return;
          }
          this.fold = !this.fold;
        },
        empty() {
          for (let i of this.selectFoods) {
            i.count = 0;
          }
        },
      },
      components:{
        cartControl,
      }
    }
</script>

<style lang="stylus" scoped>
  #shopCart-container
    position: fixed
    left: 0
    bottom: 0
    z-index: 50
    width: 100%
    height: px-to-rem(48)
    .content
      display: flex
      background: #141d27
      font-size: 0
      color: rgba(255, 255, 255, 0.4)
      -webkit-transform: translateZ(0);
      .content-left
        flex: 1
        .logo-wrapper
          display: inline-block
          vertical-align: top
          text-align: left;
          position: relative
          top: px-to-rem(-10)
          margin: 0 px-to-rem(12)
          padding: px-to-rem(6)
          width: px-to-rem(56)
          height: px-to-rem(56)
          box-sizing: border-box
          border-radius: 50%
          background: #141d27
          .logo
            width: 100%
            height: 100%
            border-radius: 50%
            text-align: center
            background: #2b343c
            &.highLight
              background: rgb(0, 160, 220)
              &>span
                color: #fff
            .icon-shopping_cart
              line-height: px-to-rem(44)
              font-size: px-to-rem(24)
              color: #80858a

          .number
            position: absolute
            top: 0
            right: 0
            width: px-to-rem(24)
            height: px-to-rem(16)
            line-height: px-to-rem(16)
            text-align: center
            border-radius: px-to-rem(16)
            font-size: px-to-rem(9)
            font-weight: 700
            color: #fff
            background: rgb(240, 20, 20)
            box-shadow: 0 px-to-rem(4) px-to-rem(8) 0 rgba(0, 0, 0, 0.4)
        .price
          display: inline-block
          vertical-align: top
          margin-top: px-to-rem(12)
          line-height: px-to-rem(24)
          padding-right: px-to-rem(12)
          box-sizing: border-box
          border-right: 1px solid rgba(255, 255, 255, 0.1)
          font-size: px-to-rem(16)
          font-weight: 700
          &.highLight
            color: #fff
        .desc
          display: inline-block
          vertical-align: top
          margin: px-to-rem(12) 0 0 px-to-rem(12)
          line-height: px-to-rem(24)
          font-size: px-to-rem(10)
      .content-right
        flex: 0 0 px-to-rem(105)
        width: px-to-rem(105)
        .pay
          height: px-to-rem(48)
          line-height: px-to-rem(48)
          text-align: center
          font-size: px-to-rem(12)
          font-weight: 700
          &.not-enough
            background: #2b333b
          &.enough
            background: #00b43c
            color: #fff
    .ball-container
      .ball
        position: fixed;
        width:px-to-rem(16);
        height: px-to-rem(16);
        border-radius: 50%;
        background: rgb(0,160,220);
        z-index: 200;

    .slide-leave-active,.slide-enter-active
      transition: all 0.5s;
    .slide-leave-to,.slide-enter
      transform:translateY(100%);
      opacity: 0;
    .shopcart-list
      position: absolute;
      text-align left
      bottom:px-to-rem(48);
      left:0;
      z-index:-1;
      width:100%;
      .list-header
        height:px-to-rem(40);
        line-height: px-to-rem(40);
        padding:0 px-to-rem(18);
        background: #f3f5f7;
        border-bottom: px-to-rem(1) solid rgba(7,17,27,0.1);
        .title
          float: left;
          font-size: px-to-rem(14)
          color:rgb(7,17,27);
        .empty
          float: right;
          font-size: px-to-rem(12);
          color:rgb(0,160,220);


      .list-content
        padding: 0 px-to-rem(18);
        max-height: px-to-rem(217);
        overflow: hidden;
        background: #fff;
        .food
          position: relative;
          padding:px-to-rem(12) 0;
          box-sizing: border-box;
          border-1px(rgba(7,17,27,0.1))
          .name
            line-height: px-to-rem(24);
            font-size: px-to-rem(14)
            color:rgb(7,17,27);
          .price
            position: absolute;
            right:px-to-rem(90);
            bottom: px-to-rem(12);
            line-height: px-to-rem(24);
            font-size: px-to-rem(14)
            font-weight: 700;
            color:rgb(240,20,20);
          .cartcontrol-wrapper
            position: absolute;
            right:0;
            bottom: 6px;

    .fade-leave-active,.fade-enter-active
      transition: all 0.5s;
    .fade-leave-to,.fade-enter
      opacity: 0;

    .list-mask
      position: fixed;
      top:0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -2;
      background:rgba(7,17,27,0.6);

</style>
