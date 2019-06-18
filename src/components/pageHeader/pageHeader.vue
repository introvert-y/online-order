<template>
    <div id="page-header-container" v-show="seller">
      <div class="content-wrapper">
        <div class="avatar">
          <img :src='seller.avatar'>
        </div>
        <div class="content">
          <div class="title">
            <span class="brand"></span>
            <span class="name">{{seller.name}}</span>
          </div>
          <div class="description">
            {{seller.description}}/{{seller.deliveryTime}}分钟送达
          </div>
          <div v-if="seller.activity" class="support">
            <span class="icon" :class='classMap[seller.activity[0].type]'></span>
            <span class="text">{{seller.activity[0].description}}</span>
          </div>
        </div>
        <div v-if="seller.activity" class="support-count" @click="showDetail()">
          <span class="count">{{seller.activity.length}}个</span>
          <i class="icon-keyboard_arrow_right"></i>
        </div>
      </div>
      <div class="bulletin-wrapper" @click="showDetail()">
        <span class="bulletin-title"></span><span class="bulletin-text">{{seller.bulletin}}</span>
        <i class="icon-keyboard_arrow_right"></i>
      </div>
      <div class="background">
        <img :src="seller.avatar" width="100%" height="100%">
      </div>
      <transition name="fade">
        <div v-show="detailShow" class="detail">
          <div class="detail-wrapper clearfix">
            <div class="detail-main">
              <h1 class="name">{{seller.name}}</h1>
              <div class="star-wrapper">
                <star :size="48" :score='seller.score'></star>
              </div>
              <div class="title">
                <div class="line"></div>
                <div class="text">优惠信息</div>
                <div class="line"></div>
              </div>
              <ul v-if="seller.activity" class="supports">
                <li class="support-item" v-for="(item,index) in seller.activity">
                  <span class="icon" :class="classMap[seller.activity[index].type]"></span>
                  <span class="text">{{seller.activity[index].description}}</span>
                </li>
              </ul>
              <div class="title">
                <div class="line"></div>
                <div class="text">商家公告</div>
                <div class="line"></div>
              </div>
              <div class="bulletin">
                <p class="content">{{seller.bulletin}}</p>
              </div>
            </div>
          </div>
          <div class="detail-close" @click="hideDetail">
            <i class="icon-close"></i>
          </div>
        </div>
      </transition>
    </div>
</template>

<script>
  import star from '../star/star.vue';
  export default {
      name: "page-header",
      data(){
        return{
          detailShow:false
        }
      },
      props:{
        seller:{
          type:Object
        }
      },
      created(){
        this.classMap = ['decrease','discount','special','invoice','guarantee']
      },
      methods:{
        showDetail(){
          this.detailShow = true;
        },
        hideDetail(){
          this.detailShow = false;
        }
      },
      components:{
        star,
      }
    }
</script>

