<template>
    <div id="cartControl-container">
      <transition name="fadeAndRotate">
        <div class="cart-decrease icon-remove_circle_outline"
             v-show="food.count>0" @click.stop.prevent="decreaseCount">
        </div>
      </transition>
      <transition name="fade">
         <div class="cart-count" v-show="food.count>0">{{food.count}}</div>
      </transition>
      <div class="cart-add icon-add_circle" @click.stop.prevent="addCount"></div>
    </div>
</template>

<script>
    export default {
      name: "cart-control",
      props:{
        food:{
          type:Object
        }
      },
      data(){
        return {

        }
      },
      methods:{
        addCount(){
           if(!this.food.count){
             this.$set(this.food,'count', 1)
           }else{
             this.food.count = this.food.count+1;
           }
           this.$emit('get-dom',event.target);
        },
        decreaseCount(){
          if(this.food.count>0){
            this.food.count--;
          }
        }
      },
    }
</script>

<style lang="stylus" scoped>
  #cartControl-container
    font-size: 0px;
    .fade-leave-active,.fade-enter-active
      transition: all 0.8s ease;
    .fade-leave-to,.fade-enter
      transform: translateX(100%)
      opacity: 0;
    .fadeAndRotate-leave-active,.fadeAndRotate-enter-active
      transition: all 0.8s ease;
    .fadeAndRotate-leave-to,.fadeAndRotate-enter
      transform: translateX(100%) rotate(180deg);
      opacity: 0;

    .cart-decrease
      display: inline-block;
      padding:px-to-rem(6);
      line-height: px-to-rem(24);
      font-size: px-to-rem(24);
      color:rgb(0,160,220);
    .cart-count
      display: inline-block;
      vertical-align: top;
      width:px-to-rem(12);
      padding-top: px-to-rem(6);
      line-height: px-to-rem(24);
      text-align: center;
      font-size: px-to-rem(10);
      color:rgb(147,153,159);

    .cart-add
      display: inline-block;
      padding:px-to-rem(6);
      line-height: px-to-rem(24);
      font-size: px-to-rem(24);
      color:rgb(0,160,220);

</style>
