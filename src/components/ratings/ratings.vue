<template>
  <div id="ratings-container" ref="dom">
    <div class="ratings-content">
      <div class="overview">
        <div class="overview-left">
          <h1 class="score">{{seller.score}}</h1>
          <div class="title">综合评分</div>
          <div class="rank">高于周边商家{{seller.rankRate}}%</div>
        </div>
        <div class="overview-right">
          <div class="score-wrapper">
            <span class="title">服务态度</span>
            <star :size="36" :score="seller.serviceScore"></star>
            <span class="score">{{seller.serviceScore}}</span>
          </div>
          <div class="score-wrapper">
            <span class="title">商品评分</span>
            <star :size="36" :score="seller.foodScore"></star>
            <span class="score">{{seller.foodScore}}</span>
          </div>
          <div class="delivery-wrapper">
            <span class="title">送达时间</span>
            <span class="delivery">{{seller.deliveryTime}}分钟</span>
          </div>
        </div>
      </div>
      <split/>
      <rating-select v-on:rating-type-select="ratingTypeSelect" :ratings="ratings"
                     v-on:rating-content-toggle="ratingContentToggle" :desc="desc"
      />
      <div class="rating-wrapper" >
        <ul>
          <li v-for="rating in ratings" class="rating-item" v-show="needShow(rating.rateType,rating.text)">
            <div class="avatar">
              <img :src="rating.avatar">
            </div>
            <div class="content">
              <h1 class="name">{{rating.username}}</h1>
              <div class="star-wrapper">
                <star class="star" :size="24" :score="rating.score"></star>
                <span class="delivery" v-show="rating.deliveryTime">{{rating.deliveryTime}}分钟送达</span>
              </div>
              <p class="text">{{rating.text}}</p>
              <div class="recommend">
                <span class="icon" :class="iconBadge(rating.score)"></span>
                <span class="item">{{rating.orderMenu}}</span>
              </div>
              <div class="time">
                {{_formatTime(rating.rateTime) }}
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import star from '../star/star.vue';
  import split from '../split/split.vue';
  import BScroll from 'better-scroll';
  import ratingSelect from '../ratingSelect/ratingSelect.vue';

  const POSITIVE = 0;
  const NEGATIVE = 1;
  const ALL = 2;

  export default {
    name: "ratings",
    data(){
      return{
        ratings:[],
        selectType:ALL,
        onlyContent:true,
        desc:{
          all:'全部',
          positive:'满意',
          negative:'不满意'
        }
      }
    },
    props:{
      seller:{
        type:Object
      }
    },
    created(){
      this.receiveRatingsData();
    },
    computed:{

    },
    methods:{
      receiveRatingsData(){
        let _this = this;
        this.$axios.get('/api/GET/ratings')
          .then( response => {
            _this.ratings = response.data
            console.log(this.ratings)
            response = null;
            this.$nextTick(()=>{
              this.ratingScroll = new BScroll(this.$refs.dom,{
                click:true
              });
            });
          });
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
          this.ratingScroll.refresh();
        })
      },
      ratingContentToggle(judgeOnlyContent){
        this.onlyContent = judgeOnlyContent;
        this.$nextTick(()=>{
          this.ratingScroll.refresh();
        })
      },
      splitString(recommend){
        return recommend.split(',');
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
        if(minute.toString().length<2){
          minute = '0'+minute;
        }
        let time = hour.toString()+":"+minute.toString();
        let total = str+" "+time;
        return total;
      },
      iconBadge(score){
        if(score>3){
          return 'icon-thumb_up'
        }else{
          return 'icon-thumb_down'
        }
      }
    },
    components:{
      star,
      split,
      ratingSelect,
    }
  }
</script>

<style lang="stylus" scoped>
  #ratings-container
    position: absolute
    top: px-to-rem(174)
    bottom: 0
    left: 0
    width: 100%
    overflow: hidden
    text-align left
    .overview
      display: flex
      padding: px-to-rem(18) 0
      .overview-left
        flex: 0 0 px-to-rem(137)
        padding: px-to-rem(6) 0
        width: px-to-rem(137)
        border-right: px-to-rem(1) solid rgba(7, 17, 27, 0.1)
        text-align: center
        .score
          margin-bottom: px-to-rem(6)
          line-height: px-to-rem(28)
          font-size: px-to-rem(24)
          color: rgb(255, 153, 0)
        .title
          margin-bottom: px-to-rem(8)
          line-height: px-to-rem(12)
          font-size: px-to-rem(12)
          color: rgb(7, 17, 27)
        .rank
          line-height: px-to-rem(10)
          font-size: px-to-rem(10)
          color: rgb(147, 153, 159)
      .overview-right
        flex: 1
        padding: px-to-rem(6) 0 px-to-rem(6) px-to-rem(24)
        .score-wrapper
          margin-bottom: px-to-rem(8)
          font-size: 0
          .title
            display: inline-block
            line-height: px-to-rem(18)
            vertical-align: top
            font-size: px-to-rem(12)
            color: rgb(7, 17, 27)
          .star
            display: inline-block
            margin: 0 px-to-rem(12)
            vertical-align: top
          .score
            display: inline-block
            line-height: px-to-rem(18)
            vertical-align: top
            font-size: px-to-rem(12)
            color: rgb(255, 153, 0)
        .delivery-wrapper
          font-size: 0
          .title
            line-height: px-to-rem(18)
            font-size: px-to-rem(12)
            color: rgb(7, 17, 27)
          .delivery
            margin-left: px-to-rem(12)
            font-size: px-to-rem(12)
            color: rgb(147, 153, 159)
    .rating-wrapper
      padding: 0 px-to-rem(18)
      .rating-item
        display: flex
        padding: px-to-rem(18) 0
        border-1px(rgba(7, 17, 27, 0.1))
        .avatar
          flex: 0 0 px-to-rem(28)
          width: px-to-rem(28)
          margin-right: px-to-rem(12)
          img
            border-radius: 50%
            width:px-to-rem(28)
            height:px-to-rem(28)
        .content
          position: relative
          flex: 1
          .name
            margin-bottom: px-to-rem(4)
            line-height: px-to-rem(12)
            font-size: px-to-rem(10)
            color: rgb(7, 17, 27)
          .star-wrapper
            margin-bottom: px-to-rem(6)
            font-size: 0
            .star
              display: inline-block
              margin-right: px-to-rem(6)
              vertical-align: top
            .delivery
              display: inline-block
              vertical-align: top
              line-height: px-to-rem(12)
              font-size: px-to-rem(10)
              color: rgb(147, 153, 159)
          .text
            margin-bottom: px-to-rem(8)
            line-height: px-to-rem(18)
            color: rgb(7, 17, 27)
            font-size: px-to-rem(12)
          .recommend
            display: flex
            align-items: center
            line-height: px-to-rem(16)
            height:px-to-rem(16)
            font-size: 0
            .icon, .item
              margin: 0 px-to-rem(8) 0 0
              font-size: px-to-rem(9)
            .icon-thumb_up
              color: rgb(0, 160, 220)
            .icon-thumb_down
              color:#A8A8A8
            .item
              padding: 0 px-to-rem(6)
              border: 1px solid rgba(7, 17, 27, 0.1)
              border-radius: 1px
              color: rgb(147, 153, 159)
              background: #fff
          .time
            position: absolute
            top: 0
            right: 0
            line-height: px-to-rem(12)
            font-size: px-to-rem(10)
            color: rgb(147, 153, 159)
</style>
