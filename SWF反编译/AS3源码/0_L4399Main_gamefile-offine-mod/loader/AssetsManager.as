package loader
{
   public class AssetsManager
   {
      
      static var _ins:AssetsManager;
       
      
      private var assetsArray:Array;
      
      private var assetsVec:Vector.<AssetsItem>;
      
      public function AssetsManager()
      {
         assetsArray = [];
         super();
         assetsVec = new Vector.<AssetsItem>();
      }
      
      public static function getInstance() : AssetsManager
      {
         if(!_ins)
         {
            _ins = new AssetsManager();
         }
         return _ins;
      }
      
      public function addAssets(assetsItem:AssetsItem) : void
      {
         this.assetsVec.push(assetsItem);
      }
      
      public function getAssets(url:String) : AssetsItem
      {
         for each(var ai in this.assetsVec)
         {
            if(ai.url == url)
            {
               return ai;
            }
         }
         return null;
      }
      
      public function addAssetsName(name:String) : void
      {
         if(this.assetsArray.indexOf(name) == -1)
         {
            this.assetsArray.push(name);
         }
         trace("所有素材:" + this.assetsArray);
      }
      
      public function contains(name:String) : Boolean
      {
         return this.assetsArray.indexOf(name) != -1;
      }
   }
}
