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
   import my.Singleton;
   
   public class AllianceSecondInterface extends EventDispatcher
   {
       
      
      private var _key:String = "";
      
      private var salt:String = "4399apiabc";
      
      private var lastUrl:String = "";
      
      private var retryTimes:uint = 3;
      
      private var urlloader:URLLoader;
      
      private var gc:Config;
      
      private var uid:int;
      
      public var honorData:AllianceData;
      
      public function AllianceSecondInterface()
      {
         urlloader = new URLLoader();
         super();
         gc = Config.getInstance();
         urlloader.addEventListener("complete",__loadComplete);
         urlloader.addEventListener("ioError",__ioError);
         urlloader.addEventListener("securityError",__securityError);
      }
      
      public static function getIns() : AllianceSecondInterface
      {
         return Singleton.getIns(AllianceSecondInterface);
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
      
      public function getKey(uid:int) : void
      {
         this.uid = uid;
         var url:String = this.createUrl(AllianceConfig.KEY,this.uid,0,0,0);
         this.sendUrl(url);
      }
      
      public function getMyAllianceInfo() : void
      {
         var url:String = this.createUrl(AllianceConfig.GET_MY_GROUP_INFO,this.uid,0,0,0);
         this.sendUrl(url);
      }
      
      private function __loadComplete(evt:Event) : void
      {
         var groups:* = null;
         var strUser:* = null;
         var myGroup:* = null;
         trace("evt.data:" + urlloader.data);
         var obj:Object = JSON.parse(urlloader.data);
         var status:int = obj.status;
         var key:String = obj.key;
         if(key)
         {
            this.key = key;
         }
         var newkey:String = obj.newkey;
         if(newkey)
         {
            this.key = newkey;
         }
         var msg:String = obj.msg;
         var token:String = obj.token;
         var ucengterid:uint = obj.ucenterid;
         var score:int = obj.score;
         var api:String = obj.api;
         if(status < 100)
         {
            gc.removedActionMask("renewalse");
            switch(status)
            {
               case 1:
                  return;
               case 94:
                  return;
               case 5:
               case 80:
                  break;
               case 4:
                  break;
               default:
                  gc.ts.setTxt("系统错误:" + status);
                  gc.stage.addChild(gc.ts);
                  return;
            }
            gc.ts.setTxt("兑换失败(" + status + ")");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(api == "null" || !api)
         {
            gc.ts.setTxt("无效API");
            gc.stage.addChild(gc.ts);
            gc.removedActionMask("renewalse");
            return;
         }
         switch(api)
         {
            case AllianceConfig.GET_MY_GROUP_INFO:
               groups = obj.data.groups as Array;
               strUser = obj.data.user2;
               myGroup = groups[0];
               this.honorData = new AllianceData();
               this.honorData.jobName = strUser["class"];
               this.honorData.honorName = myGroup.groupname;
               this.honorData.groupId = myGroup.groupid;
               break;
            case AllianceConfig.KEY:
               this.getMyAllianceInfo();
         }
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
