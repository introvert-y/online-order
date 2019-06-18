<template>
  <div id="login-container">
    <div class="formStyle" v-show="showFlag">
      <div id="form-title">登录</div>
      <div class="item">
        <span class="iconfont iconzhanghaodenglu"></span>
        <span><input class="inputStyle" type="text" v-model="form1.account" placeholder="请输入账号" ></span>
      </div>
      <div class="item">
        <span class="iconfont iconmima"></span>
        <span><input class="inputStyle" type="password" v-model="form1.password" placeholder="请输入密码"></span>
        <span class="section" @click="toFindBackPasswordPage(true)">忘记密码</span>
      </div>
      <div class="enter" @click="submitForm">登录</div>
      <div class="enter" style="margin-top: 20px;" @click="toPage(true)">新用户注册</div>
    </div>
    <transition name="slide">
      <div class="loginPage" v-show="showLogin">
        <div class="title">注册页面</div>
        <div class="login-item">
          <span class="leftLable">用户名:</span>
          <span><input class="changeStyle" type="text" v-model="form2.name" placeholder="请输入内容"></span>
        </div>
        <div class="login-item">
          <span class="leftLable">账号:</span>
          <span><input class="changeStyle" type="text" v-model="form2.account" placeholder="请输入内容"></span>
        </div>
        <div class="login-item">
          <span class="leftLable">密码:</span>
          <span><input class="changeStyle" type="password" v-model="form2.password" placeholder="请输入内容"></span>
        </div>
        <div class="login-item">
          <span class="leftLable">确认密码:</span>
          <span><input class="changeStyle" type="password" v-model="form2.confirmPassword" placeholder="请输入内容"></span>
        </div>
        <div class="login-item">
          <span class="leftLable">手机号码:</span>
          <span><input class="changeStyle" type="text" v-model="form2.phoneNumber" placeholder="请输入内容"></span>
        </div>
        <div class="login-item" style="text-align: center">
          <span class="left-button" @click="loginSubmit">立即注册</span>
          <span class="left-button right-button" @click.stop.prevent="toPage(false)">取消</span>
        </div>
      </div>
    </transition>

    <div class="fine-back-password" v-show="showFineBack">
        <div class="title">找回密码页面</div>
        <div class="login-item">
          <span class="leftLable">账号:</span>
          <span><input class="changeStyle" type="text" v-model="form3.account" placeholder="请输入内容"></span>
        </div>
        <div class="login-item">
          <span class="leftLable">手机号码:</span>
          <span><input class="changeStyle" type="text" v-model="form3.phoneNumber" placeholder="请输入内容"></span>
        </div>
        <div class="login-item" style="text-align: center">
          <span class="left-button" @click="isExists">提交</span>
          <span class="left-button right-button" @click.stop.prevent="toFindBackPasswordPage(false)">取消</span>
        </div>
      </div>


    <div class="reset-password" v-show="showResetPassword">
        <div class="title">重设密码页面</div>
        <div class="login-item">
          <span class="leftLable">原密码:</span>
          <span><input class="changeStyle" type="text" v-model="user.password  " placeholder="请输入内容"></span>
        </div>
        <div class="login-item">
          <span class="leftLable">新密码:</span>
          <span><input class="changeStyle" type="password" v-model="form4.password" placeholder="请输入内容"></span>
        </div>
      <div class="login-item">
        <span class="leftLable">确认密码:</span>
        <span><input class="changeStyle" type="password" v-model="form4.confirmPassword" placeholder="请输入内容"></span>
      </div>
        <div class="login-item" style="text-align: center">
          <span class="left-button" @click="updateUserInfo">提交</span>
          <span class="left-button right-button" @click.stop.prevent=toResetPasswordPage(false)>取消</span>
        </div>
      </div>


  </div>
</template>

