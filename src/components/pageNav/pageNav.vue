<template>
  <div id="nav-container">
    <div class="nav-item" v-for="(item,index) in navList" :key="index" @click="toPage(item)">
      <span :class="{'item-active':item.address === currentIndex}" >{{item.name}} </span>
      <span class="number" v-show="badgeCondition(item)" >{{msgNumber}}</span>
    </div>
  </div>
</template>

<script>
  import {mapGetters} from 'vuex'
    export default {
      name: "page-nav",
      data(){
        return{
          currentIndex:'',
          navList:[],
          msgNumber:0,
        }
      },
      created(){
        let sesstionObj = JSON.parse(sessionStorage.getItem('identity'));
        if(sesstionObj!==null&&sesstionObj.identity=='商家'){
          this.navList.push(
            {
              name:'收益',
              address:'/sales'
            }
          )

        }
        this.navList.push(
            {
              name:'商品',
              address:'/goods'
            },
            {
              name:'评论',
              address:'/ratings'
            },
            {
              name:'订单',
              address:'/myOrder'
            },
            {
              name:'商家',
              address:'/sellerInfo'
            }
        )
        setInterval(this.receiveMsgNumber,10000)

      },
      watch:{
        $route(to, from) {
          console.log('nav',this.$route.path);
          this.currentIndex = this.$route.path
        },
        obj(newData){
           if(newData.identity=='商家'){
             this.navList.unshift(
               {
                 name:'收益',
                 address:'/sales'
               }
             )
           }
        }
      },
      methods: {
        toPage(item) {
          this.$router.push({path: item.address})
        },
        badgeCondition(item){
          let sesstionObj = JSON.parse(sessionStorage.getItem('identity'));
          if(item.name=='订单'&&sesstionObj!==null&&sesstionObj.identity=='商家'&&this.msgNumber>0){
            return true
          }
          return false;
        },
        receiveMsgNumber(){
          this.$axios.get('/api/GET/theOrderStatus',{
            params:{
              type:'0',
              mode:'1'
            }
          })
            .then( response => {
              this.msgNumber = response.data.length
              response = null;
            });
        },

      },
      computed:{
        ...mapGetters([
          'obj'
        ])
      },
    }
</script>

<style lang="stylus" scoped>
  #nav-container
    position: relative;
    display: flex;
    width: 100%;
    height: px-to-rem(40)
    line-height: px-to-rem(40)
    &:after
      display: block;
      position: absolute;
      width: 100%;
      left: 0px;
      bottom: 0px;
      border-top: px-to-rem(1) solid rgba(7, 17, 27, 0.1);
      content: '';
    .nav-item
      position: relative
      flex: 1;
      text-align: center;
      font-size: px-to-rem(14)
      .item-active
        color:rgb(240, 20, 20);
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

</style>