<style lang="stylus" scoped>
  #page-header-container
    position: relative
    overflow: hidden
    text-align :left
    color: #fff
    background: rgba(7, 17, 27, 0.5)
    .content-wrapper
      position: relative
      padding: px-to-rem(24) px-to-rem(12) px-to-rem(18) px-to-rem(24)
      font-size: 0
      .avatar
        display: inline-block
        vertical-align: top
        img
          width:px-to-rem(64)
          height: px-to-rem(64)
          border-radius: 2px
      .content
        display: inline-block
        margin-left: px-to-rem(16)
        .title
          display: flex
          align-items center
          margin: px-to-rem(2) 0 px-to-rem(8) 0
          .brand
            display: inline-block
            width: px-to-rem(30)
            height: px-to-rem(18)
            background: url("brand@2x.png");
            background-size: px-to-rem(30) px-to-rem(18)
            background-repeat: no-repeat
          .name
            margin-left: px-to-rem(6)
            font-size: px-to-rem(16)
            line-height: px-to-rem(18)
            font-weight: bold

        .description
          margin-bottom: px-to-rem(10)
          line-height: px-to-rem(12)
          font-size: px-to-rem(12)
        .support
          display: flex;
          align-items center
          .icon
            display: inline-block
            vertical-align: top
            width: px-to-rem(12)
            height: px-to-rem(12)
            margin-right: px-to-rem(4)
            background-size: px-to-rem(12) px-to-rem(12)
            background-repeat: no-repeat
            &.decrease
              bg-image('decrease_1')
            &.discount
              bg-image('discount_1')
            &.guarantee
              bg-image('guarantee_1')
            &.invoice
              bg-image('invoice_1')
            &.special
              bg-image('special_1')
          .text
            line-height: px-to-rem(12)
            font-size: px-to-rem(12)

      .support-count
        position: absolute
        right: px-to-rem(12)
        bottom: px-to-rem(14)
        padding: 0 px-to-rem(8)
        height: px-to-rem(24)
        line-height: px-to-rem(24)
        border-radius: px-to-rem(14)
        background: rgba(0, 0, 0, 0.2)
        text-align: center
        .count
          vertical-align: top
          font-size: px-to-rem(10)
        .icon-keyboard_arrow_right
          margin-left: px-to-rem(2)
          line-height: px-to-rem(24)
          font-size: px-to-rem(10)


    .bulletin-wrapper
      display: flex
      align-items center
      position: relative;
      height:px-to-rem(28);
      line-height: px-to-rem(28);
      padding:0 px-to-rem(22) 0 px-to-rem(12);
      background: rgba(7,17,27,0.2);
      .bulletin-title
        display: inline-block;
        flex:0 0 px-to-rem(22)
        width:px-to-rem(22)
        height: px-to-rem(12);
        bg-image('bulletin')
        background-size: px-to-rem(22) px-to-rem(12);
        background-repeat: no-repeat
      .bulletin-text
        flex:0 0 calc(100% - 22px - 4px)
        width:calc(100% - 22px - 12px)
        padding-left px-to-rem(4)
        font-size: px-to-rem(11)
        font-weight: 200;
        /*不换行*/
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        color:rgb(255,255,255);
      .icon-keyboard_arrow_right
        flex:0 0 px-to-rem(10)
        width:px-to-rem(10)
        font-size: px-to-rem(14)
        right: px-to-rem(10)
        top: px-to-rem(8)

    .background
      position: absolute
      top: 0
      left: 0
      width: 100%
      height: 100%
      z-index: -1
      filter: blur(10px)
    .detail
      position: fixed
      z-index: 100
      top: 0
      left: 0
      width: 100%
      height: 100%
      overflow: auto
      backdrop-filter: blur(10px)
      background: rgba(7,17,27,0.8);
      &.fade-leave-active
        transition: all 0.8s ease;
      &.fade-enter-active
        transition: all 1s ease;
      &.fade-leave-to
        transform: translateY(-100%);
        opacity: 0;
      &.fade-enter
        opacity: 0;
      .detail-wrapper
        width: 100%
        min-height: 100%
      .clearfix
         display: inline-block
         &:after
           display: block
           content: "."
           height: 0
           line-height: 0
           clear: both
           visibility: hidden
        .detail-main
          margin-top: px-to-rem(64)
          padding-bottom: px-to-rem(64)
          .name
            line-height: px-to-rem(16)
            text-align: center
            font-size: px-to-rem(16)
            font-weight: 700
          .star-wrapper
            margin-top: px-to-rem(18)
            padding: px-to-rem(2) 0
            text-align: center
          .title
            display: flex
            width: 80%
            margin: px-to-rem(28) auto px-to-rem(24) auto
            .line
              flex: 1
              position: relative
              top: px-to-rem(-6)
              border-bottom: px-to-rem(1) solid rgba(255, 255, 255, 0.2)
            .text
              padding: 0 px-to-rem(12)
              font-weight: 700
              font-size: px-to-rem(14)

          .supports
            width: 80%
            margin: 0 auto
            .support-item
              padding: 0 px-to-rem(12)
              margin-bottom: px-to-rem(12)
              font-size: 0
              &:last-child
                margin-bottom: 0
              .icon
                display: inline-block
                width: px-to-rem(16)
                height: px-to-rem(16)
                vertical-align: top
                margin-right: px-to-rem(6)
                background-size: px-to-rem(16) px-to-rem(16)
                background-repeat: no-repeat
                &.decrease
                  bg-image('decrease_2')
                &.discount
                  bg-image('discount_2')
                &.guarantee
                  bg-image('guarantee_2')
                &.invoice
                  bg-image('invoice_2')
                &.special
                  bg-image('special_2')
              .text
                line-height: px-to-rem(16)
                font-size: px-to-rem(12)
          .bulletin
            width: 80%
            margin: 0 auto
            .content
              padding: 0 px-to-rem(12)
              line-height: px-to-rem(24)
              font-size: px-to-rem(12)
      .detail-close
        position: relative
        width: px-to-rem(32)
        height: px-to-rem(32)
        margin: px-to-rem(-64) auto 0 auto
        clear: both
        font-size: px-to-rem(32)
</style>
