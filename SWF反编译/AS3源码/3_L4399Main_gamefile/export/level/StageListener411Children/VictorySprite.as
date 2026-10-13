package export.level.StageListener411Children
{
   import com.greensock.TweenMax;
   import config.Config;
   import event.CommonEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import my.MainGame;
   
   public class VictorySprite extends Sprite
   {
       
      
      public var beatNameTf:TextField;
      
      public var gongxunTf:TextField;
      
      public var gmtxt:TextField;
      
      public var qhdtxt:TextField;
      
      private var gc:Config;
      
      public function VictorySprite(beatName:String, gongxun:int, rd:uint)
      {
         super();
         gc = Config.getInstance();
         this.beatNameTf.text = beatName;
         this.gongxunTf.text = gongxun.toString();
         if(rd == 0)
         {
            this.gmtxt.text = "1";
            this.qhdtxt.text = "0";
         }
         else
         {
            this.gmtxt.text = "0";
            this.qhdtxt.text = "1";
         }
         this.addEventListener("addedToStage",__added,false,0,true);
      }
      
      public function setTxt(beatName:String, gongxun:int, rd:uint) : void
      {
         this.beatNameTf.text = beatName;
         this.gongxunTf.text = gongxun.toString();
         if(rd == 0)
         {
            this.gmtxt.text = "1";
            this.qhdtxt.text = "0";
         }
         else
         {
            this.gmtxt.text = "0";
            this.qhdtxt.text = "1";
         }
      }
      
      private function __added(evt:Event) : void
      {
         evt = evt;
         TweenMax.delayedCall(4,function(_self:VictorySprite):*
         {
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            GMain.getInstance().switchSence("showStageMap");
            gc.curStageAndCurLevel.curStage = 41;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            if(_self.parent)
            {
               _self.parent.removeChild(_self);
            }
         },[this]);
      }
   }
}
