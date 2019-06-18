<template>
    <div id="deleteConfirmBox-container" v-show="deleteConfiremBoxFlag">
      <div class="tip">
        <div class="title">确认删除商品：{{name}}</div>
        <div>
          <span class="buttonLeft" @click.stop.prevent="deleteFood()">确认</span>
          <span  class="buttonLeft"  @click.stop.prevent="hidePage()">取消</span>
        </div>
      </div>
    </div>
</template>

<script>
    export default {
      name: "delete-confirm-box",
      data(){
        return {
          name:'',
          deleteConfiremBoxFlag:false,
        }
      },
      methods:{
        deleteFood() {
          this.$axios.delete(`/api/DELETE/theFood?name=${this.name}`)
            .then(response => {
              console.log(response)
              alert('删除成功')
              this.$emit('add-finish')
              this.deleteConfiremBoxFlag = false;

            });
        },
        _initData(name){
          this.name = name;
          this.deleteConfiremBoxFlag = true;
        },
        hidePage(){
          this.deleteConfiremBoxFlag = false;
        }
      }
    }
</script>

<style lang="stylus" scoped>
#deleteConfirmBox-container
  position: fixed;
  z-index: 100;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  backdrop-filter: blur(10px);
  background: rgba(7,17,27,0.8);
  .tip
    position: flex
    margin:30% auto 0 auto;
    align-items: center;
    color: #fff
    font-size px-to-rem(15)
    .title
      height:100px;
      line-height:100px;
      width:100%

    .buttonLeft
      padding:px-to-rem(8) px-to-rem(20)
      background-color #fff
      color: black
      margin-right px-to-rem(20)
      &:last-child
        margin-right 0;
</style>
