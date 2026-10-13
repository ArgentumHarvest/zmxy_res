package export.vip
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class VipTransfrom extends Sprite
   {
       
      
      protected var gc:Config;
      
      public var instxt:TextField;
      
      public var btn_close:SimpleButton;
      
      public var nextbtn:SimpleButton;
      
      public var prebtn:SimpleButton;
      
      public var transbtn:SimpleButton;
      
      public var tr1:MovieClip;
      
      public var tr2:MovieClip;
      
      public var tr3:MovieClip;
      
      public var tr4:MovieClip;
      
      public var tr5:MovieClip;
      
      public var tr6:MovieClip;
      
      protected var targetNum:uint = 0;
      
      protected var listinst:Array;
      
      protected var issave:Boolean = false;
      
      protected var currentPage:uint = 1;
      
      public function VipTransfrom()
      {
         listinst = ["玲珑宝塔6层","玲珑宝塔12层","玲珑宝塔18层","玲珑宝塔24层","水下迷宫","蟠桃园","兜率宫地下1层","兜率宫地下2层","兜率宫地下3层","兜率宫地下4层"];
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btn_close.addEventListener("click",xClick);
         nextbtn.addEventListener("click",nextClick);
         prebtn.addEventListener("click",preClick);
         transbtn.addEventListener("click",transClick);
         tr1.addEventListener("click",trClick);
         tr2.addEventListener("click",trClick);
         tr3.addEventListener("click",trClick);
         tr4.addEventListener("click",trClick);
         tr5.addEventListener("click",trClick);
         tr6.addEventListener("click",trClick);
         this.setTxt();
      }
      
      private function removed(e:Event) : void
      {
         btn_close.removeEventListener("click",xClick);
         nextbtn.removeEventListener("click",nextClick);
         prebtn.removeEventListener("click",preClick);
         transbtn.removeEventListener("click",transClick);
         tr1.removeEventListener("click",trClick);
         tr2.removeEventListener("click",trClick);
         tr3.removeEventListener("click",trClick);
         tr4.removeEventListener("click",trClick);
         tr5.removeEventListener("click",trClick);
         tr6.removeEventListener("click",trClick);
         if(this.issave)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         e.stopImmediatePropagation();
      }
      
      protected function setTxt() : void
      {
         var i:* = 0;
         this.instxt.text = "可以将您快速传送到一些关卡中,今天还可以免费传送" + (5 - gc.gameVip.vipsavelist[1]) + "次";
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
      
      protected function trClick(e:MouseEvent) : void
      {
         var i:* = 0;
         for(i = uint(1); i <= 6; )
         {
            this["tr" + i].gotoAndStop(1);
            i++;
         }
         if(e.currentTarget is MovieClip)
         {
            e.currentTarget.gotoAndStop(2);
            this.targetNum = uint(String(e.currentTarget.name).substr(2,1)) + (this.currentPage - 1) * 6;
         }
      }
      
      protected function transClick(e:MouseEvent) : void
      {
         if(this.targetNum == 0 || this.targetNum > 10)
         {
            return;
         }
         if(gc.gameVip.vipsavelist[1] < 5)
         {
            var _loc2_:int = 1;
            var _loc3_:* = gc.gameVip.vipsavelist[_loc2_] + 1;
            gc.gameVip.vipsavelist[_loc2_] = _loc3_;
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
               gc.curStageAndCurLevel.curStage = 8;
               gc.curStageAndCurLevel.curLevel = 1;
            }
            else if(this.targetNum == 5)
            {
               gc.curStageAndCurLevel.curStage = 10;
               gc.curStageAndCurLevel.curLevel = 1;
            }
            else if(this.targetNum == 6)
            {
               gc.curStageAndCurLevel.curStage = 5;
               gc.curStageAndCurLevel.curLevel = 1;
            }
            else if(this.targetNum == 7)
            {
               gc.curStageAndCurLevel.curStage = 12;
               gc.curStageAndCurLevel.curLevel = 2;
            }
            else if(this.targetNum == 8)
            {
               gc.curStageAndCurLevel.curStage = 12;
               gc.curStageAndCurLevel.curLevel = 3;
            }
            else if(this.targetNum == 9)
            {
               gc.curStageAndCurLevel.curStage = 12;
               gc.curStageAndCurLevel.curLevel = 4;
            }
            else if(this.targetNum == 10)
            {
               gc.curStageAndCurLevel.curStage = 12;
               gc.curStageAndCurLevel.curLevel = 5;
            }
            this.issave = true;
            gc.gameVip.dataObject.targetNum = this.targetNum;
            gc.eventManger.dispatchEvent(new CommonEvent("ChanllengeBossInster"));
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("您的次数已经用完，请明天继续再来!");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function preClick(e:MouseEvent) : void
      {
         if(this.currentPage > 1)
         {
            this.currentPage--;
            this.setTxt();
         }
      }
      
      private function nextClick(e:MouseEvent) : void
      {
         if(this.currentPage <= 1)
         {
            this.currentPage++;
         }
         this.setTxt();
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
