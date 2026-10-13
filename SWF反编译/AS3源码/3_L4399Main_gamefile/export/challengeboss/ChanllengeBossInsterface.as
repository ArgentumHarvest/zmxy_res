package export.challengeboss
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ChanllengeBossInsterface extends Sprite
   {
       
      
      private var gc:Config;
      
      public var boss1:MovieClip;
      
      public var boss2:MovieClip;
      
      public var boss3:MovieClip;
      
      public var boss4:MovieClip;
      
      public var boss5:MovieClip;
      
      public var boss6:MovieClip;
      
      public var xbtn:SimpleButton;
      
      public var rebtn:SimpleButton;
      
      public function ChanllengeBossInsterface()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var i:* = 0;
         trace("ChanllengeBossInsterface -----add");
         xbtn.addEventListener("click",xClick);
         var blen:uint = 6;
         var bool:Boolean = true;
         for(i = uint(0); i < blen; )
         {
            if(this["boss" + (i + 1)] != undefined)
            {
               this["boss" + (i + 1)].buttonMode = true;
               this["boss" + (i + 1)].removeEventListener("click",selectBoss);
               if(gc.bossChallenge[i] == 1)
               {
                  this["boss" + (i + 1)].gotoAndStop(2);
                  bool = true;
               }
               else if(gc.bossChallenge[i] == 0)
               {
                  if(bool)
                  {
                     this["boss" + (i + 1)].gotoAndStop(1);
                     this["boss" + (i + 1)].addEventListener("click",selectBoss);
                  }
                  else
                  {
                     this["boss" + (i + 1)].gotoAndStop(3);
                  }
                  bool = false;
               }
            }
            i++;
         }
         rebtn.addEventListener("click",refreshChanllengeBoss);
         if(gc.gameVip.getVipLevel() >= 4)
         {
            rebtn.visible = true;
         }
         else
         {
            rebtn.visible = false;
         }
      }
      
      private function removed(e:Event) : void
      {
         rebtn.removeEventListener("click",refreshChanllengeBoss);
         xbtn.removeEventListener("click",xClick);
         for(var blen:uint = 6; blen-- > 0; )
         {
            if(this["boss" + (blen + 1)] != undefined)
            {
               this["boss" + (blen + 1)].removeEventListener("click",selectBoss);
            }
         }
      }
      
      private function refreshChanllengeBoss(e:MouseEvent) : void
      {
         if(gc.gameVip.getVipLevel() >= 4)
         {
            if(gc.gameVip.vipsavelist[3] < 1)
            {
               var _loc2_:int = 3;
               var _loc3_:* = gc.gameVip.vipsavelist[_loc2_] + 1;
               gc.gameVip.vipsavelist[_loc2_] = _loc3_;
               gc.bossChallenge = [0,0,0,0,0,0];
               gc.ts.setTxt("刷新成功!");
               gc.stage.addChild(gc.ts);
               this.xClick(null);
            }
            else
            {
               gc.ts.setTxt("您的次数已经用完!");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            gc.ts.setTxt("您的VIP等级不够");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function selectBoss(e:MouseEvent) : void
      {
         gc.curStageAndCurLevel.curStage = 4;
         if(e.target.name == "boss1")
         {
            gc.curStageAndCurLevel.curLevel = 4;
         }
         else if(e.target.name == "boss2")
         {
            gc.curStageAndCurLevel.curLevel = 3;
         }
         else if(e.target.name == "boss3")
         {
            gc.curStageAndCurLevel.curLevel = 2;
         }
         else if(e.target.name == "boss4")
         {
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(e.target.name == "boss5")
         {
            gc.curStageAndCurLevel.curLevel = 5;
         }
         else if(e.target.name == "boss6")
         {
            gc.curStageAndCurLevel.curLevel = 6;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("ChanllengeBossInster"));
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
