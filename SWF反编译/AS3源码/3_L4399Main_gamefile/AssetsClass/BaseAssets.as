package AssetsClass
{
   import config.Config;
   import event.CommonEvent;
   import export.LoadingBar3;
   import flash.display.Sprite;
   import flash.events.Event;
   import loader.SuperLoader;
   
   public class BaseAssets extends Sprite
   {
       
      
      protected var assetsClass:Class;
      
      protected var content:Sprite;
      
      private var superLoader:SuperLoader;
      
      protected var gc:Config;
      
      private var paramsArray:Array;
      
      private var isDestroy:Boolean = false;
      
      private var maskSprite:LoadingBar3;
      
      public function BaseAssets(cl:Class, paramsArray:Array = null)
      {
         super();
         gc = Config.getInstance();
         this.superLoader = new SuperLoader();
         this.assetsClass = cl;
         this.paramsArray = paramsArray;
         this.maskSprite = new LoadingBar3();
         this.addEventListener("addedToStage",__added,false,0,true);
         this.addEventListener("removedFromStage",__removed,false,0,true);
      }
      
      protected function __userLogout(evt:Event) : void
      {
         this.destroy();
      }
      
      protected function __removed(evt:Event) : void
      {
         trace("========BaseAssets=========removed============");
         gc.eventManger.removeEventListener("logout",__userLogout);
         evt.stopPropagation();
      }
      
      protected function __added(evt:Event) : void
      {
         gc.eventManger.addEventListener("logout",__userLogout);
         evt.stopPropagation();
      }
      
      protected function loadAssets(arr:Array) : void
      {
         var url:* = null;
         var path:String = "";
         var sourceArr:Array = [];
         trace("本关卡需要加载的素材:" + arr);
         for each(var str in arr)
         {
            url = path + str;
            trace("url:" + url);
            if(!AssetsClassManager.getInstance().contains(url))
            {
               sourceArr.push(str);
            }
            else
            {
               trace("已经存在:" + url);
            }
         }
         trace("本关卡实际加载的素材:" + sourceArr);
         this.superLoader.load(path,arr);
         this.superLoader.addEventListener("load_complete",__loadComplete);
         this.superLoader.addEventListener("load_fail",__loadFail);
         this.addMask();
         this.addEventListener("enterFrame",__updateProgress);
      }
      
      protected function __loadFail(evt:CommonEvent) : void
      {
         this.destroy();
      }
      
      protected function __loadComplete(evt:CommonEvent) : void
      {
         this.superLoader.removeEventListener("load_complete",__loadComplete);
         this.superLoader.removeEventListener("load_fail",__loadFail);
         this.removeEventListener("enterFrame",__updateProgress);
         this.addContent();
      }
      
      private function __updateProgress(evt:Event) : void
      {
         this.maskSprite.currentFileIdx = this.superLoader.currentFileIndex + 1;
         this.maskSprite.totalFileIdx = this.superLoader.totalFilesLen;
         this.maskSprite.updatePregress(this.superLoader.getCurrentLoadedPercent());
      }
      
      protected function addContent() : void
      {
         if(this.paramsArray)
         {
            if(this.paramsArray.length == 1)
            {
               this.content = new this.assetsClass(this.paramsArray[0]);
            }
            else if(this.paramsArray.length == 2)
            {
               this.content = new this.assetsClass(this.paramsArray[0],this.paramsArray[1]);
            }
            else if(this.paramsArray.length == 3)
            {
               this.content = new this.assetsClass(this.paramsArray[0],this.paramsArray[1],this.paramsArray[2]);
            }
            else if(this.paramsArray.length == 4)
            {
               this.content = new this.assetsClass(this.paramsArray[0],this.paramsArray[1],this.paramsArray[2],this.paramsArray[3]);
            }
         }
         else
         {
            this.content = new this.assetsClass();
         }
         this.addChild(this.content);
         this.content.addEventListener("removedFromStage",__contentRemoved);
         this.removeMask();
      }
      
      protected function __contentRemoved(evt:Event) : void
      {
         if(this.content)
         {
            this.content.removeEventListener("removedFromStage",__contentRemoved);
         }
         this.destroy();
         evt.stopImmediatePropagation();
      }
      
      private function addMask() : void
      {
         this.addChild(this.maskSprite);
      }
      
      private function removeMask() : void
      {
         if(this.maskSprite && this.contains(this.maskSprite))
         {
            this.removeChild(this.maskSprite);
         }
      }
      
      public function destroy() : void
      {
         if(isDestroy)
         {
            return;
         }
         isDestroy = true;
         this.superLoader.removeEventListener("load_complete",__loadComplete);
         this.superLoader.removeEventListener("load_fail",__loadFail);
         this.removeEventListener("enterFrame",__updateProgress);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.removeMask();
         this.content = null;
         this.maskSprite = null;
         this.paramsArray = null;
         this.assetsClass = null;
      }
   }
}
