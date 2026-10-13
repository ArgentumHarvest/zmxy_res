package my
{
   import flash.utils.Dictionary;
   
   public class ResourceControllor
   {
      
      private static var _instance:ResourceControllor;
       
      
      private var data:Dictionary;
      
      public function ResourceControllor()
      {
         super();
         data = new Dictionary();
      }
      
      public static function getInstance() : ResourceControllor
      {
         if(!_instance)
         {
            _instance = new ResourceControllor();
         }
         return _instance;
      }
      
      public function setData(key:String, value:*) : void
      {
         this.data[key] = value;
      }
      
      public function getData(key:String) : *
      {
         if(this.data[key] && this.data[key] != undefined)
         {
            return this.data[key];
         }
         throw new Error("找不到素材资源->:" + key);
      }
   }
}
