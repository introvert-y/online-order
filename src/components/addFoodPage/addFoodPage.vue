<template>
  <transition name="slide">
    <div id="addFoodPage-container" ref="addFoodPageContainer">
      <div>
        <div class="box">
          <div class="title" @click.stop.prevent="back">
            <span class="icon"><i class="icon-arrow_lift"></i></span>
              {{title}}
          </div>
          <input type="file" id="changeMore" v-on:change="addImage" ref="file" hidden/>
          <div class="login-item">
            <span class="leftLable">菜名:</span>
            <span><input class="changeStyle" type="text" v-model="form.name" placeholder="请输入内容"></span>
          </div>
          <div class="add" @click="showImage" v-if="hideBox">
            <i class="iconfont iconicontjzp icon"></i>
          </div>
          <div class="add" v-if="!hideBox" @click="selectPic">
            <img :src="avatar"  width="200" hight="200">
          </div>
          <div class="login-item">
            <span class="leftLable">归类:</span>
            <span>
              <el-select v-model="type" placeholder="请选择">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </span>
          </div>
          <div class="login-item">
            <span class="leftLable">价格:</span>
            <span><input class="changeStyle" type="text" v-model="form.price" placeholder="请输入内容"></span>
          </div>
          <div class="login-item">
            <span class="leftLable">类型:</span>
            <span><input class="changeStyle" type="text" v-model="form.description" placeholder="请输入内容"></span>
          </div>
          <div class="login-item">
            <span class="leftLable">菜品介绍:</span>
            <span><input class="changeStyle" type="text" v-model="form.info" placeholder="请输入内容"></span>
          </div>

          <div class="login-item" style="text-align: center" @click.stop.prevent="submitForm">
            <span class="left-button" >{{buttonText}}</span>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
  import BScroll from 'better-scroll';
    export default {
      name: "add-food-page",
      data(){
        return{
          avatar:'',
          hideBox:true,
          title:'',

          form:{
            name:'',
            price:'',
            description:'',
            info:''
          },
          actualName:'',
          type:'',
          options: [
            {label: '单人精彩套餐',value:'1'},
            {label: '冰爽饮品限时特惠',value:'2'},
            {label: '精选热菜',value:'3'},
            {label: '爽口凉菜',value:'4'},
            {label: '精选套餐',value:'5'},
            {label: '果拼果汁',value:'6'},
            {label: '小吃主食',value:'7'},
            {label: '特色粥品',value:'8'},

          ],
        }
      },
      created(){
        this._initScroll();
        if(sessionStorage.getItem("food") != null){
          let sesstionObj = JSON.parse(sessionStorage.getItem('food'));
          this.updateForm(sesstionObj);
        }
        if(sessionStorage.getItem("title") != null){
          this.title = JSON.parse(sessionStorage.getItem('title'));
        }

      },
      computed:{
        buttonText(){
          return this.title == '添加商品' ? '立即添加商品' : '立即修改商品'
        }
      },
      methods: {
        back(){
          this.avatar = ''
          this.hideBox = true
          this.form={
            name:'',
            price:'',
            description:'',
            info:''
          }
          this.type = ''
          this.$router.push({path:'/goods'})

        },
        addImage(e){
          let file = e.target.files[0];

          if(file) {
            console.log('变化了', file)
            let reader = new FileReader()
            let that = this
            let img = new Image();
            reader.readAsDataURL(file)

            reader.onload = function (e) {
              // 这里的this 指向reader
              img.src = this.result
              img.onload = function() {
                let height = this.height;
                let width = this.width;
                let scale = height/width;
                let canvasWidth = 200;
                let canvasHeight = 200*scale;
                 console.log('img的信息',height, width)
                var canvas = document.createElement('canvas');
                var ctx = canvas.getContext('2d');
                canvas.width = canvasWidth;
                canvas.height = canvasHeight;
                ctx.drawImage(this, 0, 0, canvasWidth, canvasHeight);
                // 生成base64            
                let base64 = canvas.toDataURL('image/jpeg', 0.8);
                that.avatar = base64;

              }


            }


          }
        },
        showImage(){
          this.$refs.file.click();
          this.hideBox = !this.hideBox
        },
        updateForm(obj){
          this.avatar = obj.image
          this.hideBox = false
          this.actualName = obj.name
          this.form={
            name:obj.name,
            price:obj.price,
            description:obj.description,
            info:obj.info,
          }
          this.type = obj.id
        },
        selectPic(){
          this.$refs.file.click();
        },
        submitForm(){
          console.log('点击了')
          var that = this;
           if(this.title=='修改商品信息'){
             this.$axios.put(`/api/PUT/updateTheFood`,{
               data:{
                 image:this.avatar,
                 name:this.form.name,
                 price:this.form.price,
                 description:this.form.description,
                 info:this.form.info,
                 id:this.type,
                 actualName:this.actualName
               }
             }).then( () => {
               this.avatar = ''
               this.form = {
                 name:'',
                 price:'',
                 description:'',
                 info:''
               }
               this.type = ''
               this.hideBox = true;
               alert('修改菜品成功')
               this.$router.push({path:'/goods'})
               // window.location.reload()
             });
           }else{
             let that = this;
             this.$axios.post(`/api/POST/addFood`,{
               data:{
                 image:this.avatar,
                 name:this.form.name,
                 price:this.form.price,
                 description:this.form.description,
                 info:this.form.info,
                 id:this.type,
               }
             }).then( response => {
               this.avatar = ''
               this.form = {
                 name:'',
                 price:'',
                 description:'',
                 info:''
               }
               this.type = ''
               this.hideBox = true;
               alert('添加菜品成功')
               this.$router.push({path:'/goods'})
               // window.location.reload()
             });

         }


        },
        _initScroll() {
          this.$nextTick(() => {
            if (!this.addFoodPageContainer) {
              this.addFoodPageContainer = new BScroll(this.$refs.addFoodPageContainer, {
                click: true
              })
            } else {
              this.addFoodPageContainer.refresh();
            }
          })
        }
      }
    }
