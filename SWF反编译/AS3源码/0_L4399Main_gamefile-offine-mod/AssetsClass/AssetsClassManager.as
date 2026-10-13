package AssetsClass
{
   public class AssetsClassManager
   {
      
      static var _ins:AssetsClassManager;
       
      
      private var assetsArray:Array;
      
      public function AssetsClassManager()
      {
         assetsArray = [];
         super();
      }
      
      public static function getInstance() : AssetsClassManager
      {
         if(!_ins)
         {
            _ins = new AssetsClassManager();
         }
         return _ins;
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
