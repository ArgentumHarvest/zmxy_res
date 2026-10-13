package export
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class LoadingBar3 extends Sprite
   {
       
      
      private var bar:Sprite;
      
      private var bg:Sprite;
      
      private var _currentFileIdx:uint = 1;
      
      private var _totalFileIdx:uint = 1;
      
      private var _tipTf:TextField;
      
      public function LoadingBar3()
      {
         super();
         bg = new Sprite();
         bg.graphics.beginFill(0,0.2);
         bg.graphics.drawRect(0,0,960,590);
         bg.graphics.endFill();
         this.addChild(bg);
         bar = AUtils.getNewObj("LoadingBar3") as Sprite;
         bar.x = 480;
         bar.y = 295;
         this.addChild(bar);
         bar["progressTxt"].y -= 2;
         _tipTf = new TextField();
         _tipTf.defaultTextFormat = new TextFormat(null,null,16777215);
         _tipTf.text = "(卡住请刷新)";
         _tipTf.x = 445;
         _tipTf.y = 272;
         this.addChild(_tipTf);
      }
      
      public function updatePregress(percent:uint) : void
      {
         trace("percent：" + percent);
         bar["progressTxt"].text = percent + "%(" + this.currentFileIdx + "/" + this.totalFileIdx + ")";
         bar["progressBar"]["bar"].width = 219 * percent / 100;
      }
      
      public function get currentFileIdx() : uint
      {
         return _currentFileIdx;
      }
      
      public function set currentFileIdx(value:uint) : void
      {
         _currentFileIdx = value;
      }
      
      public function get totalFileIdx() : uint
      {
         return _totalFileIdx;
      }
      
      public function set totalFileIdx(value:uint) : void
      {
         _totalFileIdx = value;
      }
   }
}
