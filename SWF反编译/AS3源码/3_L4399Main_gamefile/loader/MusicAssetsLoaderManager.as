package loader
{
   import flash.events.Event;
   
   public class MusicAssetsLoaderManager
   {
      
      static var _instance:MusicAssetsLoaderManager;
       
      
      private var assetsVec:Vector.<SuperLoader>;
      
      public function MusicAssetsLoaderManager()
      {
         super();
         this.assetsVec = new Vector.<SuperLoader>();
      }
      
      public static function getInstance() : MusicAssetsLoaderManager
      {
         if(!_instance)
         {
            _instance = new MusicAssetsLoaderManager();
         }
         return _instance;
      }
      
      public function loadMusicArray(ary:Array) : void
      {
         for(var alen:uint = ary.length; alen-- > 0; )
         {
            this.addMusicLoad(ary[alen]);
         }
      }
      
      public function addMusicLoad(musicName:String, doWhenLoadComplete:Function = null) : void
      {
         var sl:* = null;
         for each(sl in assetsVec)
         {
            if(sl.containsAssetsName(musicName))
            {
               musicName = "";
               if(doWhenLoadComplete)
               {
                  sl.doWhenLoadCompleteVec.push(doWhenLoadComplete);
               }
            }
         }
         var needToLoadArray:Array = [];
         if(musicName != "")
         {
            needToLoadArray.push(musicName);
         }
         if(needToLoadArray.length > 0)
         {
            sl = new SuperLoader();
            if(doWhenLoadComplete)
            {
               sl.doWhenLoadCompleteVec.push(doWhenLoadComplete);
            }
            sl.addEventListener("load_complete",__loadComplete);
            sl.load("",needToLoadArray);
            this.assetsVec.push(sl);
         }
      }
      
      protected function __loadComplete(e:Event) : void
      {
         var sl:SuperLoader = e.target as SuperLoader;
         sl.removeEventListener("load_complete",__loadComplete);
         var idx:int = this.assetsVec.indexOf(sl);
         if(idx != -1)
         {
            this.assetsVec.splice(idx,1);
         }
      }
   }
}
