<template>
  <transition name="slide">
    <div id="food-container" v-show="showFlag"  ref="foodContainer">
      <div class="food-content" ref="foodList">
        <div class="image-header">
          <img :src="food.image">
          <div class="back" @click.stop="back">
            <i class="icon-arrow_lift"></i>
          </div>
        </div>
        <div class="content">
          <h1 class="title">{{food.name}}</h1>
          <div class="detail">
            <span class="sell-count">月售{{food.sellCount}}份</span><span class="rating">好评率{{food.rating}}%</span>
          </div>
          <div class="price">
            <span class="now">￥{{food.price}}</span><span class='old' v-show="food.oldPrice">￥{{food.oldPrice}}</span>
          </div>
          <div class="cartcontrol-wrapper" v-if="!showIdentity">
            <cart-control :food="food" v-on:get-dom="addCount" ref="cartControl"/>
          </div>
          <div class="buy" v-if="!showIdentity" v-show="!food.count||food.count===0" @click.stop="addFood()">加入购物车</div>
        </div>
        <split v-show="food.info"></split>
        <div class="info">
          <h1 class="title">商品信息</h1>
          <p class="text" v-show="food.info">{{food.info}}</p>
        </div>
        <split></split>
        <div class="rating">
          <h1 class="title">商品评价</h1>
          <rating-select :desc="desc" :ratings="theRatings"
                         v-on:rating-type-select="ratingTypeSelect"
                         v-on:rating-content-toggle="ratingContentToggle">
          </rating-select>
        </div>
        <div class="rating-wrapper">
          <ul v-show="foodRatingFlag">
            <li v-show="needShow(rating.rateType,rating.text)" v-for="rating in theRatings" class="rating-item">
              <div class="user">
                <span class="name">{{rating.username}}</span>
                <img :src="rating.avatar" width="12" height="12" class="avatar">
              </div>
              <div class="time">{{_formatTime(rating.rateTime)}}</div>
              <p class="text">
                <span :class="{'icon-thumb_up':rating.rateType===0,'icon-thumb_down':rating.rateType===1}"></span>
                <span>{{rating.text}}</span>
              </p>
            </li>
          </ul>
          <div class="no-rating" v-show="!foodRatingFlag">暂无评价</div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
  import BScroll from 'better-scroll';
  import split from "../split/split.vue";
  import ratingSelect from '../ratingSelect/ratingSelect.vue';
  import cartControl from '../cartControl/cartControl.vue';


  const POSITIVE = 0;
  const NEGATIVE = 1;
  const ALL = 2;

    export default {
      name: "food-details",
      props:{
        food:{
          type:Object
        }
      },
      data(){
        return{
          theRatings:[],
          showIdentity:false,
          showFlag:false,
          selectType:ALL,
          onlyContent:true,
          desc:{
            all:'全部',
            positive:'推荐',
            negative:'吐嘈'
          },
        }
      },
      mounted(){
        if(sessionStorage.getItem("identity") != null){
          let sesstionObj = JSON.parse(sessionStorage.getItem('identity'));
          if(sesstionObj.identity === '商家'){
            this.showIdentity = true;
          }
        }

      },
      methods:{
        show(){
          this.showFlag = true;
        },
        receiveFoodRatings(obj){
          console.log(obj.name)
          this.$axios.get(`/api/GET/theRatings?name=${obj.name}`)
            .then( response => {
              console.log('theRatings',response)
              this.theRatings = response.data;
              this.$nextTick(()=>{
                if(!this.foodContainer){
                  this.foodContainer = new BScroll(this.$refs.foodContainer,{
                    click:true
                  })
                }else{
                  this.foodContainer.refresh();
                }
              })
            });
        },
        addFood(){
          // this.$set(this.food,'count',1);
          // this.$emit('receiveDom',event.target);
          this.$refs.cartControl.addCount();
        },
        back(){
          this.showFlag = false;
        },
        addCount(){
          this.$emit('receiveDom',event.target);
        },
        needShow(type,text){
          if(this.onlyContent&&!text){
            return false;
          }
          if(this.selectType === ALL){
            return true;
          }else{
            return type===this.selectType;
          }
        },
        ratingTypeSelect(type){
          this.selectType = type;
          this.$nextTick(()=>{
            this.foodContainer.refresh();
          })
        },
        ratingContentToggle(judgeOnlyContent){
          this.onlyContent = judgeOnlyContent;
          this.$nextTick(()=>{
            this.foodContainer.refresh();
          })
        },
        _formatTime(value){
          let timeNumber = Number(value);
          let date = new Date(timeNumber);
          let year = date.getFullYear();
          let month = date.getMonth() + 1;
          let day = date.getDate();
          let str = year.toString()+ "/"+month.toString()+ "/"+day.toString();
          let hour = date.getHours();
          let minute = date.getUTCMinutes();
          let s = date.getUTCSeconds()
          let time = hour.toString()+":"+minute.toString()+":"+s.toString();
          let total = str+" "+time;
          return total;
        }

      },
      computed:{
        foodRatingFlag(){
          return (this.theRatings)&&(this.theRatings.length);
        }

      },
      components:{
        cartControl,
        split,
        ratingSelect
      }
    }
