package export.mirror
{
   import config.Config;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MyTextField;
   import task.Task;
   
   public class ShowBossPositionInterface extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var containtxt:TextField;
      
      private var gc:Config;
      
      private var rTask:Task;
      
      private var headImg:Bitmap;
      
      private var infoTxt:MyTextField;
      
      public function ShowBossPositionInterface()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",added,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var str:* = null;
         var dayAry1:* = null;
         var year1:* = 0;
         var month1:* = 0;
         var day1:* = 0;
         var date1:* = null;
         xbtn.addEventListener("click",xClick);
         var obj:Object = gc.allTask.getMonsterBirth();
         if(obj != null)
         {
            infoTxt = new MyTextField(0,"FZCuYuan-M03S",16);
            str = "Boss" + gc.allTask.getRewardTaskMonsterName() + "在" + this.transStageChinaName(obj.stage,obj.level) + "出现";
            dayAry1 = gc.dataObjectInstance.curDate.split("-");
            year1 = uint(int(dayAry1[0]));
            month1 = uint(int(dayAry1[1]) - 1);
            day1 = uint(int(dayAry1[2]));
            date1 = new Date(year1,month1,day1);
            if(date1.getTime() < 1356969599000)
            {
               str += "\n圣诞老人马上现身啦";
            }
            infoTxt.setText(str);
            infoTxt.x = 435;
            infoTxt.y = 320;
            this.addChild(infoTxt);
         }
         if(gc.allTask.getRewardTaskMonsterName() != "")
         {
            headImg = AUtils.getImageObj(gc.allTask.getRewardTaskMonsterName() + "_Image");
            if(headImg)
            {
               headImg.x = 320.1;
               headImg.y = 309.05;
               this.addChild(headImg);
            }
         }
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function transStageChinaName(__stage:uint, __level:uint) : String
      {
         var cname:String = "";
         if(__stage == 1 && __level == 2)
         {
            cname = "天宫道";
         }
         else if(__stage == 1 && __level == 3)
         {
            cname = "南天门";
         }
         else if(__stage == 2 && __level == 1)
         {
            cname = "南天王殿";
         }
         else if(__stage == 2 && __level == 2)
         {
            cname = "西天王殿";
         }
         else if(__stage == 2 && __level == 3)
         {
            cname = "北天王殿";
         }
         else if(__stage == 3 && __level == 1)
         {
            cname = "彩虹楼";
         }
         else if(__stage == 3 && __level == 2)
         {
            cname = "朝会殿";
         }
         else if(__stage == 3 && __level == 3)
         {
            cname = "凌霄宝殿";
         }
         else if(__stage == 20 && __level == 1)
         {
            cname = "火龙岛";
         }
         else if(__stage == 21 && __level == 1)
         {
            cname = "九龙岛";
         }
         else if(__stage == 21 && __level == 2)
         {
            cname = "龙脊山";
         }
         else if(__stage == 21 && __level == 3)
         {
            cname = "妖尾林";
         }
         else if(__stage == 22 && __level == 1)
         {
            cname = "仙音岛";
         }
         else if(__stage == 22 && __level == 2)
         {
            cname = "仙幻岛";
         }
         else if(__stage == 22 && __level == 3)
         {
            cname = "仙树岛";
         }
         else if(__stage == 24 && __level == 1)
         {
            cname = "绝仙们";
         }
         else if(__stage == 24 && __level == 2)
         {
            cname = "紫晶门";
         }
         else if(__stage == 24 && __level == 3)
         {
            cname = "戮仙门";
         }
         else if(__stage == 25 && __level == 1)
         {
            cname = "指景宫";
         }
         else if(__stage == 25 && __level == 2)
         {
            cname = "陷仙门";
         }
         return cname;
      }
   }
}
