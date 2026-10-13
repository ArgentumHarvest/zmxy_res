package export.level.StageListener481Children
{
   import com.greensock.TweenMax;
   import config.Config;
   import event.CommonEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import my.MainGame;
   
   public class Stage481Result extends Sprite
   {
       
      
      public var expTf:TextField;
      
      private var gc:Config;
      
      public function Stage481Result(e:uint)
      {
         super();
         gc = Config.getInstance();
         expTf.text = e.toString();
         this.addEventListener("addedToStage",__added);
         this.addEventListener("removedFromStage",__removed);
      }
      
      private function __added(evt:Event) : void
      {
         evt = evt;
         var sourceY:Number = this.y;
         TweenMax.delayedCall(2,function(_self:Stage481Result):*
         {
            _self = _self;
            TweenMax.to(_self,2,{
               "alpha":0,
               "onComplete":function(__self:Stage481Result):*
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
         MainGame.getInstance().destroyGame();
         gc.curStageAndCurLevel.curStage = 41;
         gc.curStageAndCurLevel.curLevel = 1;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
      }
   }
}
