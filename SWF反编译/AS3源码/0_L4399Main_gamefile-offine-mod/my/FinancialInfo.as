package my
{
   import base.BrowserInfo;
   import config.Config;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class FinancialInfo
   {
      
      private static var tempObject:Object;
      
      private static var sendTimes:int = 3;
      
      private static var key:String = "342sg6sfg46fghrt864rh4";
       
      
      private var gc:Config;
      
      public function FinancialInfo()
      {
         super();
         gc = Config.getInstance();
      }
      
      public static function sendInfoToFinancialServer(uid:Number, list:Array, timeStamp:uint, _money:uint) : void
      {
         var f:* = 0;
         var obj:* = null;
         var gm:* = 0;
         var request:* = null;
         var urlLod:* = null;
         var request_new:* = null;
         var urlLod_new:* = null;
         var request_list:* = null;
         var urlLod_list:* = null;
         var request_limit:* = null;
         var urlLod_limit:* = null;
         var i:* = 0;
         var lastTime:int = 0;
         var time:int = 0;
         trace("sendInfoToFinancialServer-->list:" + list);
         var len:uint = list.length;
         var moeny:* = _money;
         var memo:String = "";
         for(i = uint(0); i < len; i++)
         {
            request = new URLRequest();
            urlLod = new URLLoader();
            urlLod.addEventListener("complete",loadComplete1,false,0,true);
            request_new = new URLRequest();
            urlLod_new = new URLLoader();
            urlLod_new.addEventListener("complete",loadComplete2,false,0,true);
            request_list = new URLRequest();
            urlLod_list = new URLLoader();
            urlLod_list.addEventListener("complete",loadComplete3,false,0,true);
            request_limit = new URLRequest();
            urlLod_limit = new URLLoader();
            urlLod_limit.addEventListener("complete",loadComplete3,false,0,true);
            f = uint(list[i][1] == 1 ? 1 : 2);
            obj = FinancialInfo.getSellObjectById(list[i][0].id,list[i][0].ename);
            if(obj)
            {
               trace("sendInfoToFinancialServer list --->" + list[i][0],list[i][1],list[i][2]);
               gm = uint(obj.pay * list[i][2]);
               lastTime = list[i][3] || 0;
               time = timeStamp;
               if(list[i][2] >= 100)
               {
                  return;
               }
               if(!(list[i][0].id == "" || list[i][0].id == 0))
               {
                  if(f == 1)
                  {
                     if(gm == 0)
                     {
                        continue;
                     }
                     request.url = "https://tjapi.rzxt.4399doc.com/zmweb_zmxy3_costPointTicket.gif?server_id=1&uid=" + uid + "&amount=" + gm + "&retain=" + moeny + "&item_tid=" + list[i][0].id + "&item_name=" + FinancialInfo.myUrlEncode(obj.cname,"utf-8") + "&num=" + list[i][2] + "&type=" + obj.prop_type + "&time=" + time;
                     urlLod.load(request);
                     FinancialInfo.allItemUseLog(uid,list[i][0].id,obj.cname,1,list[i][2],"购买获得",lastTime,"");
                     FinancialInfo.allPointTicketLog(uid,"购买消耗",0,gm,moeny);
                  }
                  else if(f == 2)
                  {
                     request_list.url = "https://tjapi.rzxt.4399doc.com/zmweb_zmxy3_itemUseLog.gif?server_id=1&uid=" + uid + "&item_tid=" + list[i][0].id + "&item_name=" + FinancialInfo.myUrlEncode(obj.cname,"utf-8") + "&item_num=" + list[i][2] + "&retain=" + lastTime + "&time=" + time;
                     urlLod_list.load(request_list);
                     FinancialInfo.allItemUseLog(uid,list[i][0].id,obj.cname,0,list[i][2],"使用消耗",lastTime,"");
                  }
                  if(f == 1 && obj.prop_type >= 1)
                  {
                     request_limit.url = "https://tjapi.rzxt.4399doc.com/zmweb_zmxy3_limitTimeServerLog.gif?server_id=1&uid=" + uid + "&item_tid=" + list[i][0].id + "&item_name=" + FinancialInfo.myUrlEncode(obj.cname,"utf-8") + "&item_num=" + list[i][2] + "&start_time=" + time + "&end_time=" + (time + 3600 * obj.prop_type * 24) + "&time=" + time;
                     urlLod_limit.load(request_limit);
                  }
               }
            }
         }
      }
      
      private static function loadComplete1(evt:Event) : void
      {
         trace("旧版日志请求完成！" + (evt.currentTarget as URLLoader).data);
      }
      
      private static function loadComplete2(evt:Event) : void
      {
         trace("新版日志请求完成！" + (evt.currentTarget as URLLoader).data);
      }
      
      private static function loadComplete3(evt:Event) : void
      {
         trace("新版道具清单请求完成！" + (evt.currentTarget as URLLoader).data);
      }
      
      public static function myUrlEncode(str:String, code:String) : String
      {
         return encodeURI(str);
      }
      
      public static function allPointTicketLog(uid:Number, reason:String, type:int, change:int, retaingm:int) : void
      {
         var request:URLRequest = new URLRequest();
         var urlLoder:URLLoader = new URLLoader();
         urlLoder.addEventListener("complete",createSaveDataComplete,false,0,true);
         var time:int = Math.floor(new Date().time / 1000);
         request.url = "https://tjapi.rzxt.4399doc.com/zmweb_zmxy3_allPointTicketLog.gif?uid=" + uid + "&time=" + time + "&server_id=1" + "&type=" + type + "&kind=1" + "&change=" + change + "&retain=" + retaingm + "&reason=" + FinancialInfo.myUrlEncode(reason,"utf-8") + "&param=";
         urlLoder.load(request);
      }
      
      public static function allItemUseLog(uid:Number, item_tid:String, item_name:String, type:int, change:int, reason:String, retaingm:int, param:String) : void
      {
         var request:URLRequest = new URLRequest();
         var urlLoder:URLLoader = new URLLoader();
         urlLoder.addEventListener("complete",createSaveDataComplete,false,0,true);
         var time:int = Math.floor(new Date().time / 1000);
         request.url = "https://tjapi.rzxt.4399doc.com/zmweb_zmxy3_allItemUseLog.gif?uid=" + uid + "&time=" + time + "&server_id=1" + "&item_tid=" + item_tid + "&item_name=" + FinancialInfo.myUrlEncode(item_name,"utf-8") + "&type=" + type + "&change=" + change + "&reason=" + FinancialInfo.myUrlEncode(reason,"utf-8") + "&param=" + param + "&retain=" + retaingm;
         urlLoder.load(request);
      }
      
      public static function createSaveData(uid:Number) : void
      {
         if(uid == 0)
         {
            return;
         }
         var request:URLRequest = new URLRequest();
         var urlLoder:URLLoader = new URLLoader();
         urlLoder.addEventListener("complete",createSaveDataComplete,false,0,true);
         var time:int = Math.floor(new Date().time / 1000);
         request.url = "https://tjapi.rzxt.4399doc.com/zmweb_zmxy3_createSaveData.gif?uid=" + uid + "&time=" + time + "&ip=" + "&server_id=1";
         urlLoder.load(request);
      }
      
      private static function createSaveDataComplete(evt:Event) : void
      {
         trace("创建存档调用完成！" + (evt.currentTarget as URLLoader).data);
      }
      
      public static function loginAndOut(uid:Number, operate:int) : void
      {
         if(uid == 0)
         {
            return;
         }
         var request:URLRequest = new URLRequest();
         var urlLoder:URLLoader = new URLLoader();
         urlLoder.addEventListener("complete",logoutComplete,false,0,true);
         var time:int = Math.floor(new Date().time / 1000);
         request.url = "https://tjapi.rzxt.4399doc.com/zmweb_zmxy3_loginAndOut.gif?uid=" + uid + "&time=" + time + "&operate=" + operate + "&ip=" + "&server_id=1";
         urlLoder.load(request);
      }
      
      private static function logoutComplete(evt:Event) : void
      {
         trace("登录登出调用完成！" + (evt.currentTarget as URLLoader).data);
      }
      
      public static function loginNew(uid:Number) : void
      {
         if(uid == 0)
         {
            return;
         }
         var request:URLRequest = new URLRequest();
         var urlLoder:URLLoader = new URLLoader();
         urlLoder.addEventListener("complete",loginNewComplete,false,0,true);
         request.url = "https://tjapi.rzxt.4399doc.com/zmweb_zm_uaLogin.gif?uid=" + uid + "&gameId=3" + "&ua=" + BrowserInfo.info;
         urlLoder.load(request);
      }
      
      private static function loginNewComplete(evt:Event) : void
      {
         trace("登录调用完成！" + (evt.currentTarget as URLLoader).data);
      }
      
      public static function heartBeat(uid:Number) : void
      {
         if(uid == 0)
         {
            return;
         }
         var request:URLRequest = new URLRequest();
         var urlLoder:URLLoader = new URLLoader();
         urlLoder.addEventListener("complete",heartBeatComplete,false,0,true);
         var time:int = Math.floor(new Date().time / 1000);
         request.url = "https://tjapi.rzxt.4399doc.com/zmweb_zmxy3_heartBeat.gif?uid=" + uid + "&time=" + time + "&server_id=1";
         urlLoder.load(request);
      }
      
      private static function heartBeatComplete(evt:Event) : void
      {
         trace("心跳调用完成！" + (evt.currentTarget as URLLoader).data);
      }
      
      public static function getItemIdByName(name:String, kind:uint = 0) : *
      {
         if(name == "wpqhs1")
         {
            return {
               "id":10000 + kind,
               "ename":name
            };
         }
         if(name == "wpqhs2")
         {
            return {
               "id":10010 + kind,
               "ename":name
            };
         }
         if(name == "wpqhs3")
         {
            return {
               "id":10020 + kind,
               "ename":name
            };
         }
         if(name == "wpqhs4")
         {
            return {
               "id":10030 + kind,
               "ename":name
            };
         }
         if(name == "sms2")
         {
            return {
               "id":10040 + kind,
               "ename":name
            };
         }
         if(name == "sms3")
         {
            return {
               "id":10050 + kind,
               "ename":name
            };
         }
         if(name == "mfs2")
         {
            return {
               "id":10060 + kind,
               "ename":name
            };
         }
         if(name == "mfs3")
         {
            return {
               "id":10070 + kind,
               "ename":name
            };
         }
         if(name == "gjs2")
         {
            return {
               "id":10080 + kind,
               "ename":name
            };
         }
         if(name == "gjs3")
         {
            return {
               "id":10090 + kind,
               "ename":name
            };
         }
         if(name == "fys2")
         {
            return {
               "id":10100 + kind,
               "ename":name
            };
         }
         if(name == "fys3")
         {
            return {
               "id":10110 + kind,
               "ename":name
            };
         }
         if(name == "wpxyf")
         {
            return {
               "id":10120,
               "ename":name
            };
         }
         if(name == "wpbdf")
         {
            return {
               "id":10130,
               "ename":name
            };
         }
         if(name == "wptlz")
         {
            return {
               "id":10140 + kind,
               "ename":name
            };
         }
         if(name == "wpllz")
         {
            return {
               "id":10150 + kind,
               "ename":name
            };
         }
         if(name == "wphlz")
         {
            return {
               "id":10160 + kind,
               "ename":name
            };
         }
         if(name == "wpflz")
         {
            return {
               "id":10170 + kind,
               "ename":name
            };
         }
         if(name == "wpslz")
         {
            return {
               "id":10180 + kind,
               "ename":name
            };
         }
         if(name == "lhys")
         {
            return {
               "id":10190,
               "ename":name
            };
         }
         if(name == "jyd3")
         {
            return {
               "id":10200,
               "ename":name
            };
         }
         if(name == "djyys")
         {
            return {
               "id":10210,
               "ename":name
            };
         }
         if(name == "css_2")
         {
            return {
               "id":10220,
               "ename":name
            };
         }
         if(name == "mpyj")
         {
            return {
               "id":10230 + kind,
               "ename":name
            };
         }
         if(name == "css12")
         {
            return {
               "id":10240,
               "ename":name
            };
         }
         if(name == "css18")
         {
            return {
               "id":10250,
               "ename":name
            };
         }
         if(name == "sbjyd")
         {
            return {
               "id":10260,
               "ename":name
            };
         }
         if(name == "jyys")
         {
            return {
               "id":10270,
               "ename":name
            };
         }
         if(name == "wpcsd")
         {
            return {
               "id":10280,
               "ename":name
            };
         }
         if(name == "wphhd")
         {
            return {
               "id":10290,
               "ename":name
            };
         }
         if(name == "cwzzxld")
         {
            return {
               "id":10300,
               "ename":name
            };
         }
         if(name == "cwjnxld")
         {
            return {
               "id":10310,
               "ename":name
            };
         }
         if(name == "ptttzssz")
         {
            return {
               "id":10320,
               "ename":name
            };
         }
         if(name == "ptnmwsz")
         {
            return {
               "id":10330,
               "ename":name
            };
         }
         if(name == "ptzlwsz")
         {
            return {
               "id":10340,
               "ename":name
            };
         }
         if(name == "xns1")
         {
            return {
               "id":10890,
               "ename":name
            };
         }
         if(name == "kly3")
         {
            return {
               "id":10900,
               "ename":name
            };
         }
         if(name == "dlhys")
         {
            return {
               "id":10910,
               "ename":name
            };
         }
         if(name == "cdjyys")
         {
            return {
               "id":10920,
               "ename":name
            };
         }
         if(name == "xns1")
         {
            return {
               "id":10930,
               "ename":name
            };
         }
         if(name == "wpsh_1")
         {
            return {
               "id":10940,
               "ename":name
            };
         }
         if(name == "wpsh_2")
         {
            return {
               "id":10950,
               "ename":name
            };
         }
         if(name == "wpsh_3")
         {
            return {
               "id":10960,
               "ename":name
            };
         }
         if(name == "nianjhdd")
         {
            return {
               "id":10980,
               "ename":name
            };
         }
         if(name == "xnhdl")
         {
            return {
               "id":10990,
               "ename":name
            };
         }
         if(name == "wpst_4")
         {
            return {
               "id":11000,
               "ename":name
            };
         }
         if(name == "wpst_5")
         {
            return {
               "id":11010,
               "ename":name
            };
         }
         if(name == "hmzjns3")
         {
            return {
               "id":11020,
               "ename":name
            };
         }
         if(name == "hyjjjns3")
         {
            return {
               "id":11030,
               "ename":name
            };
         }
         if(name == "smbjns3")
         {
            return {
               "id":11040,
               "ename":name
            };
         }
         if(name == "jhsjjns3")
         {
            return {
               "id":11050,
               "ename":name
            };
         }
         if(name == "tmcjns3")
         {
            return {
               "id":11060,
               "ename":name
            };
         }
         if(name == "syzqjns3")
         {
            return {
               "id":11070,
               "ename":name
            };
         }
         if(name == "mmwjns3")
         {
            return {
               "id":11080,
               "ename":name
            };
         }
         if(name == "mdsjns3")
         {
            return {
               "id":11090,
               "ename":name
            };
         }
         if(name == "lxzhs")
         {
            return {
               "id":11100,
               "ename":name
            };
         }
         if(name == "sxzhs")
         {
            return {
               "id":11110,
               "ename":name
            };
         }
         if(name == "ptzqsz")
         {
            return {
               "id":11120,
               "ename":name
            };
         }
         if(name == "_ssggjtg")
         {
            return {
               "id":11130,
               "ename":name
            };
         }
         if(name == "sz")
         {
            return {
               "id":10810,
               "ename":name
            };
         }
         if(name == "zz")
         {
            return {
               "id":10820,
               "ename":name
            };
         }
         if(name == "jbc")
         {
            return {
               "id":10830,
               "ename":name
            };
         }
         if(name == "szj")
         {
            return {
               "id":10840,
               "ename":name
            };
         }
         if(name == "ml")
         {
            return {
               "id":10850,
               "ename":name
            };
         }
         if(name == "gz")
         {
            return {
               "id":10860,
               "ename":name
            };
         }
         if(name == "bmd")
         {
            return {
               "id":10870,
               "ename":name
            };
         }
         if(name == "yp")
         {
            return {
               "id":10880,
               "ename":name
            };
         }
         return {
            "id":0,
            "ename":name
         };
      }
      
      public static function getSellObjectById(_id:uint, _itemName:String = "") : Object
      {
         switch(_id)
         {
            case 10000:
            case 10001:
               return {
                  "cname":"1级强化石",
                  "name":"wpqhs1",
                  "pay":29,
                  "prop_type":0
               };
            case 10010:
            case 10011:
               return {
                  "cname":"2级强化石",
                  "name":"wpqhs2",
                  "pay":79,
                  "prop_type":0
               };
            case 10020:
            case 10021:
               return {
                  "cname":"3级强化石",
                  "name":"wpqhs3",
                  "pay":229,
                  "prop_type":0
               };
            case 10030:
            case 10031:
               return {
                  "cname":"4级强化石",
                  "name":"wpqhs4",
                  "pay":679,
                  "prop_type":0
               };
            case 10040:
            case 10041:
               return {
                  "cname":"2级生命石",
                  "name":"sms2",
                  "pay":69,
                  "prop_type":0
               };
            case 10050:
            case 10051:
               return {
                  "cname":"3级生命石",
                  "name":"sms3",
                  "pay":199,
                  "prop_type":0
               };
            case 10060:
            case 10061:
               return {
                  "cname":"2级魔法石",
                  "name":"mfs2",
                  "pay":49,
                  "prop_type":0
               };
            case 10070:
            case 10071:
               return {
                  "cname":"3级魔法石",
                  "name":"mfs3",
                  "pay":129,
                  "prop_type":0
               };
            case 10080:
            case 10081:
               return {
                  "cname":"2级攻击石",
                  "name":"gjs2",
                  "pay":89,
                  "prop_type":0
               };
            case 10090:
            case 10091:
               return {
                  "cname":"3级攻击石",
                  "name":"gjs3",
                  "pay":259,
                  "prop_type":0
               };
            case 10100:
            case 10101:
               return {
                  "cname":"2级防御石",
                  "name":"fys2",
                  "pay":39,
                  "prop_type":0
               };
            case 10110:
            case 10111:
               return {
                  "cname":"3级防御石",
                  "name":"fys3",
                  "pay":109,
                  "prop_type":0
               };
            case 10120:
               return {
                  "cname":"幸运符",
                  "name":"wpxyf",
                  "pay":229,
                  "prop_type":0
               };
            case 10130:
               return {
                  "cname":"神恩符",
                  "name":"wpbdf",
                  "pay":489,
                  "prop_type":0
               };
            case 10140:
            case 10141:
               return {
                  "cname":"土灵珠",
                  "name":"wptlz",
                  "pay":279,
                  "prop_type":0
               };
            case 10150:
               break;
            case 10151:
               break;
            case 10160:
            case 10161:
               return {
                  "cname":"火灵珠",
                  "name":"wphlz",
                  "pay":309,
                  "prop_type":0
               };
            case 10170:
            case 10171:
               return {
                  "cname":"风灵珠",
                  "name":"wpflz",
                  "pay":319,
                  "prop_type":0
               };
            case 10180:
            case 10181:
               return {
                  "cname":"水灵珠",
                  "name":"wpslz",
                  "pay":329,
                  "prop_type":0
               };
            case 10190:
               return {
                  "cname":"灵魂药水",
                  "name":"lhys",
                  "pay":19,
                  "prop_type":0
               };
            case 10200:
               return {
                  "cname":"三倍经验丹",
                  "name":"jyd3",
                  "pay":669,
                  "prop_type":0
               };
            case 10210:
               return {
                  "cname":"大经验药水",
                  "name":"djyys",
                  "pay":999,
                  "prop_type":0
               };
            case 10220:
               return {
                  "cname":"地下2层传送石",
                  "name":"css_2",
                  "pay":149,
                  "prop_type":0
               };
            case 10230:
            case 10231:
               return {
                  "cname":"孟婆药剂",
                  "name":"mpyj",
                  "pay":479,
                  "prop_type":0
               };
            case 10240:
               return {
                  "cname":"12层传送石",
                  "name":"css12",
                  "pay":99,
                  "prop_type":0
               };
            case 10250:
               return {
                  "cname":"18层传送石",
                  "name":"css18",
                  "pay":189,
                  "prop_type":0
               };
            case 10260:
               return {
                  "cname":"双倍经验丹",
                  "name":"sbjyd",
                  "pay":339,
                  "prop_type":0
               };
            case 10270:
               return {
                  "cname":"经验药水",
                  "name":"jyys",
                  "pay":139,
                  "prop_type":0
               };
            case 10280:
               return {
                  "cname":"长生丹",
                  "name":"wpcsd",
                  "pay":179,
                  "prop_type":0
               };
            case 10290:
               return {
                  "cname":"还魂丹",
                  "name":"wphhd",
                  "pay":119,
                  "prop_type":0
               };
            case 10300:
               return {
                  "cname":"宠物属性洗练丹",
                  "name":"cwzzxld",
                  "pay":169,
                  "prop_type":0
               };
            case 10310:
               return {
                  "cname":"宠物技能洗练丹",
                  "name":"cwjnxld",
                  "pay":159,
                  "prop_type":0
               };
            case 10320:
               return {
                  "cname":"天庭战神装",
                  "name":"ptttzssz",
                  "pay":609,
                  "prop_type":30
               };
            case 10330:
               return {
                  "cname":"牛魔王装",
                  "name":"ptnmwsz",
                  "pay":449,
                  "prop_type":30
               };
            case 10340:
               return {
                  "cname":"转轮王装",
                  "name":"ptzlwsz",
                  "pay":599,
                  "prop_type":30
               };
            case 10350:
               return {
                  "cname":"续费30天时装",
                  "name":"",
                  "pay":500,
                  "prop_type":30
               };
            case 10360:
               return {
                  "cname":"续费7天时装",
                  "name":"",
                  "pay":100,
                  "prop_type":7
               };
            case 10370:
               return {
                  "cname":"神秘店铺全部开启",
                  "name":"",
                  "pay":50,
                  "prop_type":0
               };
            case 10380:
               return {
                  "cname":"神秘店铺增加次数",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10390:
               return {
                  "cname":"珍珠店铺增加次数",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10400:
               return {
                  "cname":"挑战三太子增加次数",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10410:
               return {
                  "cname":"挑战福禄寿福星高照",
                  "name":"",
                  "pay":300,
                  "prop_type":0
               };
            case 10420:
               return {
                  "cname":"修复苍龙戒",
                  "name":"",
                  "pay":300,
                  "prop_type":0
               };
            case 10430:
               return {
                  "cname":"回到过去增加次数",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10440:
               return {
                  "cname":"扩建土地",
                  "name":"",
                  "pay":200,
                  "prop_type":-1
               };
            case 10450:
               return {
                  "cname":"扩建土地",
                  "name":"",
                  "pay":400,
                  "prop_type":-1
               };
            case 10460:
               return {
                  "cname":"扩建土地",
                  "name":"",
                  "pay":600,
                  "prop_type":-1
               };
            case 10470:
               return {
                  "cname":"扩建土地",
                  "name":"",
                  "pay":1000,
                  "prop_type":-1
               };
            case 10480:
               return {
                  "cname":"扩建土地",
                  "name":"",
                  "pay":1400,
                  "prop_type":-1
               };
            case 10490:
               return {
                  "cname":"扩建土地",
                  "name":"",
                  "pay":1800,
                  "prop_type":-1
               };
            case 10500:
               return {
                  "cname":"扩建土地",
                  "name":"",
                  "pay":2400,
                  "prop_type":-1
               };
            case 10510:
               return {
                  "cname":"扩建土地",
                  "name":"",
                  "pay":3000,
                  "prop_type":-1
               };
            case 10520:
               return {
                  "cname":"土地公祝福加强回血",
                  "name":"",
                  "pay":50,
                  "prop_type":0
               };
            case 10530:
               return {
                  "cname":"升级种植作物",
                  "name":"",
                  "pay":20,
                  "prop_type":0
               };
            case 10540:
               return {
                  "cname":"升级种植作物",
                  "name":"",
                  "pay":50,
                  "prop_type":0
               };
            case 10550:
               return {
                  "cname":"升级种植作物",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10560:
               return {
                  "cname":"升级种植作物",
                  "name":"",
                  "pay":200,
                  "prop_type":0
               };
            case 10570:
               return {
                  "cname":"翻新土地",
                  "name":"",
                  "pay":400,
                  "prop_type":0
               };
            case 10580:
               return {
                  "cname":"潜力商店中级还童",
                  "name":"",
                  "pay":1000,
                  "prop_type":0
               };
            case 10590:
               return {
                  "cname":"潜力商店高级还童",
                  "name":"",
                  "pay":2000,
                  "prop_type":0
               };
            case 10600:
               return {
                  "cname":"药园挑战无限时间",
                  "name":"",
                  "pay":50,
                  "prop_type":0
               };
            case 10610:
               return {
                  "cname":"药园挑战再进一次",
                  "name":"",
                  "pay":150,
                  "prop_type":0
               };
            case 10620:
               return {
                  "cname":"三仙岛召永恒唤青龙剑",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10630:
               return {
                  "cname":"守卫昆仑山改运",
                  "name":"",
                  "pay":50,
                  "prop_type":0
               };
            case 10640:
               return {
                  "cname":"守卫昆仑山转移属性",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10650:
               return {
                  "cname":"珍珠店铺全部开启",
                  "name":"",
                  "pay":50,
                  "prop_type":0
               };
            case 10660:
               return {
                  "cname":"直接领悟主动技能",
                  "name":"",
                  "pay":300,
                  "prop_type":0
               };
            case 10670:
               return {
                  "cname":"扩充宠物仓库",
                  "name":"",
                  "pay":1000,
                  "prop_type":0
               };
            case 10680:
               return {
                  "cname":"VIP5时光之舟",
                  "name":"",
                  "pay":300,
                  "prop_type":0
               };
            case 10690:
               return {
                  "cname":"昆仑山再进一次挑战",
                  "name":"",
                  "pay":200,
                  "prop_type":0
               };
            case 10700:
               return {
                  "cname":"购买宠物强化点",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10710:
               return {
                  "cname":"照妖镜服务",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10720:
               return {
                  "cname":"增加挑战二十八星宿次数",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10730:
               return {
                  "cname":"鞭炮",
                  "name":"",
                  "pay":10,
                  "prop_type":0
               };
            case 10740:
               return {
                  "cname":"烟花",
                  "name":"",
                  "pay":15,
                  "prop_type":0
               };
            case 10750:
               return {
                  "cname":"昆仑山传送",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            case 10810:
               return {
                  "cname":"骰子",
                  "name":"sz",
                  "pay":379,
                  "prop_type":0
               };
            case 10820:
               return {
                  "cname":"竹枕",
                  "name":"zz",
                  "pay":399,
                  "prop_type":0
               };
            case 10830:
               return {
                  "cname":"金白菜",
                  "name":"jbc",
                  "pay":409,
                  "prop_type":0
               };
            case 10840:
               return {
                  "cname":"梳妆镜",
                  "name":"szj",
                  "pay":419,
                  "prop_type":0
               };
            case 10850:
               return {
                  "cname":"毛驴",
                  "name":"ml",
                  "pay":389,
                  "prop_type":0
               };
            case 10860:
               return {
                  "cname":"拐杖",
                  "name":"gz",
                  "pay":359,
                  "prop_type":0
               };
            case 10870:
               return {
                  "cname":"白牡丹",
                  "name":"bmd",
                  "pay":349,
                  "prop_type":0
               };
            case 10880:
               return {
                  "cname":"乐谱",
                  "name":"yp",
                  "pay":369,
                  "prop_type":0
               };
            case 10890:
               return {
                  "cname":"1级仙女石",
                  "name":"xns1",
                  "pay":89,
                  "prop_type":0
               };
            case 10900:
               return {
                  "cname":"3级昆仑玉",
                  "name":"kly3",
                  "pay":529,
                  "prop_type":0
               };
            case 10910:
               return {
                  "cname":"大灵魂药水",
                  "name":"dlhys",
                  "pay":300,
                  "prop_type":0
               };
            case 10920:
               return {
                  "cname":"超大经验药水",
                  "name":"cdjyys",
                  "pay":3899,
                  "prop_type":0
               };
            case 10930:
               return {
                  "cname":"1级仙女石",
                  "name":"xns1",
                  "pay":89,
                  "prop_type":0
               };
            case 10940:
               return {
                  "cname":"一重神火·骨凝",
                  "name":"wpsh_1",
                  "pay":559,
                  "prop_type":0
               };
            case 10950:
               return {
                  "cname":"二重神火·玄黯",
                  "name":"wpsh_2",
                  "pay":859,
                  "prop_type":0
               };
            case 10960:
               return {
                  "cname":"三重神铁·点金",
                  "name":"wpsh_3",
                  "pay":1159,
                  "prop_type":0
               };
            case 10980:
               return {
                  "cname":"年兽进化大丹",
                  "name":"nianjhdd",
                  "pay":999,
                  "prop_type":0
               };
            case 10990:
               return {
                  "cname":"新年红灯笼",
                  "name":"xnhdl",
                  "pay":99,
                  "prop_type":0
               };
            case 11000:
               return {
                  "cname":"四重神铁·通明",
                  "name":"wpst_4",
                  "pay":1459,
                  "prop_type":0
               };
            case 11010:
               return {
                  "cname":"五重神铁·玄光",
                  "name":"wpst_5",
                  "pay":1759,
                  "prop_type":0
               };
            case 11020:
               return {
                  "cname":"火魔斩3级技能书",
                  "name":"hmzjns3",
                  "pay":1499,
                  "prop_type":0
               };
            case 11030:
               return {
                  "cname":"火眼金睛3级技能书",
                  "name":"hyjjjns3",
                  "pay":1399,
                  "prop_type":0
               };
            case 11040:
               return {
                  "cname":"水魔爆3级技能书",
                  "name":"smbjns3",
                  "pay":1499,
                  "prop_type":0
               };
            case 11050:
               return {
                  "cname":"九环佛经3级技能书",
                  "name":"jhsjjns3",
                  "pay":1499,
                  "prop_type":0
               };
            case 11060:
               return {
                  "cname":"土魔刺3级技能书",
                  "name":"tmcjns3",
                  "pay":1499,
                  "prop_type":0
               };
            case 11070:
               return {
                  "cname":"圣域之墙3级技能书",
                  "name":"syzqjns3",
                  "pay":1399,
                  "prop_type":0
               };
            case 11080:
               return {
                  "cname":"木魔舞3级技能书",
                  "name":"mmwjns3",
                  "pay":1499,
                  "prop_type":0
               };
            case 11090:
               return {
                  "cname":"猛毒素3级技能书",
                  "name":"mdsjns3",
                  "pay":1399,
                  "prop_type":0
               };
            case 11100:
               return {
                  "cname":"流邪转换石",
                  "name":"lxzhs",
                  "pay":429,
                  "prop_type":0
               };
            case 11110:
               return {
                  "cname":"沙邪转换石",
                  "name":"sxzhs",
                  "pay":439,
                  "prop_type":0
               };
            case 11120:
               return {
                  "cname":"中秋时装",
                  "name":"ptzqsz",
                  "pay":609,
                  "prop_type":30
               };
            case 11130:
               return {
                  "cname":"光棍节脱光",
                  "name":"_ssggjtg",
                  "pay":999,
                  "prop_type":0
               };
            case 11140:
               return {
                  "cname":"八仙挑战再进一次",
                  "name":"",
                  "pay":100,
                  "prop_type":0
               };
            default:
               return {
                  "cname":"找不到id：" + _id + _itemName,
                  "name":"",
                  "pay":0,
                  "prop_type":0
               };
         }
         return {
            "cname":"雷灵珠",
            "name":"wpllz",
            "pay":289,
            "prop_type":0
         };
      }
   }
}
