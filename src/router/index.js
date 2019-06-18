  import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

let router = new Router({
  mode:'history',
  routes: [
    {
      path: '/',
      redirect:'/goods'
    },
    {
      path:'/login',
      component:resolve => require(['../components/login/login.vue'],resolve)
    },
    {
      path:'/goods',
      component:resolve => require(['../components/goods/goods.vue'],resolve)
    },
    {
      path:'/ratings',
      component:resolve => require(['../components/ratings/ratings.vue'],resolve)
    },
    {
      path:'/myOrder',
      component:resolve => require(['../components/myOrder/myOrder.vue'],resolve)
    },
    {
      path:'/sellerInfo',
      component:resolve => require(['../components/sellerInfo/sellerInfo.vue'],resolve)
    }

  ]
})

router.beforeEach((to,from,next) =>{
  console.log('切换路由',to,from)
  if(to.fullPath=="/login"&&from.fullPath=='/goods'){
    to.params.type = '1'
  }else if(to.fullPath=="/login"&&from.fullPath=='/myOrder'){
    to.params.type = '2'
  }
  next();
})


export default router;
