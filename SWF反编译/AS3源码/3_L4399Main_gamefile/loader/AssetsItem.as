package loader
{
   import flash.display.LoaderInfo;
   
   public class AssetsItem
   {
       
      
      private var _data;
      
      private var _type:uint;
      
      private var _loaderInfo:LoaderInfo;
      
      private var _url:String = "";
      
      public function AssetsItem()
      {
         super();
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      public function set data(value:*) : void
      {
         _data = value;
      }
      
      public function get type() : uint
      {
         return _type;
      }
      
      public function set type(value:uint) : void
      {
         _type = value;
      }
      
      public function get loaderInfo() : LoaderInfo
      {
         return _loaderInfo;
      }
      
      public function set loaderInfo(value:LoaderInfo) : void
      {
         _loaderInfo = value;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function set url(value:String) : void
      {
         _url = value;
      }
   }
}
