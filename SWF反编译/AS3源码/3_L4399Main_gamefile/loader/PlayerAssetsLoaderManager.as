package loader
{
   import config.Config;
   import flash.events.Event;
   
   public class PlayerAssetsLoaderManager
   {
      
      static var _ins:PlayerAssetsLoaderManager;
       
      
      private var assetsVec:Vector.<SuperLoader>;
      
      private var gc:Config;
      
      public function PlayerAssetsLoaderManager()
      {
         super();
         gc = Config.getInstance();
         this.assetsVec = new Vector.<SuperLoader>();
      }
      
      public static function getInstance() : PlayerAssetsLoaderManager
      {
         if(!_ins)
         {
            _ins = new PlayerAssetsLoaderManager();
         }
         return _ins;
      }
      
      public function add(equipName:String, weaponName:String) : void
      {
         var sl:* = null;
         for each(sl in assetsVec)
         {
            if(sl.containsAssetsName(equipName))
            {
               equipName = "";
            }
            if(!sl.containsAssetsName(weaponName))
            {
               weaponName = "";
            }
         }
         var needToLoadArray:Array = [];
         if(equipName != "")
         {
            needToLoadArray.push(equipName);
         }
         if(weaponName != "")
         {
            needToLoadArray.push(weaponName);
         }
         if(needToLoadArray.length > 0)
         {
            sl = new SuperLoader();
            sl.addEventListener("load_complete",__loadComplete);
            sl.load("",needToLoadArray);
            this.assetsVec.push(sl);
         }
      }
      
      public function addSingle(name:String, doWhenLoadComplete:Function = null) : void
      {
         var sl:* = null;
         if(!gc.isHideDebug || !GMain.serviceHold)
         {
            name = name.toLowerCase();
            if(name.indexOf("role1") != -1)
            {
               name = "Assets/roles/Role1_Equipment/" + name;
            }
            else if(name.indexOf("role2") != -1)
            {
               name = "Assets/roles/Role2_Equipment/" + name;
            }
            else if(name.indexOf("role3") != -1)
            {
               name = "Assets/roles/Role3_Equipment/" + name;
            }
            else if(name.indexOf("role4") != -1)
            {
               name = "Assets/roles/Role4_Equipment/" + name;
            }
         }
         trace("addSingle-->name:" + name);
         for each(sl in assetsVec)
         {
            if(sl.containsAssetsName(name))
            {
               name = "";
               if(doWhenLoadComplete)
               {
                  sl.doWhenLoadCompleteVec.push(doWhenLoadComplete);
               }
            }
         }
         var needToLoadArray:Array = [];
         if(name != "")
         {
            needToLoadArray.push(name);
         }
         if(needToLoadArray.length > 0)
         {
            sl = new SuperLoader();
            if(doWhenLoadComplete)
            {
               sl.doWhenLoadCompleteVec.push(doWhenLoadComplete);
            }
            sl.addEventListener("load_complete",__loadComplete);
            sl.addEventListener("load_fail",__loadFail);
            sl.load("",needToLoadArray);
            this.assetsVec.push(sl);
         }
      }
      
      protected function __loadFail(evt:Event) : void
      {
         var sl:SuperLoader = evt.target as SuperLoader;
         sl.removeEventListener("load_complete",__loadComplete);
         sl.removeEventListener("load_fail",__loadFail);
         var idx:int = this.assetsVec.indexOf(sl);
         if(idx != -1)
         {
            this.assetsVec.splice(idx,1);
         }
      }
      
      protected function __loadComplete(evt:Event) : void
      {
         var sl:SuperLoader = evt.target as SuperLoader;
         sl.removeEventListener("load_complete",__loadComplete);
         sl.removeEventListener("load_fail",__loadFail);
         var idx:int = this.assetsVec.indexOf(sl);
         if(idx != -1)
         {
            this.assetsVec.splice(idx,1);
         }
      }
   }
}
