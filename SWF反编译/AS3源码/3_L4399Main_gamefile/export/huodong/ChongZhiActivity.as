package export.huodong
{
   import com.superkaka.Tools.CommonEvent;
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ChongZhiActivity extends Sprite
   {
       
      
      private var gc:Config;
      
      public var czBtn:SimpleButton;
      
      public var xbtn:SimpleButton;
      
      public function ChongZhiActivity()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         czBtn.addEventListener("click",chongzhiHandler);
         xbtn.addEventListener("click",xBtnHandler);
      }
      
      private function removed(e:Event) : void
      {
         czBtn.removeEventListener("click",chongzhiHandler);
         xbtn.removeEventListener("click",xBtnHandler);
      }
      
      private function chongzhiHandler(e:MouseEvent) : void
      {
         gc.openUrl("https://my.4399.com/space-199596142-do-thread-id-30150590-tagid-80615.html");
      }
      
      private function xBtnHandler(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("OPEN_HUODONG_INTERFACE"));
      }
   }
}
