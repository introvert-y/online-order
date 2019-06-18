<template>
  <div id="sellerInfo-container" ref="sellerInfoContainer">
    <div class="seller-content">
      <div class="overview">
        <h1 class="title">{{seller.name}}</h1>
        <div class="desc">
          <star class="star" :size="36" :score="seller.score"></star>
          <span class="text">月售{{seller.sellCount}}单</span>
        </div>
        <ul class="remark">
          <li class="block">
            <h2>起送价</h2>
            <div class="content">
              <span class="stress">{{seller.minPrice}}</span>元
            </div>
          </li>
          <li class="block">
            <h2>商家配送</h2>
            <div class="content">
              <span class="stress">{{seller.deliveryPrice}}</span>元
            </div>
          </li>
          <li class="block">
            <h2>平均配送时间</h2>
            <div class="content">
              <span class="stress">{{seller.deliveryTime}}</span>分钟
            </div>
          </li>
        </ul>
      </div>
      <split></split>
      <div class="bulletin">
        <h1 class="title">公告与活动</h1>
        <div class="content-wrapper">
          <p class="content">{{seller.bulletin}}</p>
        </div>
        <ul v-if="seller.activity" class="supports">
          <li class="support-item" v-for="(item,index) in seller.activity">
            <span class="icon" :class="classMap[seller.activity[index].type]"></span>
            <span class="text">{{seller.activity[index].description}}</span>
          </li>
        </ul>
      </div>
      <split></split>
      <div class="pics">
        <h1 class="title">商家实景</h1>
        <div class="pic-wrapper" ref="picWrapper">
          <ul class="pic-list" ref="picList">
            <li class="pic-item" v-for="pic in splitStringPic">
              <a :href="pic" target="_blank"><img :src="pic"></a>
            </li>
          </ul>
        </div>
      </div>
      <div class="info">
        <h1 class="title">商家信息</h1>
        <ul>
          <li class="info-item" v-for="info in splitString">{{info}}</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import star from '../star/star.vue';
  import split from '../split/split.vue';
  import BScroll from "better-scroll";
  export default {
    name: "seller-info",
    props:{
      seller:{
        type:Object
      }
    },
    data(){
      return{
        picArr:[]
      }
    },
    created(){
      this.classMap = ['decrease','discount','special','invoice','guarantee'];
    },
    mounted(){
      this._initBscroll();
      this._initPics()
    },
    watch:{
      //检测是否获取到seller对象的值
      //逻辑关系是先建立横向滚动条，再通过watch观察到seller对象的更新，
      //再动态的改变content的宽度。
      seller(){
        console.log("我是watch属性");
        this._initPics();
      }
    },
    methods:{
      _initBscroll(){
        this.sellerInfoContainer = new BScroll(this.$refs.sellerInfoContainer,{
          click:true
        });
      },
      _initPics(){
        console.log("初始化_initPics()方法");
        if(this.picArr){
          console.log("获取到值了");
          console.log()
          let picWidth = document.getElementsByClassName('pic-item')[0].clientWidth;
          let marginRight = 6*(picWidth/120);
          //6*(picWidth/120)等于是scale，因为宽度变化了。
          let width = (picWidth+marginRight)*this.picArr.length-marginRight;
          this.$refs.picList.style.width = width+'px';
          if(!this.picScroll){
            this.$nextTick(()=>{
              this.picScroll = new BScroll(this.$refs.picWrapper,{
                scrollX:true,
                eventPassthrough:"vertical"
              });
            });
          }else{
            this.picScroll.refresh();
          }

        }
      },
    },
    computed:{
      splitString(){
        return this.seller.infos.split(',')
      },

      splitStringPic(){
        this.picArr = this.seller.images.split(',');
        return this.picArr;
      }
    },
    components:{
      star,
      split,
    },

  }
</script>