<script>
  import {mapMutations} from 'vuex'
    export default {
      name: "login",
      data(){
        return{
          showFlag:true,
          showLogin:false,
          showFineBack:false,
          showResetPassword:false,
          obj:{},
          form1:{
            account:'',
            password:''
          },
          form2: {
            name: '',
            account:"",
            password:'',
            confirmPassword:"",
            phoneNumber:''
          },
          form3: {
            account:"",
            phoneNumber:''
          },
          form4: {
            password:"",
            confirmPassword:''
          },
          user:{},
        }
      },
      created(){
        this.keyupSubmit()
      },
      methods:{
        ...mapMutations({
          setObj:'SET_OBJ'
        }),
        keyupSubmit(){
          document.onkeydown=e=>{
            let _key=window.event.keyCode;
            if(_key===13){
              this.submitForm()
            }
          }
        },
        submitForm(){
          if(this.form1.account==undefined||this.form1.account==''){
            alert('账号不能为空')
            return
          }else if(this.form1.password==undefined||this.form1.password=='') {
            alert('密码不能为空')
            return
          }
            this.receiveData()
        },
        toPage(flag){
          if(flag){
            this.showFlag = false;
            this.showLogin = true;
          }else{
            this.showFlag = true;
            this.showLogin = false;
          }

        },
        toFindBackPasswordPage(flag){
          if(flag){
            this.showFlag = false;
            this.showFineBack = true;
          }else{
            this.form3= {
              account:"",
              phoneNumber:''
            }
            this.showFlag = true;
            this.showFineBack = false;
          }
        },
        toResetPasswordPage(flag){
          this.showFineBack = false;
          if(flag){
            this.showResetPassword = true;
          }else{
            this.showResetPassword = false;
            this.showFlag = true

          }
        },
        loginSubmit(){
          if(this.form2.password!==this.form2.confirmPassword){
            alert('两次密码输入不一致，请重新输入')
            this.form2.password = '';
            this.form2.confirmPassword = '';
          }else{
            console.log(this.form2)
            let data = '';
            //先判断是否已经存在该账号
            this.$axios.get(`/api/GET/userExist`, {
                params: {
                  account: this.form2.account,
                  password: this.form2.password
                }
              }
             )
              .then( response => {
                  if(response.data.length>0){
                    alert('该账号已存在，请重新注册新账号')
                    this.form2.account = '';
                    return ;
                  }else{
                    this.$axios.post(`/api/POST/newUser`,{
                      name: this.form2.name,
                      account: this.form2.account,
                      password:this.form2.password,
                      phoneNumber:this.form2.phoneNumber
                     })
                      .then( () => {
                        alert('注册成功')
                        this.form2 = {
                          name: '',
                          account:"",
                          password:'',
                          confirmPassword:"",
                          phoneNumber:'',
                        }
                        this.showLogin = false;
                        this.showFlag = !this.showFlag;
                      })
                  }
              })

          }
        },
        isExists(){
          let that = this;
          this.$axios.get(`/api/GET/isUserFlag`, {
              params: {
                account: this.form3.account,
                phoneNumber: this.form3.phoneNumber
              }
            }
          )
            .then( response => {
              that.form3 = {
                account:'',
                phoneNumber:''
              }
              if (response.data.length > 0) {
                 this.user = response.data[0];
                this.toResetPasswordPage(true)
              }else{
                alert("输入信息有误，请重新输入")
              }
            })
        },
        updateUserInfo(){
          let that = this;
          if(this.form4.password!==this.form4.confirmPassword){
            alert('两次密码输入不一致，请重新输入')
            this.form4.password = '';
            this.form4.confirmPassword = '';
          }else{
            this.$axios.put(`/api/PUT/updateUserInfo`, {
              account: this.user.account,
              password: this.form4.password
            })
              .then( response => {
                alert('修改密码成功')
                this.user = {}
                this.toResetPasswordPage(false)
              })

          }
        },
        receiveData(){
          this.$axios.get(`/api/GET/userExist`,{
            params: {
              account: this.form1.account,
              password: this.form1.password
            }
          })
            .then( response => {
              if(response.data.length>0){
                console.log('identity',response)
                this.obj = response.data[0]
                this.setObj(this.obj);
                sessionStorage.setItem('identity',JSON.stringify(this.obj));
                this.addRouters();
              }else{
                alert('账号密码错误，请重新输入')
                this.form1.account=null;
                this.form1.password=null;
                return;
              }

            });
        },
        addRouters(){
          if(this.obj.identity == '顾客'){
            this.$router.addRoutes([
              {
                path:'/confirmOrder',
                component:resolve => require(['../confirmOrder/confirmOrder.vue'],resolve)
              },
              {
                path:'/waitForTime',
                component:resolve => require(['../waitForTime/waitForTime.vue'],resolve)
              },
              {
                path:'/ratingFoodPage',
                component:resolve => require(['../ratingFoodPage/ratingFoodPage.vue'],resolve)
              },
            ]);//调用addRoutes添加路由
            if(this.$router.history.current.params.type=='1'){
              this.$router.push({path:'/confirmOrder'})
            }else if(this.$router.history.current.params.type=='2'){
              this.$router.push({path:'/myOrder'})
            }

          }else if(this.obj.identity == '商家'){
            this.$router.addRoutes([
              {
                path:'/addFoodPage',
                component:resolve => require(['../addFoodPage/addFoodPage.vue'],resolve)
              },
              {
                path:'/sales',
                component:resolve => require(['../sales/sales.vue'],resolve)
              }
            ]);
            this.$router.push({path:'/sales'})
          }
        }

      }
    }