</script>

<style lang="stylus" scoped>
  .slide-leave-active,.slide-enter-active
    transition: all 0.3s linear;
  .slide-leave-to,.slide-enter
    transform: translate3d(100%,0,0);

  #food-container
    position: fixed;
    left:0;
    top:0;
    bottom: px-to-rem(48);
    z-index:30;
    width:100%;
    background:#fff;
    text-align left
    .food-content
      .image-header
        /*图片的高度跟屏幕一致*/
        position: relative;
        width: 100%;
        height: 0;
        padding-top: 100%;
        /*这时候padding-top:100%是相对于width的宽度的*/
        &>img
          position: absolute;
          top:0;
          left:0;
          width:100%;
          height: 100%;
        .back
          position: absolute;
          top:px-to-rem(10);
          left:0;
          .icon-arrow_lift
            display: block;
            padding: px-to-rem(10);
            font-size: 20px;
            color:#fff;



      .content
        position: relative;
        padding: px-to-rem(18);
        .title
          line-height: px-to-rem(14);
          margin-bottom: px-to-rem(8);
          font-size: px-to-rem(14);
          font-weight: 700;
          color:rgb(7,17,27);

        .detail
          margin-bottom: px-to-rem(18);
          line-height: px-to-rem(10);
          height: px-to-rem(10);
          font-size: 0;
        .sell-count,.rating
          font-size: px-to-rem(10);
          color:rgb(147,153,159);
        .sell-count
          margin-right: px-to-rem(12);
        .price
          font-weight: 700;
          line-height: px-to-rem(24);
          .now
            margin-right: px-to-rem(8);
            font-size: px-to-rem(14);
            color:rgb(240,20,20);
          .old
            text-decoration: line-through;
            font-size: px-to-rem(10);
            color:rgb(147,153,159);

        .cartcontrol-wrapper
          position: absolute;
          right:px-to-rem(12);
          bottom: px-to-rem(12)
        .buy
          position: absolute;
          right:px-to-rem(18);
          bottom:px-to-rem(18);
          z-index: 40;
          height: px-to-rem(24);
          line-height: px-to-rem(24);
          padding: 0 px-to-rem(12);
          box-sizing: border-box;
          font-size: px-to-rem(10);
          border-radius: px-to-rem(12);
          color:#fff;
          background: rgb(0,160,220)

      .info
        padding: px-to-rem(18);
        .title
          line-height: px-to-rem(14);
          margin-bottom: px-to-rem(6);
          font-weight: 700;
          font-size: px-to-rem(14);
          color:rgb(7,17,27);

        .text
          line-height: px-to-rem(24);
          padding:0 px-to-rem(8);
          font-size: px-to-rem(12);
          color:rgb(77,85,93);

      .rating
        padding-top:px-to-rem(18);
        .title
          line-height: px-to-rem(14);
          margin-left: px-to-rem(18);
          font-weight: 700;
          font-size: px-to-rem(14);
          color:rgb(7,17,27);

      .rating-wrapper
        padding: 0 px-to-rem(18);
        .rating-item
          position: relative;
          padding: px-to-rem(16) 0;
          border-1px(rgba(7,17,27,0.1))
        .user
          position: absolute;
          right:0;
          top:px-to-rem(16);
          font-size: 0;
          line-height: px-to-rem(12);
          .name
            display: inline-block;
            vertical-align: top;
            margin-right: px-to-rem(6);
            font-size: px-to-rem(10);
            color:rgb(147,153,159);
          .avatar
            border-radius: 50%;


        .time
          margin-bottom:px-to-rem(6);
          line-height: px-to-rem(12);
          font-size: px-to-rem(10);
          color:rgb(147,153,159);
        .text
          line-height: px-to-rem(16);
          font-size: px-to-rem(12);
          color:rgb(7,17,27);
          &>span
            vertical-align middle
          .icon-thumb_up,.icon-thumb_down
            margin-right: px-to-rem(4);
            line-height: px-to-rem(16);
            font-size: px-to-rem(12);
          .icon-thumb_up
            color:rgb(0,160,220);
          .icon-thumb_down
            color:#A8A8A8


        .no-rating
          padding: px-to-rem(16) 0;
          font-size: px-to-rem(12);
          color:rgb(147,153,159);




</style>

