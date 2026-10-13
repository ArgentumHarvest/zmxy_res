package export.honor
{
   import config.Config;
   import event.CommonEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class AllianceInterface extends EventDispatcher
   {
       
      
      private var _key:String = "";
      
      private var salt:String = "4399apiabc";
      
      private var lastUrl:String = "";
      
      private var retryTimes:uint = 3;
      
      private var urlloader:URLLoader;
      
      private var gc:Config;
      
      public function AllianceInterface()
      {
         urlloader = new URLLoader();
         super();
         gc = Config.getInstance();
         urlloader.addEventListener("complete",__loadComplete);
         urlloader.addEventListener("ioError",__ioError);
         urlloader.addEventListener("securityError",__securityError);
      }
      
      protected function __securityError(evt:SecurityErrorEvent) : void
      {
         this.dispatchEvent(new CommonEvent(AllianceConfig.EVENT_GET_FAIL));
      }
      
      protected function __ioError(evt:IOErrorEvent) : void
      {
         if(this.retryTimes > 0)
         {
            this.sendUrl(this.lastUrl);
            this.retryTimes--;
         }
         else
         {
            this.dispatchEvent(new CommonEvent(AllianceConfig.EVENT_GET_FAIL));
         }
      }
      
      public function getKey() : void
      {
         var url:String = this.createUrl(AllianceConfig.KEY,gc.dataObjectInstance.loginUid,0,0,0);
         this.sendUrl(url);
      }
      
      public function joinAlliance(allianceId:uint) : void
      {
         var url:String = this.createUrl(AllianceConfig.JOIN_ALLIANCE,gc.dataObjectInstance.loginUid,0,allianceId,0);
         this.sendUrl(url);
      }
      
      public function unjoinAlliance() : void
      {
         var url:String = this.createUrl(AllianceConfig.UNJOIN_ALLIANCE,gc.dataObjectInstance.loginUid,0,0,0);
         this.sendUrl(url);
      }
      
      public function getTop10AllianceInfo() : void
      {
         var url:String = this.createUrl(AllianceConfig.TOP10GROUPS,gc.dataObjectInstance.loginUid,0,0,0);
         this.sendUrl(url);
      }
      
      public function getAllianceInfoByGroupId(gid:int) : void
      {
         var url:String = this.createUrl(AllianceConfig.GET_GROUP_INFO_BY_GROUPID,gc.dataObjectInstance.loginUid,0,gid,0);
         this.sendUrl(url);
      }
      
      public function getMyAllianceInfo() : void
      {
         var url:String = this.createUrl(AllianceConfig.GET_MY_GROUP_INFO,gc.dataObjectInstance.loginUid,0,0,0);
         this.sendUrl(url);
      }
      
      public function addScore(score:int) : void
      {
         var url:String = this.createUrl(AllianceConfig.ADD_SCORE,gc.dataObjectInstance.loginUid,0,0,score);
         this.sendUrl(url);
      }
      
      private function __loadComplete(evt:Event) : void
      {
         var obj:* = null;
         try
         {
            trace("evt.data:" + urlloader.data);
            obj = JSON.parse(urlloader.data);
            this.dispatchEvent(new CommonEvent(AllianceConfig.EVENT_GET_DATA,obj));
         }
         catch(e:*)
         {
         }
      }
      
      public function buyItemByType(type:uint) : void
      {
         var url:String = this.createUrl(AllianceConfig.BUY_ITEM,gc.dataObjectInstance.loginUid,0,0,0,type);
         this.sendUrl(url);
      }
      
      private function sendUrl(url:String) : void
      {
         trace("send->url:" + url);
         if(url == "")
         {
            return;
         }
         this.lastUrl = url;
         urlloader.load(new URLRequest(url));
      }
      
      private function createUrl(apiName:String, ucenterid1:uint, ucenterid2:uint, groupid:uint, score:int, gift:uint = 0) : String
      {
         return "";
      }
      
      public function destroy() : void
      {
         urlloader.removeEventListener("complete",__loadComplete);
         urlloader.removeEventListener("ioError",__ioError);
         urlloader.removeEventListener("securityError",__securityError);
         urlloader = null;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function set key(value:String) : void
      {
         _key = value;
      }
   }
}