</script>

<style lang="stylus" scoped>
  .slide-leave-active,.slide-enter-active
    transition: all 0.3s linear;
  .slide-leave-to,.slide-enter
    transform: translate3d(100%,0,0);
  #addFoodPage-container
    position: fixed;
    left:0;
    top:0;
    bottom: 0;
    z-index:60;
    width:100%;
    background:#fff;
    overflow: hidden;
    text-align left
    .box
      padding-bottom px-to-rem(50)
      .title
        height:px-to-rem(30)
        line-height: px-to-rem(30)
        font-weight: 700;
        color:rgb(7,17,27);
        text-align center
        padding:40px 0 30px 0;
        font-size:px-to-rem(24)
        .icon
          position: absolute
          display: inline-block
          left:px-to-rem(18);
          color:#07111b;
      .add
        margin:0 auto;
        padding:0 auto;
        width:200px;
        height:200px;
        .icon
          margin:0 auto;
          font-size 140px
      .login-item
        height: px-to-rem(70);
        line-height:px-to-rem(70);
      .leftLable
        display: inline-block;
        vertical-align: middle
        text-align right
        width:30%
        font-size px-to-rem(15)
      .changeStyle
        display: inline-block;
        position: relative;
        font-size: px-to-rem(14);
        vertical-align: middle
        width:50%
        -webkit-appearance: none;
        background-color: #FFF;
        border-radius: 4px;
        border: 1px solid #DCDFE6;
        box-sizing: border-box;
        color: #606266;
        height: px-to-rem(40);
        line-height: px-to-rem(40);
        outline: 0;
        padding: 0 px-to-rem(15);
      .left-button
        cursor: pointer;
        text-align: center;
        height: px-to-rem(40);
        line-height: px-to-rem(40);
        background-color: dodgerblue;
        border-radius: 5px;
        padding: px-to-rem(10) px-to-rem(50);
        color: white;
        font-size px-to-rem(15)

</style>
