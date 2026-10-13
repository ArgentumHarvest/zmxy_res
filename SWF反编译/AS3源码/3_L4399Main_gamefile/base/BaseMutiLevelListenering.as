package base
{
   import com.greensock.TweenMax;
   import com.multi4399.Client;
   import com.multi4399.ResponseEvent;
   import com.multi4399.Utils;
   import config.ActionStateConst;
   import config.Config;
   import event.CommonEvent;
   import export.LineChoose;
   import export.muti.DaoJiShi;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import my.ChatInFb;
   import my.MainGame;
   import user.MutiUser;
   
   public class BaseMutiLevelListenering extends BaseLevelListenering
   {
       
      
      public var servers:URLLoader;
      
      private var delayCount:int;
      
      private var lineChoose:LineChoose;
      
      private var createdMonsterArray:Array;
      
      protected var countDownTimer:Timer;
      
      var iii:uint = 0;
      
      private var tw1:TweenMax;
      
      public function BaseMutiLevelListenering()
      {
         servers = new URLLoader();
         createdMonsterArray = [];
         countDownTimer = new Timer(1000);
         super();
         delayCount = gc.frameClips * 2;
         this.countDownTimer.addEventListener("timer",__countDownTimer);
      }
      
      override public function init() : void
      {
         super.init();
         if(gc.isSingleGame())
         {
            this.lineChoose = new LineChoose();
            GMain.getInstance().getTopSence().addChild(this.lineChoose);
            this.lineChoose.addMask();
         }
      }
      
      override public function start() : void
      {
         trace("============start==================");
         super.start();
         if(!gc.server)
         {
            gc.server = new Client();
            servers.addEventListener("complete",onXML);
            servers.addEventListener("ioError",onXML);
            servers.addEventListener("securityError",onXML);
            if(!gc.isHideDebug)
            {
               servers.load(new URLRequest("http://xml.multi.img4399.com/2006.xml"));
            }
            else
            {
               gc.ts.setTxt("连接中...");
               gc.stage.addChild(gc.ts);
               servers.load(new URLRequest("http://xml.multi.img4399.com/2006.xml"));
            }
         }
      }
      
      public function onXML(e:Event) : void
      {
         trace("============onXML==================");
         if(e.type != "complete")
         {
            if(this.lineChoose)
            {
               this.lineChoose.scoketError();
               this.lineChoose.clearMask();
            }
            gc.server = null;
            gc.ts.setTxt("无法连接服务器!");
            gc.stage.addChild(gc.ts);
            return;
         }
         var xml:XML = new XML(e.target.data);
         var target:XML = xml.server[0];
         trace("target.host:" + target.host);
         trace("target.port:" + target.port);
         gc.server.addEventListener("connect",onSocket);
         gc.server.addEventListener("close",onSocket);
         gc.server.addEventListener("ioError",onSocket);
         gc.server.addEventListener("securityError",onSocket);
         gc.server.connect(target.host,target.port);
      }
      
      public function onSocket(e:Event) : void
      {
         trace("============onSocket==================e.type:" + e.type);
         if(e.type != "connect")
         {
            if(this.lineChoose)
            {
               this.lineChoose.scoketError();
               this.lineChoose.clearMask();
            }
            gc.server = null;
            gc.ts.setTxt("无法连接服务器!");
            gc.stage.addChild(gc.ts);
            return;
         }
         gc.server.addEventListener("packet",onResponse);
         if(gc.logInfo)
         {
            gc.server.ins_login(2006,189652,parseInt(gc.logInfo.uid));
         }
         else
         {
            gc.server.ins_login(2006,189652);
         }
         gc.server.ins_get_node(2048);
         gc.server.ins_get_node(32);
         gc.server.ins_set_user(4,gc.getSaveInfo());
         gc.server.submit(1);
      }
      
      public function initOthersOne(e:ResponseEvent) : void
      {
         var ou:* = null;
         var j:int = 0;
         trace("initOthersOne");
         var xmlData:XML = e.values[2] as XML;
         var index:uint = e.values[1];
         trace("gc.pWorld.getOtherHeroUserArray():" + gc.pWorld.getOtherHeroUserArray().length);
         trace("xmlData.heros.length():" + xmlData.heros.length());
         for(j = 0; j < xmlData.heros.length(); )
         {
            ou = new MutiUser();
            ou.sid = e.values[0];
            ou.roleId = parseInt(xmlData.heros[j].rid);
            ou.uName = xmlData.heros[j].un;
            ou.pos = new Point(parseInt(xmlData.heros[j].posX),parseInt(xmlData.heros[j].posY));
            ou.direct = parseInt(xmlData.heros[j].dir);
            ou.level = parseInt(xmlData.heros[j].level);
            ou.weaponId = parseInt(xmlData.heros[j].weaId);
            ou.equpId = parseInt(xmlData.heros[j].cloId);
            ou.mDef = xmlData.heros[j].mdef;
            ou.def = parseInt(xmlData.heros[j].def);
            ou.shp = parseInt(xmlData.heros[j].hp);
            ou.hp = parseInt(xmlData.heros[j].hp);
            ou.petName = xmlData.heros[j].petName;
            ou.petLevel = parseInt(xmlData.heros[j].petLv);
            ou.petHp = parseInt(xmlData.heros[j].petHp);
            ou.petMp = parseInt(xmlData.heros[j].petMp);
            ou.bmwId = parseInt(xmlData.heros[j].bmwId);
            if(xmlData.heros[j].honor && xmlData.heros[j].honor != undefined)
            {
               ou.honorName = xmlData.heros[j].honor;
            }
            if(xmlData.heros[j].job && xmlData.heros[j].job != undefined)
            {
               ou.jobName = xmlData.heros[j].job;
            }
            ou.index = index;
            gc.pWorld.getOtherHeroUserArray().push(ou);
            j++;
         }
         trace("gc.pWorld.getOtherHeroUserArray():" + gc.pWorld.getOtherHeroUserArray().length);
         if(!gc.isInHost())
         {
            if(gc.isInRoom())
            {
               gc.gameInfo.clearOtherUserInfoSprite();
               for each(var mutiUser in gc.pWorld.getOtherHeroUserArray())
               {
                  if(mutiUser.sid != gc.sid)
                  {
                     gc.gameInfo.addOtherUserInfoOne(mutiUser);
                  }
               }
            }
         }
      }
      
      public function initOthers(e:ResponseEvent) : void
      {
         var ou:* = null;
         var i:int = 0;
         var xmlData:* = null;
         var index:* = 0;
         var j:int = 0;
         trace("initOthers");
         var idArr:Array = Utils.byte4_to_ints(e.values[0]);
         trace("idArr:" + idArr);
         this.clearAllOtherPlayers();
         gc.pWorld.getOtherHeroUserArray().length = 0;
         var len:int = idArr.length;
         for(i = 0; i < len; )
         {
            xmlData = e.values[3 + i * 2] as XML;
            index = uint(e.values[2 + i * 2]);
            for(j = 0; j < xmlData.heros.length(); )
            {
               ou = new MutiUser();
               ou.sid = idArr[i];
               ou.roleId = parseInt(xmlData.heros[j].rid);
               ou.uName = xmlData.heros[j].un;
               ou.pos = new Point(parseInt(xmlData.heros[j].posX),parseInt(xmlData.heros[j].posY));
               ou.direct = parseInt(xmlData.heros[j].dir);
               ou.level = parseInt(xmlData.heros[j].level);
               ou.weaponId = parseInt(xmlData.heros[j].weaId);
               ou.equpId = parseInt(xmlData.heros[j].cloId);
               ou.mDef = xmlData.heros[j].mdef;
               ou.def = parseInt(xmlData.heros[j].def);
               ou.shp = parseInt(xmlData.heros[j].hp);
               ou.hp = parseInt(xmlData.heros[j].hp);
               ou.petName = xmlData.heros[j].petName;
               ou.petLevel = parseInt(xmlData.heros[j].petLv);
               ou.petHp = parseInt(xmlData.heros[j].petHp);
               ou.petMp = parseInt(xmlData.heros[j].petMp);
               ou.bmwId = parseInt(xmlData.heros[j].bmwId);
               if(xmlData.heros[j].honor && xmlData.heros[j].honor != undefined)
               {
                  ou.honorName = xmlData.heros[j].honor;
               }
               if(xmlData.heros[j].job && xmlData.heros[j].job != undefined)
               {
                  ou.jobName = xmlData.heros[j].job;
               }
               ou.index = index;
               gc.pWorld.getOtherHeroUserArray().push(ou);
               j++;
            }
            i++;
         }
         trace("gc.pWorld.getOtherHeroUserArray().length:" + gc.pWorld.getOtherHeroUserArray().length);
         if(gc.isInRoom())
         {
            gc.gameInfo.clearOtherUserInfoSprite();
            for each(var mutiUser in gc.pWorld.getOtherHeroUserArray())
            {
               if(mutiUser.sid != gc.sid)
               {
                  gc.gameInfo.addOtherUserInfoOne(mutiUser);
               }
            }
         }
      }
      
      private function showDisplayObjectByOtherHeroUser() : void
      {
         var ou:* = null;
         var i:int = 0;
         var bh:* = null;
         var len:uint = gc.pWorld.getOtherHeroUserArray().length;
         for(i = 0; i < len; )
         {
            ou = gc.pWorld.getOtherHeroUserArray()[i] as MutiUser;
            if(ou.sid != gc.sid)
            {
               if(!gc.getHeroBySidAndRoleId(ou.sid,ou.roleId))
               {
                  bh = addOther(ou.sid,ou.roleId);
                  bh.x = ou.pos.x;
                  bh.y = ou.pos.y;
                  bh.setCurClothId(ou.equpId);
                  bh.setCurWeaponId(ou.weaponId);
                  bh.setNameTextField(ou.uName);
                  bh.refreshEquip();
                  bh.getBBDC().setDirect(ou.direct);
                  ou.hero = bh;
               }
            }
            i++;
         }
      }
      
      private function showDisplayObjectByOtherHeroUserWhenStartGame() : void
      {
         var ou:* = null;
         var temp:* = null;
         var i:int = 0;
         var bh:* = null;
         trace("showDisplayObjectByOtherHeroUserWhenStartGame");
         var len:uint = gc.pWorld.getOtherHeroUserArray().length;
         trace("len:" + len);
         for(i = 0; i < len; )
         {
            ou = gc.pWorld.getOtherHeroUserArray()[i] as MutiUser;
            if(ou.sid == gc.sid)
            {
               if(gc.hero1 && gc.hero1.getRoleId() == ou.roleId)
               {
                  temp = gc.hero1;
               }
               if(gc.hero2 && gc.hero2.getRoleId() == ou.roleId)
               {
                  temp = gc.hero2;
               }
            }
            else if(!gc.getHeroBySidAndRoleId(ou.sid,ou.roleId))
            {
               bh = addOther(ou.sid,ou.roleId);
               bh.setCurClothId(ou.equpId);
               bh.setCurWeaponId(ou.weaponId);
               bh.setNameTextField(ou.uName);
               bh.refreshEquip();
               temp = bh;
               ou.hero = bh;
            }
            if(temp)
            {
               temp.x = 150 + ou.index / (gc.nodeInfo.ltdVisitors - 1) * 700;
               temp.y = 350;
               if(ou.index < gc.nodeInfo.ltdVisitors / 2)
               {
                  temp.getBBDC().setDirect(1);
               }
               else
               {
                  temp.getBBDC().setDirect(0);
               }
               if(temp.getPet())
               {
                  temp.getPet().x = temp.x;
                  temp.getPet().y = temp.y - 200;
               }
            }
            temp = null;
            i++;
         }
      }
      
      public function addOther(sid:int, roleId:uint) : BaseHero
      {
         trace("--addOther--sid&roleId:" + sid + "," + roleId);
         var bh:BaseHero = AUtils.getNewObj("export.hero.Role" + roleId) as BaseHero;
         bh.sid = sid;
         bh.setRoleId(roleId);
         bh.x = 100;
         bh.y = 100;
         bh.start();
         gc.pWorld.getOtherHeroArray().push(bh);
         gc.gameSence.addChild(bh);
         return bh;
      }
      
      private function removeHeroBySidAndRoleId(sid:int, roleId:uint) : void
      {
         var bh:* = null;
         var i:int = 0;
         for(i = 0; i < gc.pWorld.getOtherHeroArray().length; )
         {
            bh = gc.pWorld.getOtherHeroArray()[i] as BaseHero;
            if(bh && bh.sid == sid && bh.getRoleId() == roleId)
            {
               gc.pWorld.getOtherHeroArray().splice(i,1);
               if(gc.gameSence.contains(bh))
               {
                  gc.gameSence.removeChild(bh);
               }
               if(bh.getPet())
               {
                  bh.getPet().destroy();
               }
               break;
            }
            i++;
         }
      }
      
      private function removeHeroBySid(sid:int) : void
      {
         var bh:* = null;
         var i:int = 0;
         var j:* = 0;
         var idx:int = 0;
         var readyToDeleteArray:Array = [];
         for(i = 0; i < gc.pWorld.getOtherHeroArray().length; )
         {
            bh = gc.pWorld.getOtherHeroArray()[i] as BaseHero;
            if(bh && bh.sid == sid)
            {
               readyToDeleteArray.push(bh);
               bh.destroy();
            }
            i++;
         }
         for(j = uint(0); j < readyToDeleteArray.length; )
         {
            bh = readyToDeleteArray[j] as BaseHero;
            idx = gc.pWorld.getOtherHeroArray().indexOf(bh);
            if(idx != -1)
            {
               gc.pWorld.getOtherHeroArray().splice(idx,1);
            }
            j++;
         }
         readyToDeleteArray.length = 0;
      }
      
      public function onResponse(e:ResponseEvent) : void
      {
         var i:int = 0;
         var code:int = 0;
         var sid:int = 0;
         var arr:* = null;
         var iii:* = 0;
         var bh:* = null;
         var ttf:* = null;
         var curNum:* = 0;
         var ltdNum:* = 0;
         var maxNum:* = 0;
         var index:* = 0;
         curNum = 0;
         ltdNum = 0;
         maxNum = 0;
         var baTemp:* = null;
         var entityId:* = 0;
         var isLeft:Boolean = false;
         var isRight:Boolean = false;
         var bm:* = null;
         baTemp = null;
         var p:* = null;
         entityId = 0;
         var kind:* = 0;
         var xx:Number = NaN;
         var yy:Number = NaN;
         baTemp = null;
         p = null;
         entityId = 0;
         bm = null;
         baTemp = null;
         entityId = 0;
         var actionState:* = 0;
         var action:* = null;
         var xxx:int = 0;
         var yyy:int = 0;
         bm = null;
         baTemp = null;
         var uid:* = 0;
         var roleId:* = 0;
         var monsterEntityId:* = 0;
         var attackBackX:int = 0;
         var attackBackY:int = 0;
         var bbm:* = null;
         var bhTemp:* = null;
         baTemp = null;
         uid = 0;
         monsterEntityId = 0;
         var hpChange:int = 0;
         bbm = null;
         baTemp = null;
         uid = 0;
         monsterEntityId = 0;
         roleId = 0;
         attackBackX = 0;
         attackBackY = 0;
         var initTimer:* = 0;
         bbm = null;
         var img:* = null;
         var bhhh:* = null;
         baTemp = null;
         uid = 0;
         monsterEntityId = 0;
         var buffName:* = null;
         var buffTime:int = 0;
         bbm = null;
         baTemp = null;
         uid = 0;
         roleId = 0;
         var bhttt:* = null;
         baTemp = null;
         uid = 0;
         roleId = 0;
         bhttt = null;
         trace("mark:" + e.mark.toString(16));
         if(e.errors.length)
         {
            i = 0;
            if(i < e.errors.length)
            {
               code = e.values[e.errors[i]];
               trace("ERROR CODE:" + e.errors[i] + "," + code.toString(16));
               onResponseError(e);
               return;
            }
         }
         switch(e.mark)
         {
            case 32769:
               trace("--STAYER_IN--");
               if(gc.isInRoom())
               {
                  gc.getUserInfoByUid(e.values[0]);
               }
               if(gc.gameInfo && gc.isInRoom())
               {
                  gc.getRoomInfo();
               }
               break;
            case 32770:
               trace("玩家：" + e.values[0] + "离开");
               sid = parseInt(e.values[0]);
               if(gc.gameInfo && gc.isInRoom())
               {
                  gc.gameInfo.removeOtherUserInfoOne(sid);
                  arr = gc.pWorld.getOtherHeroUserArray();
                  for(iii = uint(0); iii < arr.length; )
                  {
                     bh = arr[iii];
                     if(bh.sid == sid)
                     {
                        gc.pWorld.getOtherHeroUserArray().splice(iii,1);
                        break;
                     }
                     iii++;
                  }
               }
               if(gc.isInRoom() && this.countDownTimer.running)
               {
                  this.countDownTimer.stop();
                  this.countDownTimer.reset();
               }
               this.removeHeroBySid(sid);
               break;
            case 32772:
               trace("--房主发生变化！--");
               if(gc.isInRoom())
               {
                  gc.roomOnwerSid = parseInt(e.values[0]);
                  if(gc.roomOnwerSid == gc.sid)
                  {
                     trace("我是房主");
                     gc.isRoomOnwer = true;
                  }
                  else
                  {
                     trace("我不是房主");
                     gc.isRoomOnwer = false;
                  }
               }
               break;
            case 1:
               if(this.lineChoose)
               {
                  this.lineChoose.clearMask();
               }
               gc.isServerOk = true;
               gc.nodeFloor = 1;
               this.lineChoose.curNodeMaxVisitors = e.values[1];
               this.lineChoose.curNodeNumChildren = e.values[2];
               this.lineChoose.curChildNodeMaxVis = int(this.lineChoose.curNodeMaxVisitors / this.lineChoose.curNodeNumChildren);
               gc.sid = e.values[0];
               ttf = new TextFormat();
               ttf.size = 20;
               ttf.color = 16711680;
               if(gc.hero1)
               {
                  gc.hero1.sid = e.values[0];
                  if(gc.honorData)
                  {
                     gc.hero1.setNameTextField(gc.honorData.nicheng,ttf);
                  }
                  else
                  {
                     gc.hero1.setNameTextField(gc.sid + " P",ttf);
                  }
               }
               if(gc.hero2)
               {
                  gc.hero2.sid = e.values[0];
                  if(gc.honorData)
                  {
                     gc.hero2.setNameTextField(gc.honorData.nicheng,ttf);
                  }
                  else
                  {
                     gc.hero2.setNameTextField(gc.sid + " P",ttf);
                  }
               }
               gc.keyboardControl.stopAllControl();
               if(gc.isDirectGoToRoomChoose)
               {
                  if(gc.nodeInfo.PK_OR_FB == 0)
                  {
                     this.lineChoose.goToFirstLine();
                  }
                  else
                  {
                     this.lineChoose.goToFbLine();
                  }
               }
               break;
            case 257:
               gc.server.ins_set_user(32,32769 | 32770 | 32772);
               gc.nodeFloor = 2;
               if(this.lineChoose)
               {
                  this.lineChoose.destroy();
               }
               gc.keyboardControl.continueAllControl();
               if(gc.gameInfo)
               {
                  gc.gameInfo.mutiGame();
                  gc.gameInfo.showArenaSprite();
               }
               break;
            case 258:
               ChatInFb.getIns().clearChat();
               ChatInFb.getIns().show();
               gc.nodeFloor = 3;
               gc.isRoomOnwer = false;
               gc.position += "-->" + (e.values[0] + 1) + "房";
               curNum = uint(parseInt(e.values[3]));
               ltdNum = uint(parseInt(e.values[4]));
               maxNum = uint(parseInt(e.values[5]));
               gc.nodeInfo.ltdVisitors = ltdNum;
               gc.nodeInfo.MaxVisitors = maxNum;
               gc.nodeInfo.initWhenJoinRoom();
               this.createdMonsterArray.length = 0;
               if(e.values[2] != "")
               {
                  setNodeData(e.values[2]);
               }
               this.changeMapByMapInfo();
               if(gc.gameInfo)
               {
                  gc.gameInfo.joinRoomReturn(1);
               }
               gc.getOtherPlayersInfo();
               gc.keyboardControl.continueAllControl();
               break;
            case 2:
               initOthers(e);
               if(!gc.isInHost())
               {
               }
               break;
            case 33:
               initOthersOne(e);
               if(!gc.isInHost())
               {
               }
               break;
            case 3:
               moveOther(e.values[1],e.values[0]);
               break;
            case 4:
               walkOther(e.values[1],e.values[0]);
               break;
            case 5:
               faceToOther(e.values[1],e.values[0]);
               break;
            case 6:
               hurtOther(e.values[1],e.values[0]);
               break;
            case 97:
               hurtOtherPet(e.values[1],e.values[0]);
               break;
            case 7:
               deadOther(e.values[1],e.values[0]);
               break;
            case 113:
               deadPetOther(e.values[1],e.values[0]);
               break;
            case 9:
               runOther(e.values[1],e.values[0]);
               break;
            case 16:
               showDelay(e.values[1]);
               break;
            case 17:
               otherAttack(e.values[1],e.values[0]);
               break;
            case 273:
               otherBuff(e.values[1],e.values[0]);
               break;
            case 18:
               updateChat(e.values[1],e.values[0]);
               break;
            case 19:
               otherPetAttack(e.values[1],e.values[0]);
               break;
            case 20:
               otherPetAction(e.values[1],e.values[0]);
               break;
            case 256:
               this.lineChoose.refreshData(e);
               break;
            case 272:
               if(gc.gameInfo)
               {
                  gc.gameInfo.updateRoomList(e);
               }
               break;
            case 512:
               trace("创建房间OK!");
               ChatInFb.getIns().clearChat();
               ChatInFb.getIns().show();
               index = uint(parseInt(e.values[2]));
               gc.nodeFloor = 3;
               gc.isRoomOnwer = true;
               gc.nodeInfo.initWhenJoinRoom();
               this.createdMonsterArray.length = 0;
               this.changeMapByMapInfo();
               if(gc.gameInfo)
               {
                  gc.gameInfo.createReturn(1);
               }
               this.clearAllOtherPlayers();
               gc.getOtherPlayersInfo();
               break;
            case 513:
               BaseBitmapDataPool.removeScoketOtherHeroData();
               trace("退出房间OK!");
               ChatInFb.getIns().hide();
               gc.nodeFloor = 2;
               gc.isRoomOnwer = false;
               this.clearAllOtherPlayers();
               this.changeMapToHost();
               if(gc.hero1)
               {
                  gc.hero1.clearAllBullets();
                  gc.hero1.setStatic();
                  if(gc.hero1.getPlayer())
                  {
                     gc.hero1.getPlayer().reSetAllPetState();
                  }
               }
               if(gc.hero2)
               {
                  gc.hero2.clearAllBullets();
                  gc.hero2.setStatic();
                  if(gc.hero2.getPlayer())
                  {
                     gc.hero2.getPlayer().reSetAllPetState();
                  }
               }
               if(this.countDownTimer && this.countDownTimer.running)
               {
                  this.countDownTimer.stop();
                  this.countDownTimer.reset();
               }
               if(gc.gameInfo)
               {
                  gc.gameInfo.quitRoom();
               }
               break;
            case 516:
               curNum = uint(parseInt(e.values[2]));
               ltdNum = uint(parseInt(e.values[3]));
               maxNum = uint(parseInt(e.values[4]));
               gc.nodeInfo.ltdVisitors = ltdNum;
               gc.nodeInfo.MaxVisitors = maxNum;
               if(e.values[1] != "")
               {
                  setNodeData(e.values[1]);
               }
               if(gc.isRoomOnwer)
               {
                  if(curNum == ltdNum)
                  {
                     gc.sendGameCountdown();
                  }
               }
               break;
            case 768:
               gameCountdown();
               break;
            case 769:
               gameStart();
               break;
            case 64:
               refreshOtherMutiUser(e.values[1],e.values[0]);
               break;
            case 1025:
               refreshOtherMutiUserHp(e.values[1],e.values[0]);
               break;
            case 4096:
               baTemp = e.values[0];
               entityId = uint(baTemp.readShort());
               isLeft = baTemp.readByte() == 1 ? true : false;
               isRight = baTemp.readByte() == 1 ? true : false;
               bm = gc.getMonsterById(entityId);
               if(bm)
               {
                  if(isLeft)
                  {
                     bm.turnLeftPublic();
                  }
                  if(isRight)
                  {
                     bm.turnRightPublic();
                  }
               }
               break;
            case 4097:
               baTemp = e.values[0];
               p = baTemp.readUTFBytes(baTemp.length).split(",");
               entityId = uint(p[0]);
               kind = uint(p[1]);
               xx = p[2];
               yy = p[3];
               if(this.createdMonsterArray.indexOf(entityId) == -1)
               {
                  this.createdMonsterArray.push(entityId);
                  MainGame.getInstance().createMonster(kind,xx,yy,-1,entityId);
                  gc.nodeInfo.isMonsterAppeared = true;
               }
               break;
            case 4098:
               baTemp = e.values[0];
               p = baTemp.readUTFBytes(baTemp.length).split(",");
               entityId = uint(p[0]);
               bm = gc.getMonsterById(entityId);
               if(bm)
               {
                  bm.setAction("wait");
                  bm.setStatic();
               }
               break;
            case 4099:
               baTemp = e.values[0];
               entityId = uint(baTemp.readShort());
               actionState = uint(baTemp.readByte());
               action = ActionStateConst.getInstence().getActionByState(actionState);
               xxx = baTemp.readShort();
               yyy = baTemp.readShort();
               bm = gc.getMonsterById(entityId);
               if(bm)
               {
                  bm.x = xxx;
                  bm.y = yyy;
                  bm.setAction(action);
                  if(action == "wait")
                  {
                     bm.setStatic();
                  }
                  else if(action == "dead")
                  {
                     bm.setHp(0);
                  }
               }
               break;
            case 4100:
               baTemp = e.values[0];
               uid = uint(e.values[1]);
               roleId = uint(baTemp.readByte());
               monsterEntityId = uint(baTemp.readShort());
               attackBackX = baTemp.readShort();
               attackBackY = baTemp.readShort();
               bbm = gc.getMonsterById(monsterEntityId);
               if(bbm)
               {
                  bhTemp = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
                  if(bhTemp)
                  {
                     if(bhTemp.isCanHurtWhenBeingAttack())
                     {
                        bhTemp.setAttackBack(new Point(attackBackX,attackBackY));
                        bhTemp.setAction("hurt");
                     }
                  }
               }
               break;
            case 4101:
               baTemp = e.values[0];
               uid = uint(e.values[1]);
               monsterEntityId = uint(baTemp.readShort());
               hpChange = baTemp.readInt();
               bbm = gc.getMonsterById(monsterEntityId);
               if(bbm)
               {
                  if(hpChange > 0)
                  {
                     bbm.setHp(bbm.getHp() - hpChange);
                     bbm.addMonHurtMc(hpChange,false);
                  }
                  else
                  {
                     bbm.setHp(bbm.getHp() + hpChange);
                     bbm.addCureMc(hpChange);
                  }
                  if(gc.isRoomOnwer)
                  {
                     bbm.reduceHp(0);
                  }
               }
               break;
            case 4102:
               baTemp = e.values[0];
               uid = uint(e.values[1]);
               monsterEntityId = uint(baTemp.readShort());
               roleId = uint(baTemp.readByte());
               attackBackX = baTemp.readShort();
               attackBackY = baTemp.readShort();
               initTimer = uint(baTemp.readInt());
               bbm = gc.getMonsterById(monsterEntityId);
               if(bbm)
               {
                  img = AUtils.getNewObj("MonsterBeHurt1");
                  img.x = bbm.colipse.x;
                  img.y = bbm.colipse.y;
                  bbm.addChild(img);
                  if(bbm.isCanHurtWhenBeingAttack())
                  {
                     bbm.setAction("hurt");
                     bbm.setAttackBack(new Point(attackBackX,attackBackY));
                  }
                  bhhh = gc.getHeroBySidAndRoleId(uid,roleId);
                  if(bhhh)
                  {
                     bbm.setCurAttackTarget(bhhh);
                  }
                  if(initTimer > 0)
                  {
                     if(bhhh)
                     {
                        for each(var bb in bhhh.magicBulletArray)
                        {
                           if(bb.initTimer == initTimer)
                           {
                              bb.reduceMaxAttackCount();
                           }
                        }
                     }
                  }
               }
               break;
            case 4103:
               baTemp = e.values[0];
               uid = uint(e.values[1]);
               monsterEntityId = uint(baTemp.readShort());
               buffName = baTemp.readUTF();
               buffTime = baTemp.readShort();
               bbm = gc.getMonsterById(monsterEntityId);
               if(bbm)
               {
                  bbm.addCurAddEffect([{
                     "name":buffName,
                     "time":buffTime
                  }]);
               }
               break;
            case 4104:
               baTemp = e.values[0];
               uid = uint(e.values[1]);
               roleId = uint(baTemp.readByte());
               bhttt = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
               if(bhttt)
               {
                  bhttt.turnToWushuang();
               }
               break;
            case 4105:
               baTemp = e.values[0];
               uid = uint(e.values[1]);
               roleId = uint(baTemp.readByte());
               bhttt = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
               if(bhttt)
               {
                  bhttt.WushuangOver();
               }
         }
      }
      
      public function onResponseError(e:ResponseEvent) : void
      {
         trace("onResponseError-->e.type:" + e.type);
         switch(e.mark)
         {
            case 1:
               if(e.values[0] == 16387)
               {
                  gc.ts.setTxt("游戏人数已满,请稍后再试");
                  gc.stage.addChild(gc.ts);
                  if(this.lineChoose)
                  {
                     this.lineChoose.backBtn.enabled = true;
                     this.lineChoose.backBtn.mouseEnabled = true;
                  }
               }
               break;
            case 257:
               if(e.values[0] == 19968)
               {
                  this.lineChoose.joinFail();
                  gc.ts.setTxt("房间人数已满!");
                  gc.stage.addChild(gc.ts);
               }
               break;
            case 258:
               trace("进入房间失败");
               if(e.values[0] == 16390)
               {
                  trace("游戏已经开始");
                  gc.ts.setTxt("游戏已经开始!");
                  gc.stage.addChild(gc.ts);
               }
               else if(e.values[0] == 19970)
               {
                  trace("该房间已经不存在");
                  gc.ts.setTxt("该房间已经不存在!");
                  gc.stage.addChild(gc.ts);
               }
               if(gc.gameInfo)
               {
                  gc.gameInfo.joinRoomReturn(0);
               }
               break;
            case 512:
               trace("创建房间失败");
               gc.ts.setTxt("创建房间失败!");
               gc.stage.addChild(gc.ts);
               gc.roomInfo = "";
               if(gc.gameInfo)
               {
                  gc.gameInfo.createReturn(0);
               }
         }
      }
      
      private function clearAllOtherPlayers() : void
      {
         var i:* = 0;
         var bh:* = null;
         for(i = uint(0); i < gc.pWorld.getOtherHeroArray().length; )
         {
            bh = gc.pWorld.getOtherHeroArray()[i] as BaseHero;
            if(bh.getPet())
            {
               bh.getPet().destroy();
            }
            bh.destroy();
            i++;
         }
         gc.pWorld.getOtherHeroArray().length = 0;
      }
      
      private function gameStart() : void
      {
         trace("301---开始游戏");
         var daijishi:DaoJiShi = new DaoJiShi(DaoJiShi.DAOJISHI_START);
         daijishi.x = 400;
         daijishi.y = 200;
         gc.gameInfo.addChild(daijishi);
         gc.nodeInfo.start();
         gc.gameInfo.pkStart();
         gc.keyboardControl.stopAllControl();
         for each(bh in gc.getPlayerArray())
         {
            bh.setAction("wait");
            bh.setStatic();
            bh.speed.y = 0;
            bh.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[bh.roleProperies.getSHHP()]));
            bh.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[bh.roleProperies.getSMMP()]));
            if(bh.getPet())
            {
               bh.getPet().petInfo.setHp(bh.getPet().petInfo.getSHp());
               bh.getPet().petInfo.setMp(bh.getPet().petInfo.getSMp());
            }
            bh.getBBDC().show();
            bh.cancelAllEffect();
            bh.resetKey();
            bh.resetGraity();
            bh.clearAllBullets();
            bh.setJumpCount(0);
         }
         tw1 = TweenMax.delayedCall(2,function(_gc:Config):*
         {
            _gc.keyboardControl.continueAllControl();
         },[gc]);
         this.showDisplayObjectByOtherHeroUserWhenStartGame();
      }
      
      private function gameCountdown() : void
      {
         trace("300--开始倒计时");
         this.countDownTimer.start();
      }
      
      private function __countDownTimer(evt:TimerEvent) : void
      {
         var daijishi:* = null;
         trace("this.countDownTimer.currentCount:" + this.countDownTimer.currentCount);
         if(this.countDownTimer.currentCount == 3)
         {
            this.countDownTimer.stop();
            this.countDownTimer.reset();
            if(gc.isInRoom())
            {
               gc.gameStart();
            }
         }
         else
         {
            daijishi = new DaoJiShi(this.countDownTimer.currentCount.toString());
            daijishi.x = 400;
            daijishi.y = 200;
            gc.gameInfo.addChild(daijishi);
         }
      }
      
      private function setNodeData(ba:ByteArray) : void
      {
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("--setAction(0x204)--获取节点信息:" + p);
         if(gc.nodeInfo)
         {
            gc.nodeInfo.roomName = p[0];
            gc.nodeInfo.GameMode = parseInt(p[1]);
            gc.nodeInfo.mpInfo = parseInt(p[2]);
            gc.nodeInfo.averLevel = parseInt(p[3]);
            gc.nodeInfo.singleIdPlayerNum = parseInt(p[4]);
         }
      }
      
      private function refreshOtherMutiUser(uid:uint, ba:ByteArray) : void
      {
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("--------------uid:" + uid + "--setAction(0x40):" + p);
         var roleId:int = parseInt(p[0]);
         var hp:int = parseInt(p[1]);
         var shp:int = parseInt(p[2]);
         var equipId:int = parseInt(p[3]);
         var weaponId:int = parseInt(p[4]);
         var level:int = parseInt(p[5]);
         var petName:String = p[6];
         var petHp:int = parseInt(p[7]);
         var petMp:int = parseInt(p[8]);
         var bmwId:int = parseInt(p[9]);
         var heroDef:uint = parseInt(p[10]);
         var heroMDef:Number = p[11];
         var petLevel:uint = parseInt(p[12]);
         var muti:MutiUser = gc.getMutiUserBySidAndRoleId(uid,roleId);
         var bh:BaseHero = gc.getHeroBySidAndRoleId(uid,roleId);
         if(muti && bh)
         {
            if(equipId != muti.equpId || weaponId != muti.weaponId)
            {
               bh.setCurClothId(equipId);
               bh.setCurWeaponId(weaponId);
               bh.refreshEquip();
            }
            if(gc.nodeInfo.isStartIng())
            {
               if(hp < muti.hp)
               {
                  bh.addHeroHurtMc(muti.hp - hp);
               }
               else if(hp > muti.hp)
               {
                  bh.addCureMc(hp - muti.hp);
               }
            }
            muti.hp = hp;
            muti.shp = shp;
            muti.equpId = equipId;
            muti.weaponId = weaponId;
            muti.level = level;
            muti.def = heroDef;
            muti.mDef = heroMDef;
         }
      }
      
      private function refreshOtherMutiUserHp(uid:uint, ba:ByteArray) : void
      {
         var roleId:int = ba.readByte();
         var hp:int = ba.readInt();
         var shp:int = ba.readInt();
         trace("--------------uid:" + uid + "--setAction(0x401):" + [roleId,hp,shp]);
         var muti:MutiUser = gc.getMutiUserBySidAndRoleId(uid,roleId);
         var bh:BaseHero = gc.getHeroBySidAndRoleId(uid,roleId);
         if(muti && bh)
         {
            if(gc.nodeInfo.isStartIng())
            {
               if(hp < muti.hp)
               {
                  bh.addHeroHurtMc(muti.hp - hp);
               }
               else if(hp > muti.hp)
               {
                  bh.addCureMc(hp - muti.hp);
               }
            }
            muti.hp = hp;
            muti.shp = shp;
         }
      }
      
      private function updateChat(uid:uint, ba:ByteArray) : void
      {
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("uid:" + uid + "--setAction(0x12)--聊天信息:" + p);
         var name:String = p[0];
         var info:String = p[1];
         if(name == gc.sid.toString())
         {
            name = "我";
         }
         gc.eventManger.dispatchEvent(new CommonEvent("NormalChat",[name,info]));
      }
      
      private function otherPetAttack(uid:uint, ba:ByteArray) : void
      {
         var params:* = null;
         var bp:* = null;
         var beAttacksid:int = 0;
         if(gc.isInHost())
         {
            return;
         }
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("uid:" + uid + "--setAction(0x13)--别的玩家宠物的子弹:" + p);
         var roleId:uint = parseInt(p[0]);
         var attackKind:String = p[1];
         var direct:uint = parseInt(p[2]);
         var point:Point = new Point();
         point.x = parseInt(p[3]);
         point.y = parseInt(p[4]);
         if(p[5] != "null")
         {
            params = p[5].toString().split("|");
         }
         if(uid == gc.sid)
         {
            return;
         }
         bp = gc.getPetBySidAndRoleId(uid,roleId);
         if(bp)
         {
            bp.setOtherAttack(attackKind,direct,point,params);
         }
      }
      
      private function otherPetAction(uid:uint, ba:ByteArray) : void
      {
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("uid:" + uid + "--setAction(0x14)--别的玩家宠物的行为:" + p);
         var roleId:uint = parseInt(p[0]);
         var action:String = p[1];
         var posX:Number = p[2];
         var posY:Number = p[3];
         var bp:BasePet = gc.getPetBySidAndRoleId(uid,roleId);
         if(bp)
         {
            bp.setOtherAction(action);
            bp.x = posX;
            bp.y = posY;
         }
      }
      
      private function otherBuff(uid:uint, ba:ByteArray) : void
      {
         if(gc.isInHost())
         {
            return;
         }
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("uid:" + uid + "--setAction(0x111)--别的玩家buff:" + p);
         var sid:int = parseInt(p[0]);
         var roleId:uint = parseInt(p[1]);
         var action:String = p[2].toString();
         var params:Array = p[3].toString().split("|");
         var bh:BaseHero = gc.getHeroBySidAndRoleId(sid,roleId);
         if(bh)
         {
            bh.setOtherBuff(action,params);
         }
      }
      
      private function otherAttack(uid:uint, ba:ByteArray) : void
      {
         var bh:* = null;
         var beAttackSid:int = 0;
         var bbm:* = null;
         bbm = null;
         if(gc.isInHost())
         {
            return;
         }
         var roleId:uint = ba.readByte();
         var attackKind:String = ActionStateConst.getInstence().getActionByState(ba.readByte());
         var direct:uint = ba.readByte();
         var point:Point = new Point();
         point.x = ba.readShort();
         point.y = ba.readShort();
         var paramsString:String = ba.readUTF();
         var params:Array = [];
         if(paramsString != "")
         {
            params = paramsString.split("|");
         }
         var initTimer:uint = ba.readInt();
         if(attackKind == "Role2Hit7")
         {
            if(gc.isInPk())
            {
               for each(var sid in params)
               {
                  beAttackSid = parseInt(sid);
                  bh = gc.getHeroBySidAndRoleId(beAttackSid,roleId) as BaseHero;
                  if(bh)
                  {
                     bh.setOtherAttack(attackKind,direct,point,params,initTimer);
                  }
               }
            }
            else if(gc.isInFuben())
            {
               for each(var entityId in params)
               {
                  bbm = gc.getMonsterById(parseInt(entityId));
                  if(bbm)
                  {
                     bbm.beAttackByRole2Hit7(point);
                  }
               }
            }
         }
         else if(attackKind == "Role3Hit6")
         {
            if(gc.isInPk())
            {
               for each(sid in params)
               {
                  beAttackSid = parseInt(sid);
                  bh = gc.getHeroBySidAndRoleId(beAttackSid,roleId) as BaseHero;
                  if(bh)
                  {
                     bh.setOtherAttack(attackKind,direct,point,params,initTimer);
                  }
               }
            }
            else if(gc.isInFuben())
            {
               for each(entityId in params)
               {
                  bbm = gc.getMonsterById(parseInt(entityId));
                  if(bbm)
                  {
                     bbm.beAttackByRole3Hit6(point);
                  }
               }
            }
         }
         else
         {
            if(uid == gc.sid)
            {
               return;
            }
            bh = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
            if(bh)
            {
               bh.setOtherAttack(attackKind,direct,point,params,initTimer);
            }
         }
         trace("uid:" + uid + "--setAction(0x11)--别的玩家子弹:" + "attackKind:" + attackKind + ",direct:" + direct + ",point:" + point + ",paramsString：" + paramsString + ",initTimer：" + initTimer);
      }
      
      private function showDelay(uid:uint) : void
      {
         var delay:uint = (getTimer() - gc.lastDelayTime) / 2;
         if(gc.hero1)
         {
            if(gc.honorData)
            {
               gc.hero1.setNameTextField(gc.honorData.nicheng + "  " + delay + " ms");
            }
            else
            {
               gc.hero1.setNameTextField(gc.sid + "P" + "  " + delay + " ms");
            }
         }
         if(gc.hero2)
         {
            if(gc.honorData)
            {
               gc.hero2.setNameTextField(gc.honorData.nicheng + "  " + delay + " ms");
            }
            else
            {
               gc.hero2.setNameTextField(gc.sid + "P" + "  " + delay + " ms");
            }
         }
         this.resetDelayCount();
      }
      
      private function runOther(uid:uint, ba:ByteArray) : void
      {
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("uid:" + uid + "--setAction(0x09)--跑:" + p);
         var roleId:uint = parseInt(p[0]);
         var isLeft:Boolean = p[1].toString() == "1" ? true : false;
         var isRight:Boolean = p[2].toString() == "1" ? true : false;
         if(uid == gc.sid)
         {
            return;
         }
         var bh:BaseHero = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
         if(bh)
         {
            trace("===============开始跑：" + bh);
            bh.doubleCount = 1;
            bh.isLeft = isLeft;
            bh.isRight = isRight;
            bh.setAction("run");
         }
      }
      
      private function deadOther(uid:uint, ba:ByteArray) : void
      {
         var afterdead:* = undefined;
         if(gc.isInHost())
         {
            return;
         }
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("uid:" + uid + "--setAction(0x07)-死亡:" + p);
         var roleId:uint = parseInt(p[0]);
         if(uid == gc.sid)
         {
            return;
         }
         var bhDead:BaseHero = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
         if(bhDead)
         {
            afterdead = AUtils.getNewObj("PlayerDeadMc");
            afterdead.x = bhDead.x;
            afterdead.y = bhDead.y;
            gc.gameSence.addChild(afterdead);
            bhDead.destroy();
         }
         this.removeHeroBySidAndRoleId(uid,roleId);
      }
      
      private function deadPetOther(uid:uint, ba:ByteArray) : void
      {
         if(gc.isInHost())
         {
            return;
         }
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("uid:" + uid + "--setAction(0x071)-宠物死亡:" + p);
         var roleId:uint = parseInt(p[0]);
         if(uid == gc.sid)
         {
            return;
         }
         var bhDead:BaseHero = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
         if(bhDead.getPet())
         {
            bhDead.getPet().destroy();
         }
      }
      
      private function hurtOtherPet(uid:uint, ba:ByteArray) : void
      {
         var bh:* = null;
         if(gc.isInHost())
         {
            return;
         }
         var p:Array = ba.readUTFBytes(ba.length).split(",");
         trace("uid:" + uid + "--setAction(0x061)--伤害:" + p);
         var roleId:String = p[0];
         var hurtRoleId:uint = parseInt(roleId.charAt(0));
         var sourceRoleId:uint = parseInt(roleId.charAt(1));
         var hurt:int = parseInt(p[1]);
         var sid:int = parseInt(p[2]);
         var action:String = p[3];
         var attackBackX:int = parseInt(p[4]);
         var attackBackY:int = parseInt(p[5]);
         var initTimer:uint = parseInt(p[6]);
         var isSetActionHurt:Boolean = parseInt(p[7]) == 1 ? true : false;
         var isNeedToAttackBack:Boolean = parseInt(p[8]) == 1 ? true : false;
         if(uid == gc.sid)
         {
            return;
         }
         if(sid != gc.sid)
         {
            bh = gc.getHeroBySidAndRoleId(sid,hurtRoleId);
         }
         else if(gc.hero1 && gc.hero1.getPlayer().roleid == hurtRoleId)
         {
            bh = gc.hero1;
         }
         else if(gc.hero2 && gc.hero2.getPlayer().roleid == hurtRoleId)
         {
            bh = gc.hero2;
         }
         var bhHurt:BaseHero = gc.getHeroBySidAndRoleId(uid,sourceRoleId) as BaseHero;
         if(initTimer > 0)
         {
            if(bhHurt)
            {
               for each(var bb in bhHurt.magicBulletArray)
               {
                  if(bb.initTimer == initTimer)
                  {
                     bb.reduceMaxAttackCount();
                  }
               }
            }
         }
         if(!bh || !bh.getPet())
         {
            return;
         }
         if(isNeedToAttackBack)
         {
            bh.getPet().setAttackBack(new Point(attackBackX,attackBackY));
            bh.getPet().addBeAttackEffectForOther();
         }
         bh.getPet().reduceHp(hurt,isSetActionHurt);
      }
      
      private function hurtOther(uid:uint, ba:ByteArray) : void
      {
         var bh:* = null;
         if(gc.isInHost())
         {
            return;
         }
         var roleId:String = ba.readByte().toString();
         var hurtRoleId:uint = parseInt(roleId.charAt(0));
         var sourceRoleId:uint = parseInt(roleId.charAt(1));
         var hurt:int = ba.readInt();
         var sid:int = ba.readInt();
         var action:String = ActionStateConst.getInstence().getActionByState(ba.readByte());
         var attackBackX:int = ba.readByte();
         var attackBackY:int = ba.readByte();
         var initTimer:int = ba.readInt();
         var isSetActionHurt:Boolean = ba.readByte() == 1 ? true : false;
         var isNeedToAttackBack:Boolean = ba.readByte() == 1 ? true : false;
         trace("uid:" + uid + "--setAction(0x06)--:" + uid + "-对玩家-" + sid + "造成伤害:" + hurt + ",action:" + action + ",attackBackX:" + attackBackX + ",attackBackY:" + attackBackY + ",initTimer:" + initTimer + ",isSetActionHurt:" + isSetActionHurt + ",isNeedToAttackBack:" + isNeedToAttackBack);
         if(uid == gc.sid)
         {
            return;
         }
         if(sid != gc.sid)
         {
            bh = gc.getHeroBySidAndRoleId(sid,hurtRoleId);
         }
         else if(gc.hero1 && gc.hero1.getPlayer().roleid == hurtRoleId)
         {
            bh = gc.hero1;
         }
         else if(gc.hero2 && gc.hero2.getPlayer().roleid == hurtRoleId)
         {
            bh = gc.hero2;
         }
         var bhHurt:BaseHero = gc.getHeroBySidAndRoleId(uid,sourceRoleId) as BaseHero;
         trace("bhHurt:" + bhHurt);
         if(initTimer > 0)
         {
            if(bhHurt)
            {
               for each(var bb in bhHurt.magicBulletArray)
               {
                  if(bb.initTimer == initTimer)
                  {
                     bb.reduceMaxAttackCount();
                  }
               }
            }
         }
         if(!bh)
         {
            return;
         }
         if(isNeedToAttackBack)
         {
            bh.setAttackBack(new Point(attackBackX,attackBackY));
            bh.beAttackDoing();
         }
         bh.reduceHp(hurt,isSetActionHurt);
         trace("uid:" + uid + "--setAction(0x06)--伤害:" + hurt);
      }
      
      private function faceToOther(uid:uint, ba:ByteArray) : void
      {
         if(uid == gc.sid)
         {
            return;
         }
         var roleId:uint = ba.readByte();
         var bh:BaseHero = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
         if(!bh)
         {
            return;
         }
         var isLeft:Boolean = ba.readByte() == 1 ? true : false;
         var isRight:Boolean = ba.readByte() == 1 ? true : false;
         if(!isLeft && !isRight)
         {
            if(bh.isLeft)
            {
               bh.stopMoveLeft();
            }
            if(bh.isRight)
            {
               bh.stopMoveRight();
            }
         }
         else
         {
            bh.isLeft = isLeft;
            bh.isRight = isRight;
            if(bh.isLeft)
            {
               bh.isRight = false;
               bh.getBBDC().turnLeft();
            }
            if(bh.isRight)
            {
               bh.isLeft = false;
               bh.getBBDC().turnRight();
            }
         }
         bh.doubleCount = 0;
         trace("uid:" + uid + "--setAction(0x05)--朝向:" + "roleId:" + roleId + ",isLeft:" + isLeft + ",isRight:" + isRight);
      }
      
      private function walkOther(uid:uint, ba:ByteArray) : void
      {
         if(uid == gc.sid)
         {
            return;
         }
         var roleId:uint = ba.readByte();
         var bh:BaseHero = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
         if(!bh)
         {
            return;
         }
         var jumpCount:int = bh.getJumpCount();
         var action:String = ActionStateConst.getInstence().getActionByState(ba.readByte());
         switch(action)
         {
            case "jump1":
               if(jumpCount != 2)
               {
                  if(bh.getBBDC().getState() != "jump1" && bh.getBBDC().getState() != "jump2")
                  {
                     bh.doJump();
                     bh.setAction(action);
                  }
               }
               break;
            case "jump2":
               if(jumpCount != 2)
               {
                  if(bh.getBBDC().getState() != "jump2")
                  {
                     bh.doJump();
                     bh.setAction(action);
                  }
               }
         }
         var left:int = ba.readByte();
         var right:int = ba.readByte();
         bh.isLeft = left == 1 ? true : false;
         bh.isRight = right == 1 ? true : false;
         trace("uid:" + uid + "--setAction(0x04)--移动其他角色->roleId:" + roleId + ",action:" + action + ",left:" + left + ",right:" + right);
      }
      
      private function moveOther(uid:uint, ba:ByteArray) : void
      {
         if(uid == gc.sid)
         {
            return;
         }
         var roleId:uint = ba.readByte();
         var bh:BaseHero = gc.getHeroBySidAndRoleId(uid,roleId) as BaseHero;
         if(!bh)
         {
            return;
         }
         var state:int = ba.readByte();
         var xx:int = ba.readShort();
         var yy:int = ba.readShort();
         var action:String = ActionStateConst.getInstence().getActionByState(state);
         if(action == "wait")
         {
            bh.setStatic();
         }
         bh.setAction(action);
         bh.x = xx;
         bh.y = yy;
         var left:int = ba.readByte();
         var right:int = ba.readByte();
         bh.isLeft = left == 1 ? true : false;
         bh.isRight = right == 1 ? true : false;
         trace("uid:" + uid + "--setAction(0x03)--操作其他角色->roleId:" + roleId + ",action:" + action + ",xx:" + xx + ",yy:" + yy + ",left:" + left + ",right:" + right);
      }
      
      override public function step() : void
      {
         var len:* = 0;
         var ou:* = null;
         var bh:* = null;
         var averagePosX:Number = NaN;
         var averagePosY:Number = NaN;
         var i:int = 0;
         var point:* = null;
         super.step();
         if(delayCount > 0)
         {
            delayCount--;
            if(delayCount == 0)
            {
               gc.getDelay();
               delayCount = -1;
            }
         }
         if(gc.isInRoom())
         {
            if(gc.nodeInfo)
            {
               gc.nodeInfo.step();
            }
         }
         if(iii > 0)
         {
            iii--;
         }
         if(gc.isInHost())
         {
            if(iii == 0)
            {
               if(gc.gameInfo && !gc.gameInfo.getIsHideOther())
               {
                  len = uint(gc.pWorld.getOtherHeroUserArray().length);
                  averagePosX = 0;
                  averagePosY = 0;
                  if(gc.hero1)
                  {
                     averagePosX += gc.hero1.x;
                     averagePosY += gc.hero1.y;
                  }
                  if(gc.hero2)
                  {
                     averagePosX += gc.hero2.x;
                     averagePosY += gc.hero2.y;
                  }
                  averagePosX /= gc.getPlayerArray().length;
                  averagePosY /= gc.getPlayerArray().length;
                  for(i = 0; i < len; )
                  {
                     ou = gc.pWorld.getOtherHeroUserArray()[i] as MutiUser;
                     if(ou.sid != gc.sid)
                     {
                        bh = gc.getHeroBySidAndRoleId(ou.sid,ou.roleId);
                        if(bh)
                        {
                           point = gc.gameSence.localToGlobal(new Point(bh.x,bh.y));
                           if(point.x <= 0 || point.x >= 940 || point.y <= 0 || point.y >= 590)
                           {
                              bh.getBBDC().hide();
                              if(bh.getPet())
                              {
                                 bh.getPet().getBBDC().hide();
                              }
                              if(bh.getCurMagicWeapon())
                              {
                                 bh.getCurMagicWeapon().getBBDC().hide();
                              }
                           }
                           else
                           {
                              bh.getBBDC().show();
                              if(bh.getPet())
                              {
                                 bh.getPet().getBBDC().show();
                              }
                              if(bh.getCurMagicWeapon())
                              {
                                 bh.getCurMagicWeapon().getBBDC().show();
                              }
                           }
                        }
                     }
                     i++;
                  }
               }
               iii = gc.frameClips * 2;
            }
         }
      }
      
      private function changeMapByMapInfo() : void
      {
         switch(gc.nodeInfo.mpInfo)
         {
            case 1001:
               gc.curStageAndCurLevel.curStage = 0;
               gc.curStageAndCurLevel.curLevel = 2;
               break;
            case 2001:
               gc.curStageAndCurLevel.curStage = 0;
               gc.curStageAndCurLevel.curLevel = 3;
               break;
            case 2002:
               gc.curStageAndCurLevel.curStage = 0;
               gc.curStageAndCurLevel.curLevel = 4;
               break;
            case 2003:
               gc.curStageAndCurLevel.curStage = 0;
               gc.curStageAndCurLevel.curLevel = 5;
         }
         gc.pWorld.mutiMapChange();
      }
      
      private function changeMapToHost() : void
      {
         gc.curStageAndCurLevel.curStage = 0;
         gc.curStageAndCurLevel.curLevel = 1;
         gc.pWorld.mutiMapChange();
      }
      
      private function resetDelayCount() : void
      {
         this.delayCount = gc.frameClips * 2;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.tw1)
         {
            this.tw1.kill();
            this.tw1 = null;
         }
         if(this.countDownTimer)
         {
            this.countDownTimer.stop();
            this.countDownTimer.removeEventListener("timer",__countDownTimer);
            this.countDownTimer = null;
         }
         if(servers)
         {
            servers.removeEventListener("complete",onXML);
            servers.removeEventListener("ioError",onXML);
            servers.removeEventListener("securityError",onXML);
         }
      }
   }
}
