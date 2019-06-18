<template>
  <div id="myOrder">
    <div id="myOrder-container">
      <div class="box" v-for="(item,index) in orderArr" @click="toDetails(item)">
        <div class="header">
          <i class="iconfont icon iconwaimai"></i>
          <span class="text">{{item.createTime}}</span>
          <span class="status">{{_statusBadge(item.orderStatus)}}</span>
        </div>
        <div class="content">
          <div class="image">
            <img :src="seller.avatar">
          </div>
          <div class="text">
            <div class="orderTime">下单时间：{{_formatTime(item.createTime)}}</div>
            <div class="price">总价：￥{{item.totalPrice}}</div>
            <div class="address">配送地址 ：{{item.address}}</div>
          </div>
        </div>
        <div class="bottomButton" v-show="isIdentity&&(item.orderStatus=='0'||item.orderStatus=='1')" @click.stop.prevent="changeOrderStatus(item)">{{buttonText(item)}}</div>
        <div class="details" ref="details">{{deliveryInfo(item,index)}}</div>
      </div>
    </div>
    <order-details ref="orderDetails" v-on:add-finish="donePay"/>
  </div>
</template>

<script>
    import OrderDetails from "../orderDetails/orderDetails";
    export default {
      name: "myOrder",
      components: {OrderDetails},
      created(){
        let obj = sessionStorage.getItem('identity');
        if(obj==null||obj=='undefined'){
          alert('还没登录，请先登录')
          this.$router.push({path:"/login"})
        }else {
          let transObj = JSON.parse(obj)
          if(transObj.identity =='商家'){
            this.isIdentity = true;
            this.totalOrder()
            this.timer = setInterval(this.totalOrder,10000)
          }else if(transObj.identity =='顾客'){
            this.theOrder()
            this.timer = setInterval(this.theOrder,10000)
          }
        }

      },
      mounted(){
        // this.timer = setInterval(function () {
        //   location.reload()
        // },10000)
      },
      data(){
        return{
          orderArr:[],
          isIdentity:false,
          text:'',
          timer:{},
        }
      },
      props:{
        seller:{
          type:Object
        }
      },
      methods:{
        totalOrder(){
          this.$axios.get('/api/GET/totalOrder').then(response =>{
            this.orderArr = response.data;
            console.log(this.orderArr)
          })
        },
        theOrder(){
          let obj = JSON.parse(sessionStorage.getItem('identity'));
          this.$axios.get('/api/GET/theUserOrder',{
            params:{
              userName:obj.name
            }
          }).then(response =>{
            this.orderArr = response.data;
            console.log(this.orderArr)
          })
        },
        buttonText(item){
          if(item.orderStatus=='0'&&this.isIdentity){
            return '接单'
          }else if(item.orderStatus=='1'&&this.isIdentity){
            return '配送'
          }
        },
        deliveryInfo(item,index){
          if(this.isIdentity){
            return
          }else{
            if(item.orderStatus=='1'){
              return `商家正在备餐`;
            }else if(item.orderStatus=='2'){
              //查询配送员数据库再选出type=’0‘的人；
              this.$axios.get('/api/GET/changeDeliveryType').then(response =>{
                console.log(this.$refs.details)
                if(response.data == '500'){
                  this.$refs.details[index].innerHTML = '商家已备好餐,等待配送员配送'
                }else{
                  let obj = response.data
                  sessionStorage.setItem('delivery',JSON.stringify(obj))
                  this.$refs.details[index].innerHTML = `配送员 ${obj.name} ${obj.phone} 正在配送....`
                }
              })

            }
          }

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
        _statusBadge(string){
          let text = '';
          switch (string) {
            case '0':
              text = '已支付'
              break
            case '1':
              text = '已接单,在备餐'
              break
            case '2':
              text = '正在派送'
              break
            case '3':
              text = '已送达'
              break
            case '4':
              text = '已退款'
              break
          }
          return text;
        },
        changeOrderStatus(item){
          //'0'已支付，'1'已接单,在备餐,'2'正在配送，’3‘已送达’‘4’已退款
          if(item.orderStatus=='0'){
            this.$axios.put('/api/PUT/changeOrderStatus',{
              data:{
                createTime:item.createTime,
                type:'1',
                mode:'1',
              }
            }).then(response =>{
              location.reload()
            })
          }else if(item.orderStatus=='1') {
            this.$axios.put('/api/PUT/changeOrderStatus', {
              data: {
                createTime: item.createTime,
                type: '2',
                mode:'1',
              }
            }).then(response => {
              location.reload()
            })
          }

        },
        toDetails(item){
          this.$refs.orderDetails._initSelectFood(item);
          this.$refs.orderDetails.show(item);
        },
        donePay(){
          this.timer = clearInterval(this.timer);;
        }
      }
    }
</script>

<style lang="stylus" scoped>
#myOrder-container
  position: absolute;
  top:px-to-rem(174)
  width:100%;
  min-height: 100%;
  background-color #F0F0F0
  overflow: hidden;
  .box
    position: relative
    margin:px-to-rem(10)
    background-color #fff
    text-align left
    border-radius 10px
    .header
      position: relative
      padding: px-to-rem(10) 0 px-to-rem(10) px-to-rem(15)
      border-1px(#FFA07A)
      .icon
        display: inline-block
        vertical-align: middle
        font-size px-to-rem(20)
      .text
        display: inline-block
        vertical-align: middle
        font-size px-to-rem(16)
        padding-left px-to-rem(10)
      .status
          position: absolute
          right:px-to-rem(5)
        font-size px-to-rem(16)
    .content
      display: flex

      padding:px-to-rem(15)
      .image
        &>img
          height:px-to-rem(60)
          width:px-to-rem(60)
      .text
        width:calc(100% - 20px - 15px - 60px - 30px)
        padding-left px-to-rem(15)
        font-size px-to-rem(14)
        .price
          margin-top :px-to-rem(10)

      .address
        margin-top px-to-rem(10)
        font-size px-to-rem(14)
        overflow: hidden;/*超出部分隐藏*/
        white-space: nowrap;/*不换行*/
        text-overflow:ellipsis;/*超出部分文字以...显示*/
    .bottomButton
      position: absolute
      right: px-to-rem(5);
      bottom:  px-to-rem(5);
      font-size px-to-rem(14)
      padding:px-to-rem(5) px-to-rem(10)
      background-color #FF8040
      color: #fff
      border-radius 5px;
    .details
      position: absolute
      right: px-to-rem(15);
      bottom:  0;
      font-size px-to-rem(14)
      color: red
</style>
