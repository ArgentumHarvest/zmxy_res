package export.honor
{
   import config.Config;
   import event.CommonEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class AllianceSprite extends EventDispatcher
   {
      
      public static const BUY_ITEM_SUCCESS:String = "buy_item_success";
      
      public static const GET_MY_ALLIANCEINFO_COMPLETE:String = "get_my_allianceinfo_complete";
      
      public static const IOERROR:String = "ioerror";
      
      static var _instance:AllianceSprite;
       
      
      private var aif:AllianceInterface;
      
      private var gc:Config;
      
      public function AllianceSprite()
      {
         super();
         gc = Config.getInstance();
         this.aif = new AllianceInterface();
         this.aif.addEventListener(AllianceConfig.EVENT_GET_DATA,__getData,false,0,true);
         this.aif.addEventListener(AllianceConfig.EVENT_GET_FAIL,__getFail,false,0,true);
      }
      
      public static function getInstance() : AllianceSprite
      {
         if(!_instance)
         {
            _instance = new AllianceSprite();
         }
         return _instance;
      }
      
      public function getKey() : void
      {
         this.aif.getKey();
      }
      
      public function buyByType(type:uint) : void
      {
         this.aif.buyItemByType(type);
      }
      
      protected function __getFail(evt:Event) : void
      {
         this.dispatchEvent(new CommonEvent("ioerror"));
         gc.removedActionMask("renewalse");
      }
      
      private function __getData(evt:CommonEvent) : void
      {
         var groups:* = null;
         var strUser:* = null;
         var myGroup:* = null;
         strUser = null;
         var obj:Object = evt.data;
         var status:int = obj.status;
         var key:String = obj.key;
         if(key)
         {
            this.aif.key = key;
         }
         var newkey:String = obj.newkey;
         if(newkey)
         {
            this.aif.key = newkey;
         }
         var msg:String = obj.msg;
         var token:String = obj.token;
         var ucengterid:uint = obj.ucenterid;
         var score:int = obj.score;
         var api:String = obj.api;
         trace("=====status:" + status);
         trace("=====api:" + api);
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
            case AllianceConfig.KEY:
               this.aif.getMyAllianceInfo();
               break;
            case AllianceConfig.GET_MY_GROUP_INFO:
               groups = obj.data.groups as Array;
               trace("groups：" + groups);
               strUser = obj.data.user2;
               trace("strUser：" + strUser);
               myGroup = groups[0];
               trace("myGroup" + myGroup);
               gc.honorData.allianceLevel = myGroup["class"];
               gc.honorData.score = strUser.score;
               gc.honorData.isAbled = strUser.isable == "1";
               gc.honorData.jobName = strUser["class"];
               gc.honorData.groupId = myGroup.groupid;
               gc.honorData.honorName = myGroup.groupname;
               gc.honorData.nicheng = strUser.username;
               this.dispatchEvent(new CommonEvent("get_my_allianceinfo_complete"));
               break;
            case AllianceConfig.BUY_ITEM:
               strUser = obj.data.user2;
               gc.honorData.score = strUser.score;
               this.dispatchEvent(new CommonEvent("buy_item_success"));
               gc.removedActionMask("renewalse");
         }
      }
      
      public function destroy() : void
      {
         this.aif.destroy();
         _instance = null;
      }
   }
}
