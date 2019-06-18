// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import axios from 'axios'
import '../static/amfe-flexible.js'
import '../static/reset.css'
import '../static/icon.css'
import VueLazyload from 'vue-lazyload'
import store from './store/index.js'
import bus from './assets/bus.js'
// import echarts from 'echarts'
import ElementUI  from 'element-ui'
// import {Input,Select,Option,Rate} from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
// import  FastClick  from  'fastclick'
//
// FastClick.attach(document.body);
// Vue.use(Input);
// Vue.use(Select);
// Vue.use(Option);
// Vue.use(Rate);
Vue.use(ElementUI);

Vue.use(VueLazyload,{
  loading:require('../static/loading.gif')
})

Vue.config.productionTip = false
Vue.prototype.$axios = axios;
Vue.prototype.$Bus = bus;
Vue.prototype.$echarts = echarts;

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
