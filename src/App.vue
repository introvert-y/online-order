<template>
  <div id="app">
    <page-header :seller="seller"/>
    <pageNav/>
    <router-view :seller="seller"></router-view>
  </div>
</template>

<script>
import pageHeader from './components/pageHeader/pageHeader.vue'
import pageNav from './components/pageNav/pageNav.vue'
export default {
  name: 'App',
  data(){
    return{
      receiveObj:{},
      seller:{},
    }
  },
  created(){
    this.addRouters()
  },
  mounted(){
    this.receiveSellerData()
    this.receiveSellerActivityData()

  },

  methods:{
    receiveSellerData(){
      let _this = this;
      this.$axios.get(`/api/GET/sellerInfo`)
        .then( response => {
          _this.receiveObj = Object.assign(response.data[0]);
          response = null;
        });
    },
    receiveSellerActivityData(){
      let _this = this;
      this.$axios.get(`/api/GET/activityInfo`)
        .then( response => {
          _this.receiveObj['activity'] = Object.assign(response.data)
          _this.seller = Object.assign(_this.receiveObj);//因为两者的数据不同步，所以需要多一个变量
          console.log('商家数据',_this.seller)
          response = null;
        });
    },
    addRouters(){
      if(sessionStorage.getItem("identity") != null){
        let obj = JSON.parse(sessionStorage.getItem('identity'))
        if(obj.identity == '顾客'){
          this.$router.addRoutes([
            {
              path:'/confirmOrder',
              component:resolve => require(['./components/confirmOrder/confirmOrder.vue'],resolve)
            },
            {
              path:'/waitForTime',
              component:resolve => require(['./components/waitForTime/waitForTime.vue'],resolve)
            },
            {
              path:'/ratingFoodPage',
              component:resolve => require(['./components/ratingFoodPage/ratingFoodPage.vue'],resolve)
            }
          ]);//调用addRoutes添加路由
        }else if(obj.identity == '商家'){
          this.$router.addRoutes([
            {
              path:'/addFoodPage',
              component:resolve => require(['./components/addFoodPage/addFoodPage.vue'],resolve)
            },
            {
              path:'/sales',
              component:resolve => require(['./components/sales/sales.vue'],resolve)
            }
          ]);
        }
      }
    }
  },
  components: {
     pageHeader,
     pageNav,
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
