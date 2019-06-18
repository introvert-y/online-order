<template>
    <div id="time-container">
      <div id="timer"></div>
    </div>
</template>

<script>
    export default {
      name: "wait-for-time",
      data(){
        return {
          timer:{},
          anotherTime:{}
        }
      },
      created(){
        let maxtime = 2*30
        let that = this;
        this.timer = setInterval(function () {
          if (maxtime >= 0) {
            let minutes = Math.floor(maxtime / 60);
            let seconds = Math.floor(maxtime % 60);
            let msg = "等待商家接单" + minutes + "分" + seconds + "秒";
            document.getElementById('timer').innerHTML = msg;
            --maxtime;
          } else{
            clearInterval(that.timer);
            that.cancelOrder();
            alert("商家未接单，已退款!");
            that.$router.push({path:'/goods'})
          }
        }, 1000);
        this.anotherTime = setInterval(this.inquireOrderTrans,10000)
      },
      methods:{
        cancelOrder(){
          this.$axios.delete('/api/DELETE/cancelTheOrder',{
            params:{
              creatTime:JSON.parse(sessionStorage.getItem('createTime')),
            }
          })
        },
        inquireOrderTrans(){
          console.log('hahaha')
          this.$axios.get('/api/GET/theOrderStatus',{
            params:{
              createTime:JSON.parse(sessionStorage.getItem('createTime')),
              mode:'2'
            }
          })
          .then(response =>{
            if(response.data.length>0){
              clearInterval(this.timer);
              clearInterval(this.anotherTime);
              this.$router.push({path:"/myOrder"})
            }
          })
        }
      }
    }
</script>

<style lang="stylus" scoped>
  #time-container
    position: fixed;
    z-index: 100;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    backdrop-filter: blur(10px);
    background: rgba(7,17,27,0.8);
    #timer
      position: absolute
      top:50%;
      transform :translateY(-50%)
      color: #fff
      margin:0 auto;
      width:100%;


</style>
