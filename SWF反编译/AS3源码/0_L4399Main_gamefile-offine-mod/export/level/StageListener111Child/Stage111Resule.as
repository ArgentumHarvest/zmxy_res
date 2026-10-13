package export.level.StageListener111Child
{
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import my.MainGame;
   import my.SingleSavedBuff;
   
   public class Stage111Resule extends Sprite
   {
       
      
      public var buyTimesAddTf:TextField;
      
      public var dropRateAddTf:TextField;
      
      private var gc:Config;
      
      public function Stage111Resule(dropRate:uint, buyTimes:uint)
      {
         super();
         gc = Config.getInstance();
         dropRateAddTf.text = dropRate.toString() + "%";
         buyTimesAddTf.text = buyTimes.toString();
         gc.savedBuff.addBuff(SingleSavedBuff.BUFF_DROPRATE_ADD,dropRate,3600 * gc.frameClips);
         gc.dataObject.mysteriousshoptimes += buyTimes;
         this.addEventListener("addedToStage",__added);
         this.addEventListener("removedFromStage",__removed);
      }
      
      private function __added(evt:Event) : void
      {
         evt = evt;
         var sourceY:Number = this.y;
         TweenMax.delayedCall(2,function(_self:Stage111Resule):*
         {
            _self = _self;
            TweenMax.to(_self,2,{
               "alpha":0,
               "onComplete":function(__self:Stage111Resule):*
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
