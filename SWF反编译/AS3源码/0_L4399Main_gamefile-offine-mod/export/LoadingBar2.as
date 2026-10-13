package export
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class LoadingBar2 extends MovieClip
   {
       
      
      public var bar:MovieClip;
      
      public var curIdx:TextField;
      
      public var totalIdx:TextField;
      
      private var tipTf:TextField;
      
      private var gt:GameTips;
      
      public function LoadingBar2()
      {
         super();
         gt = new GameTips();
         gt.x = 0;
         gt.y = 170;
         this.addChild(gt);
         this.tipTf = new TextField();
         this.tipTf.selectable = false;
         var ttf:TextFormat = this.curIdx.defaultTextFormat;
         ttf.size = 18;
         this.tipTf.defaultTextFormat = ttf;
         this.tipTf.text = "卡住请刷新网页";
         this.tipTf.width = this.tipTf.textWidth + 10;
         this.tipTf.x = -this.tipTf.width / 2;
         this.tipTf.y = 200;
         this.addChild(this.tipTf);
         this.addEventListener("addedToStage",__added,false,0,true);
         this.addEventListener("removedFromStage",__removed,false,0,true);
      }
      
      protected function __removed(evt:Event) : void
      {
         this.removeChild(gt);
         this.gt = null;
         evt.stopImmediatePropagation();
      }
      
      protected function __added(evt:Event) : void
      {
         evt.stopImmediatePropagation();
      }
      
      public function setProcess(rate:int, idx:uint, totalLen:uint) : void
      {
         this.bar.gotoAndStop(rate);
         this.curIdx.text = (totalLen - idx).toString();
         this.totalIdx.text = "/" + totalLen.toString();
      }
   }
}
