package loader
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class SingleLoader extends EventDispatcher
   {
       
      
      private var _urlloader:URLLoader;
      
      private var urlreq:URLRequest;
      
      private var llloader:Loader;
      
      private var _retryTimes:uint = 3;
      
      private var _assetsType:uint = 0;
      
      private var _bytesTotal:Number = 0;
      
      private var _bytesLoaded:Number = 0;
      
      public var onComplete:Function;
      
      public var onFail:Function;
      
      public function SingleLoader()
      {
         super();
         this.urlloader = new URLLoader();
         this.urlreq = new URLRequest();
         this.llloader = new Loader();
      }
      
      public function load(url:String) : void
      {
         var temp:Array = url.split(".");
         var last:String = temp[temp.length - 1];
         if(last.indexOf("?") != -1)
         {
            last = last.split("?")[0];
         }
         last = last.toLowerCase();
         if(last == "swf")
         {
            this._assetsType = 0;
            this.urlloader.dataFormat = "binary";
         }
         else if(last == "xml")
         {
            this._assetsType = 1;
         }
         else
         {
            if(last != "mp3")
            {
               throw new Error("卧槽！这是什么文件？？！！---url:" + url);
            }
            this._assetsType = 2;
         }
         this.urlreq.url = url;
         this.urlloader.addEventListener("complete",__complete);
         this.urlloader.addEventListener("ioError",__ioError);
         this.urlloader.addEventListener("progress",__progress);
         this.urlloader.addEventListener("securityError",__secError);
         this.urlloader.load(this.urlreq);
      }
      
      protected function __progress(evt:ProgressEvent) : void
      {
         this.bytesTotal = evt.bytesTotal;
         this.bytesLoaded = evt.bytesLoaded;
      }
      
      protected function __secError(evt:SecurityErrorEvent) : void
      {
         this.retry();
      }
      
      protected function __ioError(evt:IOErrorEvent) : void
      {
         this.retry();
      }
      
      protected function __complete(evt:Event) : void
      {
         var bytes:* = null;
         if(this._assetsType == 0)
         {
            bytes = this.urlloader.data as ByteArray;
            this.llloader.contentLoaderInfo.addEventListener("complete",__loadToLocalComplete);
            this.llloader.loadBytes(bytes,new LoaderContext(false,ApplicationDomain.currentDomain));
         }
         else
         {
            if(this.onComplete != null)
            {
               this.onComplete(this);
            }
            this.destroy();
         }
      }
      
      protected function __loadToLocalComplete(evt:Event) : void
      {
         this.onComplete(this);
         var li:LoaderInfo = evt.target as LoaderInfo;
         this.analysis(li);
         this.destroy();
      }
      
      private function analysis(li:LoaderInfo) : void
      {
         var ai:AssetsItem = new AssetsItem();
         ai.data = li.content;
         ai.type = this.assetsType;
         ai.loaderInfo = li;
         ai.url = this.urlreq.url;
         switch(int(this._assetsType))
         {
            case 0:
               break;
            case 1:
               break;
            case 2:
         }
         AssetsManager.getInstance().addAssets(ai);
      }
      
      private function retry() : void
      {
         if(this.retryTimes > 0)
         {
            this.retryTimes--;
            this.urlloader.load(this.urlreq);
         }
         else
         {
            if(this.onFail != null)
            {
               this.onFail();
            }
            this.destroy();
         }
      }
      
      private function destroy() : void
      {
         this.urlloader.removeEventListener("complete",__complete);
         this.urlloader.removeEventListener("ioError",__ioError);
         this.urlloader.removeEventListener("securityError",__secError);
         this.urlloader = null;
         this.urlreq = null;
         this.llloader.contentLoaderInfo.removeEventListener("complete",__loadToLocalComplete);
         this.llloader.unload();
         this.llloader = null;
         this.onComplete = null;
         this.onFail = null;
      }
      
      public function get retryTimes() : uint
      {
         return _retryTimes;
      }
      
      public function set retryTimes(value:uint) : void
      {
         _retryTimes = value;
      }
      
      public function get urlloader() : URLLoader
      {
         return _urlloader;
      }
      
      public function set urlloader(value:URLLoader) : void
      {
         _urlloader = value;
      }
      
      public function get bytesTotal() : Number
      {
         return _bytesTotal;
      }
      
      public function set bytesTotal(value:Number) : void
      {
         _bytesTotal = value;
      }
      
      public function get bytesLoaded() : Number
      {
         return _bytesLoaded;
      }
      
      public function set bytesLoaded(value:Number) : void
      {
         _bytesLoaded = value;
      }
      
      public function get assetsType() : uint
      {
         return _assetsType;
      }
      
      public function set assetsType(value:uint) : void
      {
         _assetsType = value;
      }
   }
}
