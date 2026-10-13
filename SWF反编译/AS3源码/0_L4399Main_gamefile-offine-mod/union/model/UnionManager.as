package union.model
{
   import com.adobe.crypto.MD5;
   import config.Config;
   import event.CommonEvent;
   import export.honor.AllianceSprite;
   import export.rank.RankPropertyCount;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import my.Decrypt;
   import union.UnionMain;
   import union.model.vo.MemberVo;
   import union.model.vo.TaskVo;
   import union.model.vo.UnionInfoVo;
   import union.utils.UnionConfig;
   import unit4399.events.UnionEvent;
   
   public class UnionManager
   {
      
      private static var instance:UnionManager;
       
      
      private var stage:Stage;
      
      private var _unionInfo:UnionInfoVo;
      
      private var _taskVo:TaskVo;
      
      private var consumType:int = 0;
      
      private var _isInit:Boolean = false;
      
      public var paramData:Object;
      
      public function UnionManager()
      {
         _unionInfo = new UnionInfoVo();
         _taskVo = new TaskVo();
         paramData = {};
         super();
      }
      
      public static function getIns() : UnionManager
      {
         if(!instance)
         {
            instance = new UnionManager();
         }
         return instance;
      }
      
      public function get unionInfo() : UnionInfoVo
      {
         return _unionInfo;
      }
      
      public function get taskVo() : TaskVo
      {
         return _taskVo;
      }
      
      public function get isInit() : Boolean
      {
         return _isInit;
      }
      
      public function get gc() : Config
      {
         return Config.getInstance();
      }
      
      public function get personMoney() : int
      {
         return _unionInfo.personMoney;
      }
      
      public function get saveId() : int
      {
         return gc.luanqibazaojiami.saveId;
      }
      
      public function get uid() : int
      {
         if(gc.logInfo)
         {
            return gc.logInfo.uid;
         }
         return 0;
      }
      
      public function log(... value) : void
      {
         try
         {
            ExternalInterface.call("console.log",value);
         }
         catch(errObject:Error)
         {
            trace(value);
         }
      }
      
      public function pushMember(vo:MemberVo) : void
      {
         unionInfo.pushMember(vo);
         EventManager.emit("UNION_UPDATE_MEMBER");
      }
      
      public function deleteMember(uId:Number) : void
      {
         unionInfo.deleteMember(uId);
         EventManager.emit("UNION_UPDATE_MEMBER");
      }
      
      public function openUnion(type:int) : void
      {
         var unionMain:UnionMain = new UnionMain();
         GMain.getInstance().getMainSence().addChild(unionMain);
         unionMain.setData(type);
      }
      
      public function initData(stage:Stage) : void
      {
         stage = stage;
         Decrypt;
         UnionConfig.getMemberJob("fmz");
         stage.addEventListener("unionVisitorSuccess",onVisitorSuccess);
         stage.addEventListener("unionMemberSuccess",onMemberSuccess);
         stage.addEventListener("unionGrowSuccess",onGrowSuccess);
         stage.addEventListener("unionMasterSuccess",onMasterSuccess);
         stage.addEventListener("unionVariablesSuccess",onVariablesSuccess);
         stage.addEventListener("unionRoleSuccess",unionRoleSuccess);
         stage.addEventListener("unionError",unionCreateError);
         this.stage = stage;
         UnionConfig.initConfig(true);
         var isTest:Boolean = false;
         setTimeout(function():void
         {
            if(!isTest)
            {
               return;
            }
            stage.addChild(Unify.getRect(300,25,0,10,10));
            var txt:TextField = TextManager.createInputTextField(10,10,300,20,"center",18,16777215);
            txt.text = "参数";
            var btn:Sprite = Unify.getSprBtn(stage,"发送",10,40);
            stage.addChild(txt);
            btn.addEventListener("click",function(e:MouseEvent):void
            {
               rcvdFmJS(txt.text);
            });
            var names:Array = ["创建联盟","加入联盟","我的联盟","联盟列表"];
            for(var i:int = 0; i < names.length; )
            {
               btn = Unify.getSprBtn(stage,names[i],10 + 100 * i,80);
               btn.name = names[i];
               btn.addEventListener("click",function(e:MouseEvent):void
               {
                  var index:int = names.indexOf(e.currentTarget.name);
                  UnionManager.getIns().openUnion(index);
               });
               i++;
            }
         },5000);
      }
      
      public function get checkIsApi() : Boolean
      {
         var info:* = null;
         var type:String = "open.4399.cn";
         if(info)
         {
            return info.indexOf(type) >= 0;
         }
         if(ExternalInterface.available)
         {
            info = ExternalInterface.call("eval","window.location.origin");
            log("info==",info);
            if(info)
            {
               return info.indexOf(type) >= 0;
            }
         }
         return false;
      }
      
      public function rcvdFmJS(param:*) : void
      {
         var data:* = null;
         var value:* = undefined;
         log(param);
         try
         {
            data = JSON.parse(param);
            value = data.value;
            if(data.key == "unionCreate")
            {
               unionCreate(value);
            }
            else if(data.key == "getUnionList")
            {
               getUnionList(value);
            }
            else if(data.key == "applyUnion")
            {
               applyUnion(value);
            }
            else if(data.key == "getOwnUnion")
            {
               getOwnUnion();
            }
            else if(data.key == "getUnionMembers")
            {
               getUnionMembers(value);
            }
            else if(data.key == "quitUion")
            {
               quitUion();
            }
            else if(data.key == "usePersonalContribution")
            {
               usePersonalContribution(value);
            }
            else if(data.key == "removeTotalCb")
            {
               usePersonalContribution(personMoney);
            }
            else if(data.key == "doExchange")
            {
               doExchange(value);
            }
            else if(data.key == "getApplyList")
            {
               getApplyList(value);
            }
            else if(data.key == "removeMember")
            {
               removeMember(value,data.userIndex);
            }
            else if(data.key == "dissolveUnion")
            {
               dissolveUnion(value);
            }
            else if(data.key == "setRole")
            {
               setRole(data.uid,data.index,data.roleId);
            }
            else if(data.key == "doTask")
            {
               doTask(value);
            }
            else if(data.key == "getTaskValue")
            {
               getTaskValue();
            }
            else if(data.key == "getRoleList")
            {
               getRoleList(1,20);
            }
            else if(data.key == "getVariables")
            {
               getVariables([value]);
            }
            else if(data.key == "doVariable")
            {
               doVariable(value);
            }
            else if(data.key == "useUnionContribution")
            {
               useUnionContribution(value);
            }
            else if(data.key == "findC")
            {
               log(gc.allEquip.findByName(value));
            }
            else if(data.key == "findB")
            {
               log(gc.player1.getSomeEquipInPackBackByName(value));
            }
            else if(data.key == "addItem")
            {
               Unify.addItem(value);
            }
            else if(data.key == "removeItem")
            {
               Unify.removeItem(value);
            }
            else if(data.key == "addSprite")
            {
               Unify.removeSprite(-value);
            }
            else if(data.key == "level-15")
            {
               doTask("111");
            }
            else if(data.key == "level-17")
            {
               doTask("112");
            }
            else if(data.key == "transferUnion")
            {
               transferUnion(value.split(",")[0],value.split(",")[1],1);
            }
            else if(data.key == "uid")
            {
               log("uid:" + uid);
            }
         }
         catch(e:*)
         {
            log("参数有错");
         }
      }
      
      private function showByBoolean(boo:*, tip1:String, tip2:String) : Boolean
      {
         boo = Boolean(boo);
         !!boo ? Unify.alert(tip1) : Unify.alert(tip2);
         return boo;
      }
      
      private function onVisitorSuccess(e:UnionEvent) : void
      {
         var dataObj:Object = e.data;
         log("1-游客模块返回信息处理");
         var data:Object = Unify.getJsonData(dataObj.data);
         log(dataObj.apiName,data);
         switch(dataObj.apiName)
         {
            case "create_union":
               log("联盟创建结果:\n" + Boolean(data) + "\n");
               if(showByBoolean(data,"成功创建联盟","创建联盟失败"))
               {
                  EventManager.emit("UNION_CREATE");
                  if(GMain.serviceHold)
                  {
                     GMain.serviceHold.getBalance();
                  }
               }
               break;
            case "list_union":
               log("联盟列表:\n" + String(data) + "\n");
               EventManager.emit("UNION_LIST",data);
               break;
            case "apply_union":
               log("联盟申请结果:\n" + Boolean(data) + "\n");
               showByBoolean(data,"联盟申请成功","联盟申请失败");
               break;
            case "own_union":
               log("当前用户所属联盟信息:",data);
               _unionInfo = new UnionInfoVo();
               _unionInfo.buildFromObject(data.unionInfo);
               _unionInfo.updateMember(data.member);
               log("有联盟吗？",_unionInfo.hasUnion);
               _isInit = true;
               getVariables([UnionConfig.commonVarGx]);
               EventManager.emit("UNION_CHECK",data);
         }
      }
      
      private function onMemberSuccess(e:UnionEvent) : void
      {
         log("2-成员模块返回信息处理");
         var dataObj:Object = e.data;
         var data:Object = Unify.getJsonData(dataObj.data);
         log(dataObj,data);
         switch(dataObj.apiName)
         {
            case "member_list":
               _unionInfo.updateAllMember(data as Array);
               EventManager.emit("UNION_MEMBER");
               break;
            case "union_extra_change":
               Unify.alert("修改成功");
               EventManager.emit("UNION_UPDATE_INFO");
               break;
            case "quit_union":
               Unify.alert("退出联盟成功");
               break;
            case "use_pesonal_contribution":
               _unionInfo.personMoney = int(data);
               EventManager.emit("UNION_UPDATE_PERSON_MONEY");
               if(consumType == 1)
               {
                  AllianceSprite.getInstance().dispatchEvent(new CommonEvent("buy_item_success"));
               }
               consumType = 0;
         }
         if(dataObj.apiName == null)
         {
         }
      }
      
      private function onGrowSuccess(e:UnionEvent) : void
      {
         log("3-联盟成长模块返回信息处理");
         var dataObj:Object = e.data;
         var data:Object = Unify.getJsonData(dataObj.data);
         log(dataObj.apiName,data);
         switch(dataObj.apiName)
         {
            case "union_task":
               log("联盟任务结果:\n" + Boolean(data) + "\n");
               if(showByBoolean(data,"联盟贡献成功","联盟贡献失败"))
               {
                  doVariable(UnionConfig.commonVarGx);
                  _unionInfo.addExp(50);
                  EventManager.emit("UNION_UPDATE_INFO");
                  this.getTaskValue();
               }
               break;
            case "union_exchange":
               log("联盟兑换信息:\n" + Boolean(data) + "\n");
               if(showByBoolean(data,"联盟贡献成功","联盟贡献失败"))
               {
                  _unionInfo.addExp(50);
                  EventManager.emit("UNION_UPDATE_INFO");
               }
               break;
            case "union_task_complete":
               _taskVo = new TaskVo();
               _taskVo.updateFromObject(data);
               EventManager.emit("UNION_UPDATE_TASK");
               log("联盟任务完成情况:",data);
         }
      }
      
      private function onMasterSuccess(e:UnionEvent) : void
      {
         log("4-盟主模块返回信息处理");
         var dataObj:Object = e.data;
         var data:Object = Unify.getJsonData(dataObj.data);
         log(dataObj.apiName,data,dataObj);
         switch(dataObj.apiName)
         {
            case "union_apply_list":
               EventManager.emit("UNION_APPLY_LIST",data);
               break;
            case "union_member_audit":
               log("成员审核信息:\n" + Boolean(data) + "\n");
               showByBoolean(paramData.auditResult == 1,"同意加入","拒绝加入");
               EventManager.emit("UNION_APPLY_UPDATE");
               break;
            case "union_remove_member":
               log("移除成员信息:\n" + Boolean(data) + "\n");
               showByBoolean(data,"踢出成功","踢出失败");
               break;
            case "union_dissolve":
               log("解散联盟信息:\n" + String(data) + "\n");
               break;
            case "use_union_contribution":
               log("消耗联盟贡献点信息:\n" + int(data) + "\n");
               break;
            case "union_multi_member_audit":
               log("审核多成员信息:\n" + Boolean(data) + "\n");
               break;
            case "union_transfer":
               log("转让联盟信息:\n" + Boolean(data) + "\n");
               showByBoolean(data,"转让联盟成功","转让联盟失败");
         }
      }
      
      private function onVariablesSuccess(e:UnionEvent) : void
      {
         var i:int = 0;
         var da:* = null;
         log("5-公共变量模块返回信息处理");
         var dataObj:Object = e.data;
         var data:Object = Unify.getJsonData(dataObj.data);
         log(dataObj.apiName,data);
         if(!data)
         {
            return;
         }
         switch(dataObj.apiName)
         {
            case "change_variable":
               if(data)
               {
                  UnionConfig.gxCount++;
               }
               break;
            case "get_variables":
               for(i = 0; i < data.length; )
               {
                  da = data[i];
                  if(da.id == UnionConfig.commonVarGx)
                  {
                     UnionConfig.gxCount = Number(da.value);
                  }
                  i++;
               }
         }
      }
      
      private function unionRoleSuccess(e:UnionEvent) : void
      {
         log("6-角色模块返回信息处理");
         var dataObj:Object = e.data;
         var data:Object = Unify.getJsonData(dataObj.data);
         log(dataObj.apiName,data);
      }
      
      private function unionCreateError(e:UnionEvent) : void
      {
         log("7-联盟错误返回信息处理");
         var dataObj:Object = e.data;
         var data:Object = Unify.getJsonData(dataObj.data);
         log(dataObj);
         var errorMessage:Object = UnionConfig.ERROR_CODE;
         Unify.alert(errorMessage[dataObj.eId]);
         var _loc5_:* = dataObj.eId;
         if("20008" === _loc5_)
         {
            EventManager.emit("UNION_APPLY_UPDATE");
         }
      }
      
      private function showParam(... arg) : void
      {
         var i:int = 0;
         var str:String = "发送:";
         for(i = 0; i < arg.length; str += arg[i] + ",",i++)
         {
         }
         str = str.substr(0,str.length - 1);
         log(str);
      }
      
      public function unionCreate(title:String, extra:String = "未设置") : void
      {
         var idx:int = saveId;
         showParam("unionCreate",idx,title,extra);
         GMain.serviceHold && GMain.serviceHold.unionCreate(idx,title,extra);
      }
      
      public function getUnionList(pageNum:int, pageSize:int = 6) : void
      {
         var idx:int = saveId;
         showParam("getUnionList",idx,pageNum,pageSize);
         GMain.serviceHold && GMain.serviceHold.getUnionList(idx,pageNum,pageSize);
      }
      
      public function applyUnion(unionId:int, extra:String = "未设置") : void
      {
         var idx:int = saveId;
         var fightPower:int = RankPropertyCount.getFightingForce(gc.player1);
         extra = "{\"fightPower\":" + fightPower + "}";
         showParam("applyUnion",idx,unionId,extra);
         GMain.serviceHold && GMain.serviceHold.applyUnion(idx,unionId,extra);
      }
      
      public function getOwnUnion() : void
      {
         var idx:int = saveId;
         showParam("getOwnUnion",idx);
         GMain.serviceHold && GMain.serviceHold.getOwnUnion(idx);
      }
      
      public function getUnionMembers(unionId:int) : void
      {
         var idx:int = saveId;
         showParam("getUnionMembers",idx,unionId);
         GMain.serviceHold && GMain.serviceHold.getUnionMembers(idx,unionId);
      }
      
      public function setMemberExtra(type:int, extra:String, unionId:int = 0, userId:int = 0, userIndex:int = 0) : void
      {
         var idx:int = saveId;
         showParam("setMemberExtra",idx,type,extra,unionId,userId,userIndex);
         GMain.serviceHold && GMain.serviceHold.setMemberExtra(idx,type,extra,unionId,userId,userIndex);
      }
      
      public function setUnionExtra(type:int, extra:String, unionId:int) : void
      {
         var idx:int = saveId;
         showParam("setUnionExtra",idx,type,extra,unionId);
         GMain.serviceHold && GMain.serviceHold.setUnionExtra(idx,type,extra,unionId);
      }
      
      public function getUnionLog(pageNum:int, pageSize:int) : void
      {
         var idx:int = saveId;
         showParam("getUnionLog",idx,pageNum,pageSize);
         GMain.serviceHold && GMain.serviceHold.getUnionLog(idx,pageNum,pageSize);
      }
      
      public function quitUion() : void
      {
         var idx:int = saveId;
         showParam("quitUion",idx);
         GMain.serviceHold && GMain.serviceHold.quitUion(idx);
      }
      
      public function usePersonalContribution(contribution:int) : void
      {
         var idx:int = saveId;
         showParam("usePersonalContribution",idx,contribution);
         GMain.serviceHold && GMain.serviceHold.usePersonalContribution(idx,contribution);
      }
      
      public function doTask(task:String) : void
      {
         var idx:int = saveId;
         showParam("doTask",idx,task);
         GMain.serviceHold && GMain.serviceHold.doTask(idx,task);
      }
      
      public function doExchange(money:int) : void
      {
         var idx:int = saveId;
         showParam("doExchange",idx,money);
         GMain.serviceHold && GMain.serviceHold.doExchange(idx,money);
      }
      
      public function getTaskValue() : void
      {
         var idx:int = saveId;
         showParam("getTaskValue",idx);
         GMain.serviceHold && GMain.serviceHold.getTaskValue(idx);
      }
      
      public function getApplyList(pageNum:int, pageSize:int = 6) : void
      {
         var idx:int = saveId;
         showParam("getApplyList",idx,pageNum,pageSize);
         GMain.serviceHold && GMain.serviceHold.getApplyList(idx,pageNum,pageSize);
      }
      
      public function auditMember(userId:int, userIndex:int, auditResult:int) : void
      {
         paramData.auditResult = auditResult;
         var idx:int = saveId;
         showParam("auditMember",idx,userId,userIndex,auditResult);
         GMain.serviceHold && GMain.serviceHold.auditMember(idx,userId,userIndex,auditResult);
      }
      
      public function applyMultiAudit(usersAry:Array, auditResult:int) : void
      {
         var idx:int = saveId;
         showParam("applyMultiAudit",idx,usersAry,auditResult);
         GMain.serviceHold && GMain.serviceHold.applyMultiAudit(idx,usersAry,auditResult);
      }
      
      public function removeMember(userId:Number, userIndex:int) : void
      {
         var idx:int = saveId;
         showParam("removeMember",idx,userId,userIndex);
         GMain.serviceHold && GMain.serviceHold.removeMember(idx,userId,userIndex);
      }
      
      public function useUnionContribution(contribution:int) : void
      {
         var idx:int = saveId;
         showParam("useUnionContribution",idx,contribution);
         GMain.serviceHold && GMain.serviceHold.useUnionContribution(idx,contribution);
      }
      
      public function dissolveUnion(actionType:int) : void
      {
         var idx:int = saveId;
         showParam("dissolveUnion",idx,actionType);
         GMain.serviceHold && GMain.serviceHold.dissolveUnion(idx,actionType);
      }
      
      public function transferUnion(userId:int, userIndex:int, result:int) : void
      {
         var idx:int = saveId;
         showParam("transferUnion",idx,userId,userIndex,result);
         GMain.serviceHold && GMain.serviceHold.transferUnion(idx,userId,userIndex,result);
      }
      
      public function getVariables(ids:Array) : void
      {
         var idx:int = saveId;
         showParam("getVariables",idx,ids);
         GMain.serviceHold && GMain.serviceHold.getVariables(idx,ids);
      }
      
      public function doVariable(id:int) : void
      {
         var idx:int = saveId;
         showParam("doVariable",idx,id);
         GMain.serviceHold && GMain.serviceHold.doVariable(idx,id);
      }
      
      public function getRoleList(pageNum:int, pageSize:int) : void
      {
         showParam(pageNum,pageSize);
         GMain.serviceHold && GMain.serviceHold.getRoleList(pageNum,pageSize);
      }
      
      public function setRole(index:int, uid:Number, roleId:int) : void
      {
         var idx:int = saveId;
         showParam("setRole",idx,uid,index,roleId);
         GMain.serviceHold && GMain.serviceHold.setRole(idx,uid,index,roleId);
      }
      
      public function get hasUnion() : Boolean
      {
         return _unionInfo.hasUnion;
      }
      
      public function get unionLevel() : int
      {
         return _unionInfo.level;
      }
      
      public function buyProp(money:int) : void
      {
         consumType = 1;
         usePersonalContribution(money);
      }
      
      public function match2(value:String, callBack:Function = null, caller:* = null) : void
      {
         value = value;
         callBack = callBack;
         caller = caller;
         onReq = function(e:Event):void
         {
            var data:* = null;
            _loader.removeEventListener("complete",onReq,true);
            _loader.removeEventListener("ioError",onReq,true);
            _loader.removeEventListener("securityError",onReq,true);
            log(e);
            if(e.type == "complete")
            {
               data = JSON.parse(_loader.data);
               if(!data.result)
               {
                  Unify.alert("服务器繁忙，稍后再试");
                  return;
               }
               log(data);
               if(data.result.riskType == 0)
               {
                  callBack.call(caller,value);
               }
               else
               {
                  Unify.alert("包含敏感词，请修改!");
               }
            }
            else
            {
               Unify.alert("服务器繁忙，稍后再试");
            }
         };
         var refer:String = "bqtj";
         var secret:String = "Q2hjh82BZ27RY96e1BM40mKrWWZNYUAO";
         var requestTime:int = int(new Date().time / 1000);
         var uri:String = "/v1.0/" + refer + "/check/text.json";
         var content:String = refer + uri + requestTime + secret;
         var sign:String = MD5.hash(content);
         var request:URLRequest = new URLRequest("https://game-audit.4399api.net" + uri);
         request.method = "POST";
         request.data = JSON.stringify({
            "content":value,
            "forumsId":"zm3",
            "extra":{"account":uid}
         });
         log("https://game-audit.4399api.net" + uri,value);
         request.requestHeaders = [new URLRequestHeader("X-Api-Time",requestTime + ""),new URLRequestHeader("X-Api-Sign",sign + ""),new URLRequestHeader("Content-Type","application/json")];
         var _loader:URLLoader = new URLLoader();
         _loader.addEventListener("complete",onReq,false,0,true);
         _loader.addEventListener("ioError",onReq,false,0,true);
         _loader.addEventListener("securityError",onReq,false,0,true);
         _loader.load(request);
      }
   }
}
