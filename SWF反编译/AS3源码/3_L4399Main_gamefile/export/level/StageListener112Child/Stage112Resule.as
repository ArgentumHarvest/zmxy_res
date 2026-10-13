package export.level.StageListener112Child
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import my.MainGame;
   
   public class Stage112Resule extends Sprite
   {
       
      
      public var jwealNumTf:TextField;
      
      public function Stage112Resule(num:uint)
      {
         super();
         jwealNumTf.text = num.toString();
         this.addEventListener("addedToStage",__added);
         this.addEventListener("removedFromStage",__removed);
      }
      
      private function __added(evt:Event) : void
      {
         evt = evt;
         var sourceY:Number = this.y;
         TweenMax.delayedCall(2,function(_self:Stage112Resule):*
         {
            _self = _self;
            TweenMax.to(_self,2,{
               "alpha":0,
               "onComplete":function(__self:Stage112Resule):*
               {
                  __self.destroy();
               },
               "onCompleteParams":[_self]
            });
         },[this]);
      }
      
      private function __removed(evt:Event) : void
      {
         this.removeEventListener("addedToStage",__added);
         this.removeEventListener("removedFromStage",__removed);
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         MainGame.getInstance().destroyGameAndSaveGame();
         GMain.getInstance().switchSence("showStageMap");
      }
   }
}
