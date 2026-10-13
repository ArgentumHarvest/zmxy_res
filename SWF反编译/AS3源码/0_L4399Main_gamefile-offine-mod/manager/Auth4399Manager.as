package manager
{
   import config.Config;
   import export.auth4399.Auth4399MainView;
   import export.auth4399.Auth4399No18Tips;
   import export.auth4399.Auth4399OrderView;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import my.MyEquipObj;
   
   public class Auth4399Manager
   {
      
      static var _instance:Auth4399Manager;
       
      
      private var gc:Config;
      
      public function Auth4399Manager()
      {
         super();
         gc = Config.getInstance();
      }
      
      public static function getInstance() : Auth4399Manager
      {
         if(!_instance)
         {
            _instance = new Auth4399Manager();
         }
         return _instance;
      }
      
      public function statusData(data:Object) : void
      {
         data = data;
         onError = function(e:Event):void
         {
            trace("玩家实名状态接口,出错:" + e);
         };
         var url:String = "https://save.api.4399.com/index.php?c=realname&ac=status&";
         var request:URLRequest = new URLRequest(url);
         request.method = "GET";
         var urlV:URLVariables = new URLVariables();
         urlV.uid = data;
         request.data = urlV;
         var urlLoader:URLLoader = new URLLoader();
         urlLoader.load(request);
         urlLoader.addEventListener("ioError",onError);
         urlLoader.addEventListener("securityError",onError);
         urlLoader.addEventListener("complete",backStatusData);
      }
      
      private function backStatusData(event:Event) : void
      {
         var data:* = null;
         var value:String = String((event.currentTarget as URLLoader).data);
         try
         {
            data = JSON.parse(value);
            if(data.success == 1)
            {
               gc.auth4399 = data;
            }
            else
            {
               gc.ts.setTxt("您尚未登录，请先登录");
               gc.stage.addChild(gc.ts);
            }
         }
         catch(err:Error)
         {
            trace(err,value,"不是json格式数据");
         }
      }
      
      public function getDemoData(data:Object) : void
      {
         data = data;
         onError = function(e:Event):void
         {
            trace("玩家实名状态接口,出错:" + e);
         };
         var url:String = "https://save.api.4399.com/index.php?c=realname&ac=suggest&";
         var request:URLRequest = new URLRequest(url);
         request.method = "GET";
         var urlV:URLVariables = new URLVariables();
         urlV.uid = data;
         request.data = urlV;
         var urlLoader:URLLoader = new URLLoader();
         urlLoader.load(request);
         urlLoader.addEventListener("ioError",onError);
         urlLoader.addEventListener("securityError",onError);
         urlLoader.addEventListener("complete",backSuggestData);
      }
      
      private function backSuggestData(event:Event) : void
      {
         var view:* = null;
         var data:* = null;
         var value:String = String((event.currentTarget as URLLoader).data);
         try
         {
            view = gc.stage.getChildByName("Auth4399OrderView") as Auth4399OrderView;
            data = JSON.parse(value);
            if(data.success == 1)
            {
               gc.suggestAuth.demoName = data.realname;
               gc.suggestAuth.demoCardId = data.idcard;
               if(view)
               {
                  view.setExampleVisible(true,data.realname,data.idcard);
               }
            }
            else if(view)
            {
               view.setExampleVisible(false,"","");
            }
         }
         catch(err:Error)
         {
            trace(err,value,"不是json格式数据");
         }
      }
      
      public function sumbitData(data:Object) : void
      {
         data = data;
         onError = function(e:Event):void
         {
            trace("玩家实名状态接口,出错:" + e);
         };
         var url:String = "https://save.api.4399.com/index.php?c=realname&ac=submit&";
         var request:URLRequest = new URLRequest(url);
         request.method = "POST";
         var urlV:URLVariables = new URLVariables();
         urlV.uid = data.uid;
         urlV.realname = data.realname;
         urlV.idcard = data.idcard;
         request.data = urlV;
         var urlLoader:URLLoader = new URLLoader();
         urlLoader.load(request);
         urlLoader.addEventListener("ioError",onError);
         urlLoader.addEventListener("securityError",onError);
         urlLoader.addEventListener("complete",backSumbitData);
      }
      
      private function backSumbitData(event:Event) : void
      {
         var data:* = null;
         var tips:* = null;
         var value:String = String((event.currentTarget as URLLoader).data);
         try
         {
            data = JSON.parse(value);
            if(data.success == 1)
            {
               gc.auth4399 = data;
            }
            else
            {
               tips = data.desc || "无效的身份证号";
               gc.ts.setTxt(tips);
               gc.stage.addChild(gc.ts);
            }
            this.auth4399SubmitSucc(data);
         }
         catch(err:Error)
         {
            trace(err,value,"不是json格式数据");
            gc.ts.setTxt("无效的身份信息");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function auth4399SubmitSucc(data:*) : void
      {
         var view:* = null;
         var view2:* = null;
         if(data.reconfirm == 1 && !gc.hasAutoTips)
         {
            gc.hasAutoTips = true;
            view = new Auth4399No18Tips();
            gc.stage.addChild(view);
         }
         else
         {
            view2 = new Auth4399MainView();
            gc.stage.addChild(view2);
         }
      }
      
      public function getPresent() : void
      {
         var gcxdyy1:* = null;
         var gcxdyy2:* = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy1 = gc.allEquip.findByName("ptnmwsz");
            gcxdyy1.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy1);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gcxdyy2 = gc.allEquip.findByName("fsqq");
            gcxdyy2.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy2);
            gc.putQhsInBackPack(gc.player1,"djyys",2);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy1 = gc.allEquip.findByName("ptnmwsz");
            gcxdyy1.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy1);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gcxdyy2 = gc.allEquip.findByName("fsqq");
            gcxdyy2.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy2);
            gc.putQhsInBackPack(gc.player2,"djyys",2);
         }
         gc.ts.setTxt("成功领取 4399忠实玩家X1，粉色气球X1，大经验药水X2，牛魔王时装X1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
   }
}
