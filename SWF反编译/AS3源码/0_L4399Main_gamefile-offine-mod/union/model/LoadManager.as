package union.model
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   
   public class LoadManager
   {
      
      private static var content:Object = {};
       
      
      public function LoadManager()
      {
         super();
      }
      
      public static function load(url:String, loadComplete:Function, loadProgress:Function) : void
      {
         url = url;
         loadComplete = loadComplete;
         loadProgress = loadProgress;
         __secError = function(evt:SecurityErrorEvent):void
         {
            trace("加载出问题");
         };
         __ioError = function(evt:IOErrorEvent):void
         {
            trace("加载出问题");
         };
         __loadProgress = function(evt:ProgressEvent):void
         {
            loadProgress && loadProgress({
               "curr":evt.bytesLoaded,
               "total":evt.bytesTotal
            });
         };
         __loadAssetsComplete = function(evt:Event):void
         {
            loadComplete && loadComplete();
         };
         if(content[url])
         {
            loadComplete && loadComplete();
            return;
         }
         var load:Loader = new Loader();
         var context:LoaderContext = new LoaderContext();
         context.applicationDomain = ApplicationDomain.currentDomain;
         load.contentLoaderInfo.addEventListener("complete",__loadAssetsComplete);
         load.contentLoaderInfo.addEventListener("ioError",__ioError);
         load.contentLoaderInfo.addEventListener("securityError",__secError);
         load.contentLoaderInfo.addEventListener("progress",__loadProgress);
         load.load(new URLRequest(url),context);
         content[url] = load;
      }
      
      public static function getLoader(url:String) : Loader
      {
         return content[url];
      }
      
      public static function getProgress() : MovieClip
      {
         var i:int = 0;
         var c:* = null;
         var x:Number = NaN;
         var y:Number = NaN;
         var maxW:int = 940;
         var maxH:int = 590;
         var node:MovieClip = new MovieClip();
         var bg:Sprite = new Sprite();
         bg.graphics.beginFill(0);
         bg.graphics.drawRect(0,0,maxW,maxH);
         bg.graphics.endFill();
         bg.alpha = 0.3;
         node.addChild(bg);
         var cx:Number = maxW / 2;
         var cy:Number = maxH / 2;
         var sprite:Sprite = new Sprite();
         sprite.graphics.beginFill(16777215);
         sprite.graphics.drawCircle(0,0,30);
         sprite.graphics.endFill();
         sprite.x = cx;
         sprite.y = cy;
         node.addChild(sprite);
         var radian:Number = 0.6283185307179586;
         for(i = 0; i < 10; )
         {
            c = new Sprite();
            c.graphics.beginFill(0);
            x = Math.cos(radian * i) * 20;
            y = Math.sin(radian * i) * 20;
            c.graphics.drawCircle(x,y,5);
            c.graphics.endFill();
            c.alpha = (i + 1) / 10;
            sprite.addChild(c);
            i++;
         }
         var text:TextField = new TextField();
         text.x = cx - 10;
         text.y = cy - 10;
         node.addChild(text);
         node.text = text;
         node.sprite = sprite;
         return node;
      }
   }
}
