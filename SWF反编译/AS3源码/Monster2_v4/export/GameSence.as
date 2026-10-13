package export
{
   import config.*;
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class GameSence extends MovieClip
   {
       
      
      private var gc:Config;
      
      public var isWall:MovieClip;
      
      public var bgContainer:MovieClip;
      
      public function GameSence(param1:uint = 1, param2:uint = 1)
      {
         super();
         this.gc = Config.getInstance();
         if(this.gc.gameMode != 3)
         {
            this.gotoAndStop(param1 + "-" + param2);
         }
         else
         {
            this.gotoAndStop("vs");
         }
         this.addEventListener(Event.ADDED_TO_STAGE,this.__added);
         var _loc3_:MovieClip = AUtils.getNewObj("bgClips");
         _loc3_.y = 65;
         _loc3_.gotoAndStop(param1 + "-" + param2);
         this.bgContainer.addChildAt(_loc3_,0);
      }
      
      private function __added(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.__added);
         var _loc2_:int = 0;
         while(_loc2_ < this.numChildren)
         {
            this.gc.pWorld.addSubObj(this.getChildAt(_loc2_));
            _loc2_++;
         }
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
