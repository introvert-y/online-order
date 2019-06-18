<template>
    <div id="sales">
      <div id="sales-number"></div>
      <div id="proportion"></div>
    </div>
</template>

<script>
    export default {
      name: "sales",
      data(){
        return{
          goodNameArr:[],
          sellerArr:[],
          obj:{}
        }
      },
      mounted(){
        this.drawLine();
      },
      methods: {
        drawLine(){
          // 基于准备好的dom，初始化echarts实例
          // let myChart = this.$echarts.init(document.getElementById('myChart'))
          let myChart = this.$echarts.init(document.getElementById('sales-number'), null, {renderer: 'svg'})
          let myChart2 = this.$echarts.init(document.getElementById('proportion'), null, {renderer: 'svg'})
          // 绘制图表
          let option = {
            baseOption:{
              title: { text: '月销量前五名' },
              tooltip: {},
              xAxis: {
                data: []
              },
              legend: {
                data:['销量'],
              },
              yAxis: {},
              series: [{
                name: '销量',
                type: 'bar',
                data: []
              }]
            },
          }
          myChart.setOption(option);
          myChart2.setOption({
            title: { text: '销量占总比' },
            series : [
              {
                name: '访问来源',
                type: 'pie',
                radius: '55%',
                // roseType: 'angle',
                data:[
                  {value:this.sellerArr[0], name:this.goodNameArr[0]},
                  {value:this.sellerArr[1], name:this.goodNameArr[1]},
                  {value:this.sellerArr[2], name:this.goodNameArr[2]},
                  {value:this.sellerArr[3], name:this.goodNameArr[3]},
                  {value:this.sellerArr[4], name:this.goodNameArr[4]}
                ]
              }
            ]
          })

          this.$axios.get('/api/GET/goods')
            .then( response => {
              // console.log('goods格式化前',response.data)
              this._formatData(response.data);
              response = null;
              setTimeout(() =>{
                myChart.setOption({
                  xAxis: {
                    data: this.goodNameArr
                  },
                  series: [{
                    // 根据名字对应到相应的系列
                    name: '销量',
                    data: this.sellerArr
                  }]
                });
                myChart2.setOption({
                  series : [
                    {
                      data:[
                        {value:this.sellerArr[0], name:this.goodNameArr[0]},
                        {value:this.sellerArr[1], name:this.goodNameArr[1]},
                        {value:this.sellerArr[2], name:this.goodNameArr[2]},
                        {value:this.sellerArr[3], name:this.goodNameArr[3]},
                        {value:this.sellerArr[4], name:this.goodNameArr[4]},
                        {value:this.obj.sellCount, name:this.obj.name},

                      ]
                    }
                  ]
                })
              },300)
            });
        },
        _formatData(arr){
          let goodNameArr = [];
          let sellerArr = [];
          let sellCount = 0;
          for(let i = 0 ;i<=4;i++){
            goodNameArr[i] = arr[i].name;
            sellerArr[i] = arr[i].sellCount;
          }
          for(let i = 6 ;i<=arr.length-1;i++){
            sellCount+=arr[i].sellCount;
          }
          this.obj.name = '其他'
          this.obj.sellCount = sellCount;
          this.goodNameArr = goodNameArr;
          this.sellerArr = sellerArr;
          console.log(goodNameArr)
          console.log(sellerArr)
        }

      }
    }
</script>

<style lang="stylus" scoped>
  #sales
    width: 100%
    overflow: hidden
    #sales-number
      margin:30px auto;
      height: 300px
      width:375px
    #proportion
      margin:0 auto;
      height: 300px
      width:375px
</style>
