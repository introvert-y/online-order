<template>
	<div class="ratingselect">
		<div class="rating-type">
			<span class="block positive" @click="select(2)" :class="{'positiveActive':selectType===2}">{{desc.all}}<i class="count">{{ratings.length}}</i></span>
			<span class="block positive" @click="select(0)" :class="{'positiveActive':selectType===0}">{{desc.positive}}<i class="count">{{positives}}</i></span>
			<span class="block negative" @click="select(1)" :class="{'negativeActive':selectType===1}">{{desc.negative}}<i class="count">{{negatives}}</i></span>
		</div>
		<div class="switch" @click="toggleContent()" :class="{'heighLight':onlyContent===true}">
			<span class="icon-check_circle"></span>
			<span class="text">只看有内容的评价</span>
		</div>
	</div>
</template>

<script type="text/javascript">
	const POSITIVE = 0;
	const NEGATIVE = 1;
	const ALL = 2;

	export default{
     name:'rating-select',
     data(){
       return {
         selectType:2,
         onlyContent:true,
       }
     },
     props:{
       ratings:{
        type:Array,
        default(){
          return [];
        }
       },
       desc:{
        type:Object,
        default(){
          return{
             all:'全部',
             positive:"满意",
             negative:"不满意"
          }
        }
       }
     },
     methods:{
       select(type){
         this.selectType = type;
         this.$emit('rating-type-select',type);
       },
       toggleContent(){
        this.onlyContent = !this.onlyContent;
        this.$emit('rating-content-toggle',this.onlyContent);
       },

     },
     computed:{
       positives(){
         let numP = 0;
         for(let i of this.ratings){
           if(i.rateType===POSITIVE){
              numP++;
           }
         }
         return numP;
       },
       negatives(){
         let numN = 0;
         for(let i of this.ratings){
           if(i.rateType===NEGATIVE){
              numN++;
           }
         }
         return numN;
       }
     }
	}
</script>

<style lang="stylus" scoped>
.ratingselect
  .rating-type
    position: relative;
    padding: px-to-rem(18) 0;
    margin:px-to-rem(18);
    font-size: 0;
    border-1px(rgba(7, 17, 27, 0.1))
    .block
      display: inline-block;
      line-height: px-to-rem(16)
      padding:px-to-rem(8) px-to-rem(12);
      margin-right: px-to-rem(8);
      border-radius: 5px;
      font-size: px-to-rem(12);
      color:rgb(77,85,93);
      &>i
        font-size: px-to-rem(8);
        margin-left: px-to-rem(2);

    .positive
      background: rgba(0,160,220,0.2)
    .negative
      background: rgba(7,85,93,0.2)
    .positiveActive
      color:#fff;
      background: rgb(0,160,220);
    .negativeActive
      color:#fff;
      background: rgb(7,85,93);

  .switch
    padding: px-to-rem(12) px-to-rem(18);
    line-height: px-to-rem(24)
    border-bottom: px-to-rem(1) solid rgba(7,17,27,0.1);
    color:rgb(147,153,159);
    font-size: 0;
    .icon-check_circle
      display: inline-block;
      vertical-align: top;
      margin-right: px-to-rem(4)
      font-size: px-to-rem(24)
    .text
      display: inline-block;
      vertical-align: top;
      font-size: px-to-rem(12);
  .heighLight
    .icon-check_circle
      color:#00c850;

</style>
