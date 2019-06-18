<template>
    <div id="ratingFoodPage-container" ref="ratingFoodPage">
      <div id="ratings">
        <h1 class="title">评价页面</h1>
        <ul>
          <li v-for="item in foodArr" class="item">
            <h1 class="title">{{item.name}}</h1>
            <el-rate v-model="item.score" class="starSky"
                     :colors="['#99A9BF', '#F7BA2A', '#FF9900']">
            </el-rate>
            <el-input
              type="textarea"
              autosize
              placeholder="请输入内容"
              v-model="item.text">
            </el-input>
          </li>
          <li class="item">
            <h1 class="title">送达时间</h1>
            <el-select v-model="time" placeholder="请选择">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </li>
        </ul>
        <div class="last">
          <span class="submitButton" @click="printData">提交评价</span>
        </div>
      </div>
    </div>
</template>

<script>
  import BScroll from 'better-scroll';
    export default {
      name: "rating-food-page",
      data(){
        return {
          foodArr:[],
          time:'',
          options: [
            {label: '30分钟内',value:'30'},
            {label: '45分钟内',value:'45'},
            {label: '一个小时内',value:'60'},
          ],
          value: ''
        }
      },
      created(){
        this.$nextTick(() =>{
          this._initScroll();
        })
      },
      mounted(){
        this.foodArr = JSON.parse(sessionStorage.getItem('foodArr'))
      },
      methods:{
        printData(){
          let name = JSON.parse(sessionStorage.getItem('identity')).name;
          console.log('全部评价',this.foodArr)
          this.$axios.post('/api/POST/submitRatings',{
              name : name,
              arr : this.foodArr,
              creatTime:Date.parse(new Date()),
              deliveryTime:this.time,
          })
            .then( response => {
              if(response.status =='200'){
                this.$router.push({path:'/ratings'})
              }

            });
        },
        _initScroll() {
          if(!this.ratingFoodPage){
            this.ratingFoodPage = new BScroll(this.$refs.ratingFoodPage,{
              click:true
            })
          }else{
            this.ratingFoodPage.refresh();
          }
        },
      }
    }
</script>

<style lang="stylus" scoped>
  #ratingFoodPage-container
    position: fixed;
    left:0;
    top:0;
    bottom: 0;
    z-index:100;
    width:100%;
    background:#fff;
    overflow: hidden;
    text-align left
    #ratings
      padding-bottom 50px
      .title
        height:60px;
        line-height:60px;
        text-align center
      .item
        padding:18px;
        .title
          text-align left
          height:30px;
          line-height:30px;
          font-size 16px
        .el-rate
          height:35px

      .last
        padding:18px
        text-align: right
        .submitButton
          font-size 14px
          padding:10px 30px;
          background-color #f01414
          color: #fff
</style>
