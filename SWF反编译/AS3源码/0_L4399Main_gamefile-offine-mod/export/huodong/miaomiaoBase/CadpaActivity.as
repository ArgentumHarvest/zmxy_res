package export.huodong.miaomiaoBase
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CadpaActivity extends Sprite
   {
       
      
      protected var gc:Config;
      
      public var xbtn:SimpleButton;
      
      public function CadpaActivity()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      protected function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
      }
      
      protected function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
      }
      
      protected function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