</script>

<style lang="stylus" scoped>
  #login-container
    position: fixed
    top:0;
    width: 100%;
    height: 100%;
    background-color #104E8B
    z-index 100
    .formStyle
      position: absolute;
      top: 50%;
      left: 50%;
      width: px-to-rem(300);
      height: px-to-rem(500);
      transform:translate(-50%,-50%)
      background: white;
      border-radius: 5px;
      box-shadow: 0px 0px px-to-rem(5) #333333;
      font-size px-to-rem(12);
      #form-title
        text-align left
        font-size: px-to-rem(24);
        margin-top: 100px;
        padding-left: px-to-rem(40);
        box-sizing: border-box;
        color: #333333;
        margin-bottom: px-to-rem(50);

      .item
        position: relative
        margin: 0 auto px-to-rem(30) auto;
        .iconfont
          font-size px-to-rem(16)
        .inputStyle
          margin-left px-to-rem(10)
          padding-left: px-to-rem(10);
          height: px-to-rem(30);
          width:60%
          font-size px-to-rem(15)
          border-bottom: px-to-rem(1) solid #cccccc;
          border-top: px-to-rem(1) solid #ffffff;
          border-left: px-to-rem(1) solid #ffffff;
          border-right: px-to-rem(1) solid #ffffff;
          box-sizing: border-box;

        .section
          position: absolute;
          bottom:px-to-rem(-30);
          right:px-to-rem(5);
          font-size px-to-rem(10)
          color:#ADADAD
          padding:px-to-rem(5)
      .enter
        cursor: pointer;
        width: px-to-rem(250);
        text-align: center;
        height: px-to-rem(40);
        line-height: px-to-rem(40);
        background-color: dodgerblue;
        border-radius: 5px;
        margin: 0 auto;
        margin-top: px-to-rem(50);
        color: white;
    .slide-leave-active,.slide-enter-active
      transition: all 0.4s linear;
    .slide-enter
      transform: translate3d(100%,0,0);
    .slide-leave-to
      transform: translate3d(100%,0,0);
    .loginPage
      width:100%
      height: 100%
      background-color #fff
      text-align left
      z-index 120
      .title
        padding:px-to-rem(40) 0 30px 0;
        text-align center
        font-size:px-to-rem(24)
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
          padding: px-to-rem(10);
          color: white;
          font-size px-to-rem(15)
        .right-button
          padding:px-to-rem(10) px-to-rem(20);
          margin-left: px-to-rem(10)

    .fine-back-password
      width:100%
      height: 100%
      background-color #fff
      text-align left
      z-index 120
      .title
        padding:px-to-rem(40) 0 30px 0;
        text-align center
        font-size:px-to-rem(24)
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
          padding: px-to-rem(10);
          color: white;
          font-size px-to-rem(15)
        .right-button
          padding:px-to-rem(10) px-to-rem(20);
          margin-left: px-to-rem(10)

    .reset-password
      width:100%
      height: 100%
      background-color #fff
      text-align left
      z-index 150
      .title
        padding:px-to-rem(40) 0 30px 0;
        text-align center
        font-size:px-to-rem(24)
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
          padding: px-to-rem(10);
          color: white;
          font-size px-to-rem(15)
        .right-button
          padding:px-to-rem(10) px-to-rem(20);
          margin-left: px-to-rem(10)

</style>


