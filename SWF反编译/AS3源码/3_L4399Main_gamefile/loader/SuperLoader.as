package loader
{
   import event.CommonEvent;
   import flash.events.EventDispatcher;
   import my.ResourceControllor;
   
   public class SuperLoader extends EventDispatcher
   {
      
      public static const LOAD_COMPLETE:String = "load_complete";
      
      public static const LOAD_FAIL:String = "load_fail";
       
      
      private var _currentFileIndex:uint = 0;
      
      private var _totalFilesLen:uint = 0;
      
      private var singleLoader:SingleLoader;
      
      private var _doWhenLoadCompleteVec:Vector.<Function>;
      
      private var path:String;
      
      private var resArr:Array;
      
      public function SuperLoader()
      {
         super();
         this.doWhenLoadCompleteVec = new Vector.<Function>();
      }
      
      public function load(path:String, resArr:Array) : void
      {
         this.totalFilesLen = resArr.length;
         this.path = path;
         this.resArr = resArr;
         this.loadByIndex();
      }
      
      private function loadByIndex() : void
      {
         var url:* = null;
         trace("loadByIndex->index:" + this.currentFileIndex);
         if(this.currentFileIndex < this.totalFilesLen)
         {
            this.singleLoader = new SingleLoader();
            this.singleLoader.onComplete = loadNext;
            this.singleLoader.onFail = loadFail;
            url = this.path + this.resArr[this.currentFileIndex];
            this.singleLoader.load(url);
         }
         else
         {
            if(this._doWhenLoadCompleteVec.length > 0)
            {
               for each(var func in this._doWhenLoadCompleteVec)
               {
                  func();
               }
            }
            this.dispatchEvent(new CommonEvent("load_complete"));
            this.destroy();
         }
      }
      
      private function loadNext(sl:SingleLoader) : void
      {
         var key:String = this.path + this.resArr[this.currentFileIndex];
         if(sl.assetsType != 0)
         {
            ResourceControllor.getInstance().setData(key,sl.urlloader.data);
         }
         else
         {
            AssetsManager.getInstance().addAssetsName(key);
         }
         this.currentFileIndex++;
         this.loadByIndex();
      }
      
      private function loadFail() : void
      {
         this.dispatchEvent(new CommonEvent("load_fail"));
         trace("文件-->:" + this.resArr[this.currentFileIndex] + " 加载失败！");
      }
      
      public function getCurrentLoadedPercent() : uint
      {
         if(this.singleLoader)
         {
            if(this.singleLoader.bytesTotal > 0)
            {
               return int(this.singleLoader.bytesLoaded * 100 / this.singleLoader.bytesTotal);
            }
         }
         return 0;
      }
      
      public function containsAssetsName(name:String) : Boolean
      {
         return this.resArr.indexOf(name) != -1;
      }
      
      public function destroy() : void
      {
         this.resArr.length = 0;
         this.resArr = null;
         this.singleLoader = null;
         this._doWhenLoadCompleteVec.length = 0;
         this._doWhenLoadCompleteVec = null;
      }
      
      public function get totalFilesLen() : uint
      {
         return _totalFilesLen;
      }
      
      public function set totalFilesLen(value:uint) : void
      {
         _totalFilesLen = value;
      }
      
      public function get currentFileIndex() : uint
      {
         return _currentFileIndex;
      }
      
      public function set currentFileIndex(value:uint) : void
      {
         _currentFileIndex = value;
      }
      
      public function get doWhenLoadCompleteVec() : Vector.<Function>
      {
         return _doWhenLoadCompleteVec;
      }
      
      public function set doWhenLoadCompleteVec(value:Vector.<Function>) : void
      {
         _doWhenLoadCompleteVec = value;
      }
   }
}