<style lang="stylus" scoped>
  #sellerInfo-container
    position: absolute
    top: px-to-rem(174)
    bottom: 0
    left: 0
    width: 100%
    overflow: hidden
    text-align left
    .overview
      position: relative
      padding: px-to-rem(18)
      text-align center
      .title
        margin-bottom: px-to-rem(8)
        line-height: px-to-rem(14)
        color: rgb(7, 17, 27)
        font-size: px-to-rem(14)
      .desc
        padding-bottom: px-to-rem(18)
        border-1px(rgba(7, 17, 27, 0.1))
        font-size: 0
        .star
          display: inline-block
          margin-right: px-to-rem(8)
          vertical-align: top
        .text
          display: inline-block
          margin-right: px-to-rem(12)
          line-height: px-to-rem(18)
          vertical-align: top
          font-size: px-to-rem(10)
          color: rgb(77, 85, 93)
      .remark
        display: flex
        padding-top: px-to-rem(18)
        .block
          flex: 1
          text-align: center
          border-right: px-to-rem(1) solid rgba(7, 17, 27, 0.1)
          &:last-child
            border: none
          h2
            margin-bottom: px-to-rem(4)
            line-height: px-to-rem(10)
            font-size: px-to-rem(10)
            color: rgb(147, 153, 159)
          .content
            line-height: px-to-rem(24)
            font-size: px-to-rem(10)
            color: rgb(7, 17, 27)
            .stress
              font-size: px-to-rem(24)

    .bulletin
      padding: px-to-rem(18) px-to-rem(18) 0 px-to-rem(18)
      .title
        margin-bottom: px-to-rem(8)
        line-height: px-to-rem(14)
        color: rgb(7, 17, 27)
        font-size: px-to-rem(14)
      .content-wrapper
        padding: 0 px-to-rem(12) px-to-rem(6)px-to-rem(12)
        border-1px(rgba(7, 17, 27, 0.1))
        .content
          line-height: px-to-rem(24)
          font-size: px-to-rem(12)
          color: rgb(240, 20, 20)
      .supports
        .support-item
          padding: px-to-rem(16)px-to-rem(12)
          border-1px(rgba(7, 17, 27, 0.1))
          font-size: 0
          &:last-child
            border-none()
        .icon
          display: inline-block
          width: 16px
          height: 16px
          vertical-align: top
          margin-right: 6px
          background-size: px-to-rem(16)16px
          background-repeat: no-repeat
          &.decrease
            bg-image('decrease_4')
          &.discount
            bg-image('discount_4')
          &.guarantee
            bg-image('guarantee_4')
          &.invoice
            bg-image('invoice_4')
          &.special
            bg-image('special_4')
        .text
          line-height: 16px
          font-size: px-to-rem(12)
          color: rgb(7, 17, 27)
    .pics
      padding: px-to-rem(18)
      .title
        margin-bottom: px-to-rem(12)
        line-height: px-to-rem(14)
        color: rgb(7, 17, 27)
        font-size: px-to-rem(14)
      .pic-wrapper
        width: 100%
        overflow: hidden
        white-space: nowrap
        .pic-list
          font-size: 0
          .pic-item
            display: inline-block
            margin-right: px-to-rem(6)
            width: px-to-rem(120)
            height: px-to-rem(90)
            &>a
              display: inline-block
              width: px-to-rem(120)
              height: px-to-rem(90)
              &>img
                width: px-to-rem(120)
                height: px-to-rem(90)
            &:last-child
              margin: 0
    .info
      padding: px-to-rem(18) px-to-rem(18) 0 px-to-rem(18)
      color: rgb(7, 17, 27)
      .title
        padding-bottom: px-to-rem(12)
        line-height: px-to-rem(14)
        border-1px(rgba(7, 17, 27, 0.1))
        font-size: px-to-rem(14)
      .info-item
        padding: px-to-rem(16) px-to-rem(12)
        line-height: px-to-rem(16)
        border-1px(rgba(7, 17, 27, 0.1))
        font-size: px-to-rem(12)
        &:last-child
          border-none()
</style>
