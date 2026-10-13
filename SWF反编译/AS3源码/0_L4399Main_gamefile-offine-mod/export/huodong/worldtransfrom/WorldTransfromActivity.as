package export.huodong.worldtransfrom
{
   import event.CommonEvent;
   import export.vip.VipTransfrom;
   import flash.events.MouseEvent;
   import my.MainGame;
   
   public class WorldTransfromActivity extends VipTransfrom
   {
       
      
      public function WorldTransfromActivity()
      {
         super();
         this.listinst = ["玲珑宝塔6层","玲珑宝塔12层","玲珑宝塔18层","水下迷宫","蟠桃园","兜率宫地下1层","兜率宫地下2层","兜率宫地下3层","御马监"];
      }
      
      override protected function setTxt() : void
      {
         var i:* = 0;
         this.instxt.text = "可以将您快速传送到一些关卡中,今天还可以免费传送" + gc.dataObject.worldtransfromTimes + "次";
         for(i = uint(1); i <= 6; )
         {
            this["tr" + i]["txt"].text = "";
            if(this.listinst[i - 1 + (this.currentPage - 1) * 6])
            {
               this["tr" + i]["txt"].text = this.listinst[i - 1 + (this.currentPage - 1) * 6];
            }
            i++;
         }
      }
      
      override protected function transClick(e:MouseEvent) : void
      {
         if(this.targetNum == 0 || this.targetNum >= 10)
         {
            return;
         }
         trace("targetNum -->>" + this.targetNum);
         if(this.targetNum == 1)
         {
            gc.curStageAndCurLevel.curStage = 8;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(this.targetNum == 2)
         {
            gc.curStageAndCurLevel.curStage = 8;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(this.targetNum == 3)
         {
            gc.curStageAndCurLevel.curStage = 8;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(this.targetNum == 4)
         {
            gc.curStageAndCurLevel.curStage = 10;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(this.targetNum == 5)
         {
            gc.curStageAndCurLevel.curStage = 5;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(this.targetNum == 6)
         {
            gc.curStageAndCurLevel.curStage = 12;
            gc.curStageAndCurLevel.curLevel = 2;
         }
         else if(this.targetNum == 7)
         {
            gc.curStageAndCurLevel.curStage = 12;
            gc.curStageAndCurLevel.curLevel = 3;
         }
         else if(this.targetNum == 8)
         {
            gc.curStageAndCurLevel.curStage = 12;
            gc.curStageAndCurLevel.curLevel = 4;
         }
         else if(this.targetNum == 9)
         {
            gc.curStageAndCurLevel.curStage = 6;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         if(gc.dataObject.worldtransfromTimes >= 1)
         {
            gc.dataObject.worldtransfromTimes--;
         }
         if(this.targetNum <= 3)
         {
            gc.gameVip.dataObject.targetNum = this.targetNum;
         }
         else if(this.targetNum == 4)
         {
            gc.gameVip.dataObject.targetNum = 5;
         }
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
         this.issave = true;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
