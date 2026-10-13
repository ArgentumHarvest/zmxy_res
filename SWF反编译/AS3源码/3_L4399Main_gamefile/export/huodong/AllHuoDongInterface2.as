package export.huodong
{
   import config.Config;
   import event.CommonEvent;
   import export.challengeboss.ChanllengeBossInsterface;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AllHuoDongInterface2 extends Sprite
   {
       
      
      public var btn_x:SimpleButton;
      
      public var btnzzsd:SimpleButton;
      
      public var btnrw:SimpleButton;
      
      public var btnlsh:SimpleButton;
      
      private var gc:Config;
      
      public function AllHuoDongInterface2()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btn_x.addEventListener("click",xClick);
         btnzzsd.addEventListener("click",zzsdClick);
         btnrw.addEventListener("click",rwClick);
         btnlsh.addEventListener("click",lshClick);
      }
      
      private function removed(e:Event) : void
      {
         btn_x.removeEventListener("click",xClick);
         btnzzsd.removeEventListener("click",zzsdClick);
         btnrw.removeEventListener("click",rwClick);
         btnlsh.removeEventListener("click",lshClick);
      }
      
      private function xClick(e:MouseEvent) : void
      {
         this.delloc();
      }
      
      private function zzsdClick(e:MouseEvent) : void
      {
         gc.ts.setTxt("珍珠店铺在水下迷宫");
         gc.stage.addChild(gc.ts);
      }
      
      private function rwClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("ShowTaskInterface"));
         this.delloc();
      }
      
      private function lshClick(e:MouseEvent) : void
      {
         var chanllengeBossIns:ChanllengeBossInsterface = new ChanllengeBossInsterface();
         this.parent.addChild(chanllengeBossIns);
         this.delloc();
      }
      
      private function delloc() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
