package export
{
   import config.Config;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.net.URLRequest;
   import flash.text.TextField;
   
   public class LoadingBar extends MovieClip
   {
       
      
      public var bar:MovieClip;
      
      public var fileIdx:TextField;
      
      public var tips:MovieClip;
      
      public var versionTf:TextField;
      
      private var gc:Config;
      
      private var lo:Loader;
      
      public function LoadingBar()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",__added,false,0,true);
         this.addEventListener("removedFromStage",__removed,false,0,true);
      }
      
      private function __added(evt:Event) : void
      {
         var filter:* = null;
         lo = new Loader();
         lo.load(new URLRequest("FuYun.swf"));
         lo.addEventListener("addedToStage",__addedSmallGame);
         this.addChild(lo);
         var version:String = gc.dataObject.version;
         var arr:Array = version.split(".");
         if(arr.length == 1)
         {
            version += ".0";
         }
         else if(arr.length == 2)
         {
            if((arr[1] as String).length == 2)
            {
               version = arr[0] + "." + (arr[1] as String).charAt(0) + "." + (arr[1] as String).charAt(1);
            }
         }
         if(this.versionTf)
         {
            this.versionTf.x -= 30;
            this.versionTf.text = "V " + version + "";
            this.versionTf.width = this.versionTf.textWidth + 10;
            this.versionTf.height = this.versionTf.textHeight + 5;
         }
         if(gc.isBlack)
         {
            filter = new ColorMatrixFilter([0.3,0.6,0,0,0,0.3,0.6,0,0,0,0.3,0.6,0,0,0,0,0,0,1,0]);
            this.filters = [filter];
         }
      }
      
      protected function __addedSmallGame(event:Event) : void
      {
         lo.x = -470;
         lo.y = -295;
      }
      
      private function __removed(e:Event) : void
      {
         if(lo.parent)
         {
            lo.parent.removeChild(lo);
         }
         lo.removeEventListener("addedToStage",__addedSmallGame);
         lo.unload();
         lo = null;
      }
      
      public function setProcess(rate:int, files:int) : void
      {
         if(this.fileIdx)
         {
            this.fileIdx.text = String(files);
         }
         if(this.bar)
         {
            this.bar.gotoAndStop(rate);
         }
      }
   }
}
