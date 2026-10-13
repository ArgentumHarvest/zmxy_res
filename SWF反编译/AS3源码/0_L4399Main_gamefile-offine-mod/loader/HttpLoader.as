package loader
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class HttpLoader
   {
       
      
      private var _loader:URLLoader;
      
      private var url:String = "";
      
      private var comFunc:Function;
      
      private var failFunc:Function;
      
      private var retryTimes:int = 5;
      
      public var isLoading:Boolean = false;
      
      public function HttpLoader()
      {
         super();
         _loader = new URLLoader();
         _loader.addEventListener("complete",__complete);
         _loader.addEventListener("ioError",_error);
         _loader.addEventListener("securityError",__sError);
      }
      
      protected function __sError(event:SecurityErrorEvent) : void
      {
         if(retryTimes > 0)
         {
            this.retry();
            retryTimes--;
         }
         else
         {
            this.onFail();
         }
      }
      
      protected function _error(event:IOErrorEvent) : void
      {
         if(retryTimes > 0)
         {
            this.retry();
            retryTimes--;
         }
         else
         {
            this.onFail();
         }
      }
      
      protected function __complete(event:Event) : void
      {
         if(this.comFunc != null)
         {
            this.comFunc(_loader.data);
         }
         this.isLoading = false;
      }
      
      protected function onFail() : void
      {
         if(this.failFunc != null)
         {
            this.failFunc();
         }
         this.isLoading = false;
      }
      
      public function load(url:String, comFunc:Function, failFunc:Function) : void
      {
         this.comFunc = comFunc;
         this.failFunc = failFunc;
         this.url = url;
         _loader.load(new URLRequest(this.url));
         this.isLoading = true;
      }
      
      private function retry() : void
      {
         _loader.load(new URLRequest(this.url));
      }
      
      public function destroy() : void
      {
         this.comFunc = null;
         this.failFunc = null;
      }
   }
}
