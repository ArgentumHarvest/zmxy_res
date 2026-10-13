package base
{
   import flash.external.ExternalInterface;
   
   public class BrowserInfo
   {
      
      private static var _info:String;
      
      private static var _name:String;
      
      private static var _version:String;
      
      private static var _host:String;
      
      private static var _href:String;
      
      private static var _pathname:String;
      
      private static var _webTitle:String;
      
      public static var is_msie:Boolean = false;
      
      public static var is_firefox:Boolean = false;
      
      public static var is_opera:Boolean = false;
      
      public static var is_chrome:Boolean = false;
      
      public static var is_safari:Boolean = false;
      
      public static var is_other:Boolean = false;
      
      public static const MSIE:String = "msie";
      
      public static const FIREFOX:String = "firefox";
      
      public static const OPERA:String = "opera";
      
      public static const CHROME:String = "chrome";
      
      public static const SAFARI:String = "safari";
      
      public static const OTHER:String = "other";
       
      
      public function BrowserInfo()
      {
         super();
      }
      
      public static function getBrowserInfo() : void
      {
         if(ExternalInterface.available)
         {
            _info = ExternalInterface.call("eval","navigator.userAgent");
            if(_info)
            {
               _getBrowserInfo();
            }
         }
      }
      
      public static function get name() : String
      {
         return _name;
      }
      
      public static function get version() : String
      {
         return _version;
      }
      
      public static function get info() : String
      {
         return _info || "";
      }
      
      public static function get host() : String
      {
         _host = _jsReturn("window.location.host");
         return _host;
      }
      
      public static function get href() : String
      {
         _href = _jsReturn("window.location.href");
         return _href;
      }
      
      public static function get pathname() : String
      {
         _pathname = _jsReturn("window.location.pathname");
         return _pathname;
      }
      
      public static function get webTitle() : String
      {
         return _jsReturn("document.title");
      }
      
      private static function _jsReturn(_jsAtrr:String) : String
      {
         if(ExternalInterface.available)
         {
            return ExternalInterface.call("eval",_jsAtrr);
         }
         return "";
      }
      
      private static function _getBrowserInfo() : void
      {
         var rMsie:RegExp = /.*(msie) ([\w.]+).*/;
         var rFirefox:RegExp = /.*(firefox)\/([\w.]+).*/;
         var rOpera:RegExp = /(opera).+version\/([\w.]+)/;
         var rChrome:RegExp = /.*(chrome)\/([\w.]+).*/;
         var rSafari:RegExp = /.*version\/([\w.]+).*(safari).*/;
         _execInfo([rMsie,rFirefox,rOpera,rChrome,rSafari]);
      }
      
      private static function _execInfo(_regArr:Array) : void
      {
         var _localMatchInfo:* = null;
         var _localInfo:String = _info.toLowerCase();
         for(var i in _regArr)
         {
            _localMatchInfo = _regArr[i].exec(_localInfo);
            if(_localMatchInfo != null)
            {
               if(_localMatchInfo[1] == "safari")
               {
                  _name = _localMatchInfo[2];
                  _version = _localMatchInfo[1];
               }
               else
               {
                  _name = _localMatchInfo[1];
                  _version = _localMatchInfo[2];
               }
               BrowserInfo["is_" + _name] = true;
            }
         }
         if(_name == null || _name == "")
         {
            _name = "other";
            BrowserInfo.is_other = true;
         }
      }
   }
}
