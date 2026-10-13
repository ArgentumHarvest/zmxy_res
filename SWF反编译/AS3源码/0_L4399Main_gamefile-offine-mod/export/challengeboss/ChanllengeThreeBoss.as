package export.challengeboss
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ChanllengeThreeBoss extends Sprite
   {
       
      
      private var gc:Config;
      
      public var btn_close:SimpleButton;
      
      public var fuxingbtn:SimpleButton;
      
      public var shouxingbtn:SimpleButton;
      
      public var luxingbtn:SimpleButton;
      
      public var flshelpbtn:SimpleButton;
      
      public function ChanllengeThreeBoss()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var fximg:* = undefined;
         var lximg:* = undefined;
         var sximg:* = undefined;
         if(gc.threebossChanllenge[0] == 1)
         {
            fximg = AUtils.getImageObj("cedfuxingimg");
            fximg.x = fuxingbtn.x;
            fximg.y = fuxingbtn.y;
            this.addChild(fximg);
         }
         else
         {
            fuxingbtn.addEventListener("click",fuxignClick);
         }
         if(gc.threebossChanllenge[1] == 1)
         {
            lximg = AUtils.getImageObj("cedluxingimg");
            lximg.x = luxingbtn.x;
            lximg.y = luxingbtn.y;
            this.addChild(lximg);
         }
         else
         {
            luxingbtn.addEventListener("click",luxingClick);
         }
         if(gc.threebossChanllenge[2] == 1)
         {
            shouxingbtn.removeEventListener("click",shouxingClick);
            sximg = AUtils.getImageObj("cedshouxingimg");
            sximg.x = shouxingbtn.x;
            sximg.y = shouxingbtn.y;
            this.addChild(sximg);
         }
         else
         {
            shouxingbtn.addEventListener("click",shouxingClick);
         }
         btn_close.addEventListener("click",xClick);
         flshelpbtn.addEventListener("click",helpClick);
      }
      
      private function removed(e:Event) : void
      {
         btn_close.removeEventListener("click",xClick);
         fuxingbtn.removeEventListener("click",fuxignClick);
         shouxingbtn.removeEventListener("click",shouxingClick);
         luxingbtn.removeEventListener("click",luxingClick);
         flshelpbtn.removeEventListener("click",helpClick);
      }
      
      private function fuxignClick(e:MouseEvent) : void
      {
         gc.curStageAndCurLevel.curStage = 11;
         gc.curStageAndCurLevel.curLevel = 1;
         this.selectOver();
      }
      
      private function shouxingClick(e:MouseEvent) : void
      {
         gc.curStageAndCurLevel.curStage = 11;
         gc.curStageAndCurLevel.curLevel = 3;
         this.selectOver();
      }
      
      private function luxingClick(e:MouseEvent) : void
      {
         gc.curStageAndCurLevel.curStage = 11;
         gc.curStageAndCurLevel.curLevel = 2;
         this.selectOver();
      }
      
      private function selectOver() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("ChanllengeBossInster"));
      }
      
      private function helpClick(e:MouseEvent) : void
      {
         var bossHelp:ThreeBossHelp = new ThreeBossHelp();
         this.addChild(bossHelp);
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
