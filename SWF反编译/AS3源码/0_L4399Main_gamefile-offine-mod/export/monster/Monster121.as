package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.hero.Role1Shadow;
   import export.rank.RankUser;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import loader.PlayerAssetsLoaderManager;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   
   public class Monster121 extends BaseMonster
   {
       
      
      private var hit11Count:uint = 35;
      
      private var shallowArray:Array;
      
      private var _equipId:uint = 0;
      
      private var _weaponId:uint = 0;
      
      private var gxpCount:uint = 0;
      
      private var curSkillArray:Array;
      
      private var skillKind:uint = 0;
      
      private var skillKindArray:Array;
      
      public var fightingScoreDiff:Number = 0.1;
      
      private var mm:MusicManager;
      
      private var shallowCount:uint = 4;
      
      public function Monster121(ru:RankUser)
      {
         shallowArray = [];
         curSkillArray = [];
         skillKindArray = [["hit6","hit13"],["hit9","hit13"],["hit12","hit9","hit8"]];
         var equipId:uint = 1;
         var weaponId:uint = 1;
         var equipArray:Array = ru.curEquipArray;
         for each(var eq in equipArray)
         {
            if(eq.type == "zbwq")
            {
               weaponId = eq.showid;
            }
            else if(eq.type == "zbfj")
            {
               equipId = eq.showid;
            }
         }
         for each(eq in equipArray)
         {
            if(eq.type == "zbsz")
            {
               equipId = eq.showid;
               break;
            }
         }
         this._equipId = equipId;
         this._weaponId = weaponId;
         super();
         mm = MusicManager.getInstance();
         this.horizenSpeed = 5;
         this.setHp(ru.getHp());
         this.setSHp(this.getHp());
         this.setMiss(ru.getMiss() / 100);
         this.setCrit(ru.getCrit() / 100);
         this.setEatBlood(ru.getEatBlood() / 100);
         this._anti.def = ru.getDefense();
         this._anti.mDef = ru.getMagicDef() / 100;
         var baseHurt:uint = ru.getAtk();
         this.normalAttackRate = 0;
         this.attackRange = 250;
         this.alertRange = 1000;
         this.normalAttackRate = 0.8;
         this.gxpCount = gc.frameClips * 10;
         this._anti.exp = 0;
         this._anti.gxp = 0;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-2,-3],
            "attackInterval":999,
            "power":baseHurt,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[-0.5,-3],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[-0.5,-3],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-3],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-2],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-14,-25],
            "attackInterval":999,
            "power":baseHurt * 2,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":4,
            "power":baseHurt * 0.5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-2],
            "attackInterval":3,
            "power":baseHurt * 1.2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":100,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-2,-2],
            "attackInterval":5,
            "power":baseHurt * 0.5,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit10_3"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,20],
            "attackInterval":5,
            "power":baseHurt * 0.5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10_4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-15],
            "attackInterval":999,
            "power":baseHurt * 3,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-20,0],
            "attackInterval":5,
            "power":baseHurt * 0.6,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-25],
            "attackInterval":5,
            "power":baseHurt * 0.6,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":5,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit13"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":baseHurt * 0.24,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit14"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-20,0],
            "attackInterval":999,
            "power":baseHurt * 5,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
         this.skillCD1 = [gc.frameClips * 2,gc.frameClips * 3];
         this.skillKind = RandomControllor.getIns().getRandom() * this.skillKindArray.length;
         this.curSkillArray = this.skillKindArray[this.skillKind] as Array;
         var ttf:TextFormat = new TextFormat();
         ttf.size = 20;
         nameTextField.defaultTextFormat = ttf;
         nameTextField.y = -this.colipse.height / 2 - 30;
         nameTextField.x = -this.colipse.width / 2 - 30;
         nameTextField.selectable = false;
         nameTextField.autoSize = "center";
         nameTextField.cacheAsBitmap = true;
         nameTextField.text = ru.getUserName();
         nameTextField.height = nameTextField.textHeight + 5;
         nameTextField.width = nameTextField.textWidth + 10;
         this.addChild(nameTextField);
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      override protected function initBBDC() : void
      {
         var assetsArray:* = null;
         if(!bbdc)
         {
            bbdc = new BaseBitmapDataClip(this.getAssetsArray("ROLE1"),200,200,new Point(0,0));
            bbdc.setOffsetXY(5,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[5,5],[4,4,4,4],[2,2,2,2],[1,1,10,100,hit11Count,hit11Count],[2,2,2,2,2],[2,2,1,1,3],[1,1,1,1,5],[1,1,1,1,12],[2,2,1,1,10],[2,2,1,6],[2,3,2,3],[17,15,8,10],[2,12,16]]);
            bbdc.setFrameCount([36,8,4,4,[1,1,1,1,1,1],5,5,5,5,5,4,4,[1,1,1,1],3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
         }
         else
         {
            assetsArray = this.getAssetsArray("ROLE1");
            for each(var obj in assetsArray)
            {
               if(obj.name == "body")
               {
                  this.bbdc.replaceBitmapDataByName("body",obj.source);
               }
               else if(obj.name == "equip")
               {
                  this.bbdc.replaceBitmapDataByName("equip",obj.source);
               }
            }
         }
      }
      
      protected function getAssetsArray(roleName:String) : Array
      {
         var equipName:* = null;
         var weaponName:* = null;
         var body:* = null;
         var equip:* = null;
         var bodyId:uint = this._equipId;
         var weaponId:uint = this._weaponId;
         var assetsArray:Array = [];
         equipName = roleName + "_" + bodyId;
         weaponName = roleName + "_EQUIP_" + weaponId;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName(equipName);
         var eqArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName(weaponName);
         if(!bmdArray)
         {
            body = {
               "name":"body",
               "source":[]
            };
            PlayerAssetsLoaderManager.getInstance().addSingle(equipName + ".swf",assetsLoadComplete);
         }
         else
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
         }
         assetsArray.push(body);
         if(!eqArray)
         {
            equip = {
               "name":"equip",
               "source":[]
            };
            PlayerAssetsLoaderManager.getInstance().addSingle(weaponName + ".swf",assetsLoadComplete);
         }
         else
         {
            equip = {
               "name":"equip",
               "source":eqArray
            };
         }
         assetsArray.push(equip);
         return assetsArray;
      }
      
      protected function assetsLoadComplete() : void
      {
         this.initBBDC();
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         str = str;
         super.setAction(str);
         if(str != "hit14")
         {
            this.bbdc.setOffsetXY(5,-15);
         }
         else
         {
            this.bbdc.setOffsetXY(5,-30);
         }
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "wait2":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "walk":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "run":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "jump1":
               if(curPoint.x != 0 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "jump2":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "jump3":
               if(curPoint.x != 1 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(curPoint.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(str);
               break;
            case "hit6":
               if(curPoint.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(str);
               break;
            case "hit7":
               if(curPoint.x != 1 || curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit8":
               if(curPoint.y != 11)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(11);
               }
               this.bbdc.setState(str);
               break;
            case "hit9":
               if(curPoint.x != 2 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit10":
               if(curPoint.x != 3 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit11_1":
               if(curPoint.x != 4 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit11_2":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit12":
               if(curPoint.x != 0 || curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit13":
               if(curPoint.x != 3 || curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit14":
               if(curPoint.x != 0 || curPoint.y != 13)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(13);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               this.getBBDC().show();
               this.resetGraity();
               if(curPoint.x == 2 && curPoint.y == 12)
               {
                  this.getBBDC().resetCurFrameStopCount();
               }
               else
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.setStatic();
               TweenMax.to(this,1,{
                  "alpha":0,
                  "onComplete":function(_self:BaseMonster):*
                  {
                     _self.dropAura();
                     _self.destroy();
                  },
                  "onCompleteParams":[this]
               });
               this.bbdc.setState(str);
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var rand:Number = NaN;
         rand = NaN;
         rand = NaN;
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "run":
               this.bbdc.setFramePointX(0);
               break;
            case "wait":
               this.setAction("wait2");
               break;
            case "wait2":
               this.setAction("wait");
               break;
            case "jump1":
               this.bbdc.setFramePointX(0);
               break;
            case "jump2":
               this.setAction("jump3");
               break;
            case "jump3":
               this.bbdc.setFramePointX(1);
               break;
            case "hit1":
               this.setAction("wait");
               break;
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hit6":
               if(this.skillKind == 0)
               {
                  if(RandomControllor.getIns().getRandom() < 0.8)
                  {
                     this.setAction("hit10");
                     this.lastHit = "hit10";
                  }
                  else
                  {
                     this.bbdc.setFramePointX(0);
                  }
               }
               else if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit7":
               this.setStatic();
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit8":
               if(this.skillKind == 2)
               {
                  rand = RandomControllor.getIns().getRandom();
                  if(rand < 0.6)
                  {
                     this.bbdc.setFramePointX(0);
                  }
                  if(rand < 0.7)
                  {
                     this.setAction("hit11_1");
                     this.lastHit = "hit11_1";
                  }
               }
               else if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit9":
               this.getBBDC().show();
               if(this.skillKind == 1)
               {
                  rand = RandomControllor.getIns().getRandom();
                  if(rand < 0.1)
                  {
                     this.bbdc.setFramePointX(0);
                  }
                  else if(!this.isInSky())
                  {
                     this.setAction("wait");
                  }
                  else
                  {
                     this.setAction("jump3");
                  }
               }
               else if(this.skillKind == 2)
               {
                  rand = RandomControllor.getIns().getRandom();
                  if(rand < 0.6)
                  {
                     this.bbdc.setFramePointX(0);
                  }
                  else if(rand < 0.7)
                  {
                     this.setAction("hit11_1");
                     this.lastHit = "hit11_1";
                  }
                  else if(!this.isInSky())
                  {
                     this.setAction("wait");
                  }
                  else
                  {
                     this.setAction("jump3");
                  }
               }
               else if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit10":
               this.hit10Over();
               break;
            case "hit11_1":
               this.hit11Over();
               break;
            case "hit11_2":
               this.hit11Over();
               break;
            case "hit12":
               if(this.skillKind == 2)
               {
                  if(RandomControllor.getIns().getRandom() < 0.3)
                  {
                     this.bbdc.setFramePointX(0);
                  }
                  else
                  {
                     this.setAction("wait");
                  }
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit13":
               if(this.skillKind == 0)
               {
                  if(RandomControllor.getIns().getRandom() < 0.9)
                  {
                     this.setAction("hit14");
                     this.lastHit = "hit14";
                  }
                  else
                  {
                     this.bbdc.setFramePointX(0);
                  }
               }
               else if(this.skillKind == 1)
               {
                  if(RandomControllor.getIns().getRandom() < 0.5)
                  {
                     this.setAction("hit8");
                     this.lastHit = "hit8";
                  }
                  else
                  {
                     this.setAction("hit14");
                     this.lastHit = "hit14";
                  }
               }
               else if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit14":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var fsc:* = null;
         var count:* = 0;
         var state:String = this.bbdc.getState();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(this.bbdc.getCurFrameCount() == 1)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 120;
                     }
                     else
                     {
                        point.x = this.x + 120;
                     }
                     point.y = this.y + 5;
                     this.doHit1(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit2":
               if(this.bbdc.getCurFrameCount() == 1)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 30;
                     }
                     else
                     {
                        point.x = this.x + 30;
                     }
                     point.y = this.y - 110;
                     this.doHit3(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit3":
               if(this.bbdc.getCurFrameCount() == 1)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 160;
                     }
                     else
                     {
                        point.x = this.x + 160;
                     }
                     point.y = this.y - 10;
                     this.doHit4(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit4":
               if(this.bbdc.getCurFrameCount() == 1)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 165;
                     }
                     else
                     {
                        point.x = this.x + 165;
                     }
                     point.y = this.y - 20;
                     this.doHit5(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit5":
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 1)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 30;
                     }
                     else
                     {
                        point.x = this.x + 30;
                     }
                     point.y = this.y + 40;
                     this.doHit6(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit6":
               if(this.bbdc.getCurFrameCount() == 15)
               {
                  if(p.x == 1)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 175;
                     }
                     else
                     {
                        point.x = this.x + 175;
                     }
                     point.y = this.y - 30;
                     this.doHit7(this.getBBDC().getDirect(),point);
                  }
               }
               if(this.bbdc.getDirect() == 0)
               {
                  this.speed.x = -25 * this.bbdc.getCurFrameCount() / 15;
               }
               else
               {
                  this.speed.x = 25 * this.bbdc.getCurFrameCount() / 15;
               }
               break;
            case "hit7":
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x + 20;
                     }
                     else
                     {
                        point.x = this.x - 20;
                     }
                     point.y = this.y + 30;
                     this.doHit8(this.getBBDC().getDirect(),point);
                  }
               }
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 0)
                  {
                     for each(var r1s in this.shallowArray)
                     {
                        if(r1s)
                        {
                           if(!r1s.isReadyToDestroy)
                           {
                              r1s.setAction("hit1");
                           }
                        }
                     }
                  }
               }
               break;
            case "hit8":
               if(this.bbdc.getCurFrameCount() == 10)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 120;
                     }
                     else
                     {
                        point.x = this.x + 120;
                     }
                     point.y = this.y - 50;
                     this.doHit9(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit9":
               if(this.bbdc.getCurFrameCount() == 100)
               {
                  if(p.x == 3)
                  {
                     point = new Point(0,0);
                     this.doHit10_1(this.getBBDC().getDirect(),point);
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 95)
               {
                  if(p.x == 3)
                  {
                     point = new Point(this.x - 10,this.y);
                     this.doHit10_2(this.getBBDC().getDirect(),point);
                  }
               }
               if(this.lastHit == "hit10_3")
               {
                  if(this.standInObj)
                  {
                     this.doHit10_4(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit10":
               if(this.bbdc.getCurFrameCount() == hit11Count)
               {
                  if(p.x == 4)
                  {
                     this.doHit11_1(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit11_1":
               fsc = this.bbdc.getFrameStopCount();
               count = uint(fsc[4][5]);
               if(this.bbdc.getCurFrameCount() == count)
               {
                  if(p.x == 5)
                  {
                     this.doHit11_2(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit11_2":
               if(this.bbdc.getCurFrameCount() == 17)
               {
                  if(p.x == 0)
                  {
                     this.doHit12_1(this.getBBDC().getDirect(),point);
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 1)
               {
                  if(p.x == 0)
                  {
                     this.doHit12_2(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit12":
               if(p.x == 3)
               {
                  point.x = this.x;
                  point.y = this.y;
                  this.checkHit13(this.getBBDC().getDirect(),point);
               }
               break;
            case "hit13":
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x;
                     }
                     else
                     {
                        point.x = this.x;
                     }
                     point.y = this.y - 85;
                     this.doHit14_1(this.getBBDC().getDirect(),point);
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 16)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 145;
                     }
                     else
                     {
                        point.x = this.x + 145;
                     }
                     point.y = this.y - 60;
                     this.doHit14_2(this.getBBDC().getDirect(),point);
                  }
               }
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 0)
                  {
                     for each(r1s in this.shallowArray)
                     {
                        if(r1s)
                        {
                           if(!r1s.isReadyToDestroy)
                           {
                              r1s.setAction("hit2");
                           }
                        }
                     }
                  }
               }
               this.speed.y = 0;
               break;
            case "hit14":
         }
      }
      
      private function doHit1(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet3");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet4");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet5");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit6(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit6");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit7(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit7");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet7");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function doHit8(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit8");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet8");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit8");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit9");
         this.getBBDC().hide();
         this.setYourFather(11);
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet9");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -40;
         }
         else
         {
            this.speed.x = 40;
         }
      }
      
      private function doHit10_1(direct:uint, p:Point) : void
      {
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -28;
         }
         else
         {
            this.speed.x = 28;
         }
         this.speed.y = -35;
         this.setYourFather(5);
      }
      
      private function doHit10_2(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role1_hit10_2");
         this.setStatic();
         this.speed.y = 0;
         this.setLostGraity();
         this.getBBDC().hide();
         var bmLen:uint = gc.getPlayerArray().length;
         for(var i:uint = 0; i < bmLen; )
         {
            var bm:BaseObject = gc.getPlayerArray()[i] as BaseObject;
            if(AUtils.GetDisBetweenTwoObj(this,bm) < 100)
            {
               this.setYourFather(45);
               var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet10_2");
               b.x = p.x;
               b.y = p.y;
               b.setRole(this);
               b.setDirect(direct);
               b.setAction("hit10_2");
               this.lastHit = "hit10_2";
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
               TweenMax.delayedCall(1.9,function(_self:Monster121, _direct:uint, _p:Point):*
               {
                  _self.doHit10_3(_direct,_p);
               },[this,direct,p]);
               return;
            }
            i++;
         }
         this.doHit10_3(direct,p);
      }
      
      private function doHit10_3(direct:uint, p:Point) : void
      {
         this.setYourFather(80);
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet10_3");
         b.x = this.x;
         b.y = this.y - 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10_3");
         this.lastHit = "hit10_3";
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         this.setYourFather(60);
         this.resetGraity();
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -40;
         }
         else
         {
            this.speed.x = 40;
         }
         this.speed.y = 40;
      }
      
      private function doHit10_4(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role1_hit10_4");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet10_4");
         b.x = this.x;
         b.y = this.y + 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10_4");
         this.lastHit = "hit10_4";
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         gc.vControllor.shake(25);
         this.setStatic();
         this.setYourFather(10);
         TweenMax.delayedCall(0.45,function(_self:Monster121):*
         {
            _self.hit10Over();
         },[this]);
      }
      
      private function hit10Over() : void
      {
         this.getBBDC().show();
         this.setAction("wait");
      }
      
      private function hit11Over() : *
      {
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Role1Bullet11_1" || bb.getImcName() == "Role1Bullet11_2")
            {
               bb.destroy();
            }
         }
         this.resetGraity();
         this.speed.y = 0;
         if(!this.isInSky())
         {
            this.setAction("wait");
         }
         else
         {
            this.setAction("jump3");
         }
      }
      
      private function doHit11_1(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit11");
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -25;
         }
         else
         {
            this.speed.x = 25;
         }
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet11_1");
         if(this.bbdc.getDirect() == 0)
         {
            b.x = this.x - 50;
         }
         else
         {
            b.x = this.x + 50;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit11_1");
         this.lastHit = "hit11_1";
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit11_2(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit11");
         this.speed.x = 0;
         this.speed.y = -25;
         this.setLostGraity();
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Role1Bullet11_1")
            {
               bb.destroy();
            }
         }
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet11_2");
         if(this.bbdc.getDirect() == 0)
         {
            b.x = this.x;
         }
         else
         {
            b.x = this.x;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit11_2");
         this.lastHit = "hit11_2";
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12_1(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit12_1");
         var mc1:MovieClip = AUtils.getNewObj("Role1Bullet12_1_1") as MovieClip;
         var mc2:MovieClip = AUtils.getNewObj("Role1Bullet12_1_2") as MovieClip;
         if(this.bbdc.getDirect() == 0)
         {
            mc1.x = this.x - 22;
         }
         else
         {
            mc1.x = this.x + 21;
            AUtils.flipHorizontal(mc1,-1);
         }
         mc1.y = this.y - 10;
         if(this.bbdc.getDirect() == 0)
         {
            mc2.x = this.x - 55;
         }
         else
         {
            mc2.x = this.x - 65;
         }
         mc2.y = this.y;
         gc.gameSence.addChild(mc1);
         gc.gameSence.addChild(mc2);
      }
      
      private function doHit12_2(direct:uint, p:Point) : void
      {
         var target:* = null;
         var bo:* = null;
         var i:* = 0;
         var dis:Number = 9999;
         var bmLen:uint = gc.getPlayerArray().length;
         for(i = uint(0); i < bmLen; i++)
         {
            bo = gc.getPlayerArray()[i] as BaseObject;
            if(this.getBBDC().getDirect() == 0)
            {
               if(bo.x > this.x)
               {
                  continue;
               }
            }
            else if(bo.x < this.x)
            {
               continue;
            }
            if(dis > AUtils.GetDisBetweenTwoObj(this,bo))
            {
               dis = AUtils.GetDisBetweenTwoObj(this,bo);
               target = bo;
            }
         }
         if(target)
         {
            this.hit12Boom(target,this,3);
         }
      }
      
      private function hit12Boom(_target:BaseObject, _self:Monster121, times:uint) : void
      {
         _target = _target;
         _self = _self;
         times = times;
         if(times > 0)
         {
            if(!this.isDead())
            {
               mm.play("Role1_hit12_2");
               var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet12");
               b.x = _target.x;
               b.y = _target.y;
               b.setRole(_self);
               b.setDirect(_self.getBBDC().getDirect());
               b.setAction("hit12");
               gc.gameSence.addChild(b);
               _self.magicBulletArray.push(b);
               times--;
               TweenMax.delayedCall(2,function(__target:BaseObject, __self:Monster121, _times:uint):*
               {
                  _self.hit12Boom(__target,__self,_times);
               },[_target,_self,times]);
            }
            else
            {
               var times:uint = 0;
            }
         }
      }
      
      private function otherShowHit12(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet12");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setDisable();
         b.setAction("hit12_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function checkHit13(direct:uint, point:Point) : void
      {
         var newPoint:* = null;
         mm.play("Role1_hit13_1");
         this.curAction = "hit13";
         if(direct == 0)
         {
            this.speed.x = -30;
         }
         else
         {
            this.speed.x = 30;
         }
         for each(var bm in gc.getPlayerArray())
         {
            if(this.colipse.hitTestObject(bm.colipse))
            {
               trace("击中");
               newPoint = new Point();
               newPoint.x = bm.x;
               newPoint.y = bm.y;
               this.doHit13(this.getBBDC().getDirect(),newPoint);
               return;
            }
         }
      }
      
      private function doHit13(direct:uint, point:Point) : void
      {
         direct = direct;
         point = point;
         mm.play("Role1_hit13_2");
         this.curAction = "hit13";
         this.getBBDC().stopFrame();
         this.setStatic();
         this.getBBDC().hide();
         if(this.skillKind == 0 || this.skillKind == 1)
         {
            TweenMax.delayedCall(1.25,function(_self:Monster121):*
            {
               _self.getBBDC().continueFrame();
               _self.getBBDC().show();
            },[this]);
         }
         else
         {
            TweenMax.delayedCall(1.25,function(_self:Monster121):*
            {
               _self.setAction("wait");
               _self.getBBDC().continueFrame();
               _self.getBBDC().show();
            },[this]);
         }
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet13");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit13");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function createShallow(direct:uint = 0, point:Point = null) : void
      {
         var p:* = null;
         trace("Role1-》产生分身");
         if(!point)
         {
            p = new Point();
            p.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 150;
            p.y = this.y;
         }
         else
         {
            p = point;
         }
         var r1s:Role1Shadow = new Role1Shadow(this);
         if(this.getBBDC().getDirect() == 1)
         {
            r1s.getBBDC().turnRight();
         }
         r1s.x = p.x;
         r1s.y = p.y;
         gc.gameSence.addChild(r1s);
         this.shallowArray.push(r1s);
         this.skillCD1[1] = gc.frameClips * 1.5;
      }
      
      public function doHit14_1(direct:uint, point:Point) : void
      {
         mm.play("Role1_hit14");
         this.curAction = "hit14";
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet14_1");
         if(direct == 0)
         {
            b.x = point.x + 15;
         }
         else
         {
            b.x = point.x - 15;
         }
         b.y = point.y;
         b.setDisable();
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit14");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function doHit14_2(direct:uint, point:Point) : void
      {
         this.curAction = "hit14";
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet14_2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit14");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         trace("this.curSkillArray:" + this.curSkillArray);
         var randSkil:String = this.curSkillArray[int(RandomControllor.getIns().getRandom() * this.curSkillArray.length)];
         trace("释放技能：" + randSkil);
         this.faceToTarget();
         this.setAction(randSkil);
         this.lastHit = randSkil;
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(this.isGXP)
         {
            if(this.shallowCount > 0)
            {
               this.shallowCount--;
            }
            if(this.shallowCount == 0)
            {
               AUtils.shallowEffect(this);
               this.shallowCount = 4;
            }
         }
         if(this.gxpCount > 0)
         {
            this.gxpCount--;
            if(this.gxpCount == 0)
            {
               this.turnToGXP();
               this.gxpCount = gc.frameClips * 20;
               TweenMax.delayedCall(10,function(_self:Monster121):*
               {
                  _self.turnToNormal();
               },[this]);
            }
         }
         var len:uint = this.shallowArray.length;
         for(var i:uint = 0; i < len; )
         {
            var r1s:Role1Shadow = this.shallowArray[i] as Role1Shadow;
            if(r1s)
            {
               if(r1s.isReadyToDestroy)
               {
                  this.shallowArray[i] = null;
               }
               else
               {
                  r1s.step();
               }
            }
            i++;
         }
         if(this.curAction == "run")
         {
            this.horizenSpeed = 10;
         }
         else
         {
            this.horizenSpeed = 5;
         }
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function doWhenSetYourFatherByFatherCount() : void
      {
         trace("doWhenSetYourFatherByFatherCount:" + doWhenSetYourFatherByFatherCount);
         this.faceToTarget();
         if(this.skillKind == 0)
         {
            this.setAction("hit13");
            this.lastHit = "hit13";
         }
         else
         {
            this.setAction("hit9");
            this.lastHit = "hit9";
         }
      }
      
      override protected function move() : void
      {
         if(this.isCanMoveByStage())
         {
            super.move();
         }
      }
      
      override protected function turnToGXP() : void
      {
         this.isGXP = true;
         this.graity = 3.75;
         this.horizenSpeed *= 1.5;
      }
      
      protected function turnToNormal() : void
      {
         this.isGXP = false;
         this.graity = 1.5;
         this.horizenSpeed /= 1.5;
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(!this.isGXP)
         {
            super.setAttackBack(p);
         }
      }
      
      override public function cureHp(addHp:int) : void
      {
         if(gc.isInWeiPk())
         {
            addHp *= 1.2 - this.fightingScoreDiff;
            if(addHp <= 0)
            {
               addHp = 1;
            }
         }
         super.cureHp(addHp);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(gc.isInWeiPk())
         {
            re *= this.fightingScoreDiff;
            if(re < 1)
            {
               re = 1;
            }
         }
         if(this.isGXP)
         {
            canHurt = false;
         }
         super.reduceHp(re,canHurt);
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" && this.getJumpCount() == 0 || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit8" || this.curAction == "hit14";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11_1" || this.curAction == "hit11_2" || this.curAction == "hit12" || this.curAction == "hit13" || this.curAction == "hit14";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit14" || this.curAction == "hit12";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit7" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11_1" || this.curAction == "hit11_2" || this.curAction == "hit13";
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.getHp() <= 0)
         {
            for each(var r1s in this.shallowArray)
            {
               if(r1s)
               {
                  r1s.destroy();
               }
            }
            this.shallowArray.length = 0;
         }
      }
   }
}
