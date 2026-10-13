package export.hero
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import config.HeroSkillProtect;
   import event.CommonEvent;
   import export.RoleInfo;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.monster.MonsterRole4Hit5;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class Role4 extends BaseHero
   {
       
      
      private var hit11Biaoji:SpecialEffectBullet;
      
      private var hit11BiaojiCount:uint;
      
      private var curHit11BiaojiCount:uint = 0;
      
      private var role4Hit5:MonsterRole4Hit5;
      
      public var isNotArrow:Boolean = true;
      
      private var hit12Dict:Dictionary;
      
      private var mm:MusicManager;
      
      public function Role4()
      {
         hit12Dict = new Dictionary();
         super();
         mm = MusicManager.getInstance();
         roleName = "沙僧";
         userType = "沙僧";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[2,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit1Arrow"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2Arrow"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":5,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":7,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-3],
            "attackInterval":12,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 8,
               "power":10
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit4Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-3],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 8,
               "power":10
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 4,
               "power":20
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit8"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-25],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,0],
            "attackInterval":4,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-2],
            "attackInterval":8,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":7,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-5,-2],
            "attackInterval":20,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12Arrow"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-5,-2],
            "attackInterval":10,
            "attackKind":"magic"
         };
         nameTextField.y = -this.colipse.height / 2 - 20;
         nameTextField.x = -this.colipse.width / 2 - 30;
         nameTextField.selectable = false;
         nameTextField.autoSize = "center";
         nameTextField.cacheAsBitmap = true;
         this.addChild(nameTextField);
         this.hit11BiaojiCount = gc.frameClips * 10;
      }
      
      override public function initPopertits() : void
      {
         super.initPopertits();
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 4,
               "power":0.5 * this.roleProperies.getHurt()
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
      }
      
      override protected function getBodyEquipAssetsName() : String
      {
         var bodyId:uint = this.getCurClothId();
         var weaponId:uint = this.getCurWeaponId();
         if(!(weaponId == 4 || weaponId == 5 || weaponId == 7 || weaponId == 8 || weaponId == 9))
         {
            this.isNotArrow = true;
            return "ROLE4_SHOVEL_" + bodyId;
         }
         this.isNotArrow = false;
         return "ROLE4_ARROW_" + bodyId;
      }
      
      override protected function getWeaponAssetsName() : String
      {
         return "ROLE4_EQUIP_" + this.getCurWeaponId();
      }
      
      override protected function initBBDC() : void
      {
         var assetsArray:* = null;
         var weaponId:uint = this.getCurWeaponId();
         trace("initBBDC");
         if(!(weaponId == 4 || weaponId == 5 || weaponId == 7 || weaponId == 8 || weaponId == 9))
         {
            this.isNotArrow = true;
         }
         else
         {
            this.isNotArrow = false;
         }
         if(bbdc)
         {
            assetsArray = this.getAssetsArray("ROLE4");
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
         else
         {
            bbdc = new BaseBitmapDataClip(this.getAssetsArray("Role4"),200,200,new Point(0,0));
            bbdc.setOffsetXY(15,-13);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            this.bbdc.turnRight();
         }
         if(this.isNotArrow)
         {
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,13,2,24],[4,4,4,4],[2,2,2,2],[1,1,8,6,10,4],[2,2,2,2,2],[2,2,6],[2,2,11],[1,1,1,2],[2,19],[2,2,30],[2,2,2,15],[2,2,16],[2,2,14]]);
            bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,3,3,12,2,3,4,3,3]);
         }
         else
         {
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,13,2,24],[4,4,4,4],[2,2,2,2],[1,1,8,10,20,4],[2,2,2,2,2],[2,2,1,1,12],[2,2,2,2,2,10],[2,4,1,1,10],[2,2,30],[2,2,1,1,12],[2,2,2,2,2,20],[2,7,1,1,25],[2,18,2,2,2,24]]);
            bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,5,6,5,3,5,6,5,6]);
         }
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         super.setAction(str);
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
               if(this.isNotArrow)
               {
                  if(curPoint.y != 6)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(6);
                  }
               }
               else if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 7)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(7);
                  }
               }
               else if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 8)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(8);
                  }
               }
               else if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 9)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(9);
                  }
               }
               else if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 9)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(9);
                  }
               }
               else if(curPoint.x != 4 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit6":
               if(this.isNotArrow)
               {
                  if(curPoint.x != 4 || curPoint.y != 4)
                  {
                     this.bbdc.setFramePointX(4);
                     this.bbdc.setFramePointY(4);
                  }
               }
               else if(curPoint.x != 3 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit7":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 10)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(10);
                  }
               }
               else if(curPoint.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(str);
               break;
            case "hit8":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 11)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(11);
                  }
               }
               else if(curPoint.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(str);
               break;
            case "hit9":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 12)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(12);
                  }
               }
               else if(curPoint.y != 11)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(11);
               }
               this.bbdc.setState(str);
               break;
            case "hit10":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 10)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(10);
                  }
               }
               else if(curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit11":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit12":
               if(curPoint.y != 13)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(13);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.x != 2 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "wait":
               this.setAction("wait2");
               break;
            case "wait2":
               this.setAction("wait");
               break;
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "run":
               this.bbdc.setFramePointX(0);
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
               this.setStatic();
               this.setAction("wait");
               break;
            case "hit4":
               this.setAction("wait");
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hit6":
               this.setAction("wait");
               break;
            case "hit7":
               this.setAction("wait");
               break;
            case "hit8":
               this.setAction("wait");
               break;
            case "hit9":
               this.speed.y = 0;
               this.setAction("wait");
               break;
            case "hit10":
               this.setStatic();
               this.setAction("wait");
               break;
            case "hit11":
               this.setAction("wait");
               break;
            case "hit11Frame2":
               this.setAction("wait");
               break;
            case "hit12":
               this.lastHit = "";
               this.getBBDC().show();
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var target:* = null;
         var minDis:* = NaN;
         var dis:Number = NaN;
         var state:String = this.bbdc.getState();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(p.x == 1)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 20;
                           }
                           else
                           {
                              point.x = this.x + 20;
                           }
                           point.y = this.y + 30;
                           this.doHit1(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"hit1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 90;
                        }
                        else
                        {
                           point.x = this.x + 90;
                        }
                        point.y = this.y;
                        this.doHit1Arrow(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"doHit1Arrow",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit2":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(p.x == 1)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 15;
                           }
                           else
                           {
                              point.x = this.x + 15;
                           }
                           point.y = this.y;
                           this.doHit2(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"hit2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 90;
                        }
                        else
                        {
                           point.x = this.x + 90;
                        }
                        point.y = this.y;
                        this.doHit1Arrow(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"doHit1Arrow",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit3":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 1)
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
                           point.y = this.y;
                           this.doHit3(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"hit3",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
                  if(this.getBBDC().getDirect() == 0)
                  {
                     this.speed.x = -8;
                  }
                  else
                  {
                     this.speed.x = 8;
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 115;
                        }
                        else
                        {
                           point.x = this.x + 115;
                        }
                        point.y = this.y - 20;
                        this.doHit2Arrow(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"doHit2Arrow",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit4":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 19)
                     {
                        if(p.x == 1)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 245;
                           }
                           else
                           {
                              point.x = this.x + 245;
                           }
                           point.y = this.y - 110;
                           this.doHit4(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"hit4",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 30;
                        }
                        else
                        {
                           point.x = this.x + 30;
                        }
                        point.y = this.y;
                        this.doHit4Arrow(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"doHit4Arrow",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit5":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 19)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 115;
                        }
                        else
                        {
                           point.x = this.x + 115;
                        }
                        point.y = this.y - 110;
                        this.doHit5_1(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(p.x == 4)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 115;
                     }
                     else
                     {
                        point.x = this.x + 115;
                     }
                     point.y = this.y - 110;
                     this.doHit5_1(this.getBBDC().getDirect(),point);
                  }
               }
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 14)
                  {
                     if(p.x == 1 || p.x == 4)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x;
                        }
                        else
                        {
                           point.x = this.x;
                        }
                        point.y = this.y - 20;
                        minDis = Number(9999);
                        for each(var bo in gc.obbsiteArray)
                        {
                           if(this.getBBDC().getDirect() == 0)
                           {
                              if(this.x > bo.x)
                              {
                                 dis = AUtils.GetDisBetweenTwoObj(this,bo);
                                 if(minDis > dis)
                                 {
                                    minDis = dis;
                                    target = bo;
                                 }
                              }
                           }
                           else if(this.x < bo.x)
                           {
                              dis = AUtils.GetDisBetweenTwoObj(this,bo);
                              if(minDis > dis)
                              {
                                 minDis = dis;
                                 target = bo;
                              }
                           }
                        }
                        if(target)
                        {
                           this.doHit5_2(this.getBBDC().getDirect(),point,[target.sid,target.getRoleId()]);
                           if(target is BaseMonster)
                           {
                              gc.sendAttack(this.getRoleId(),"hit5_2",this.getBBDC().getDirect(),point.x,point.y,[target.sid,target.getRoleId(),BaseMonster(target).entityId]);
                           }
                           else
                           {
                              gc.sendAttack(this.getRoleId(),"hit5_2",this.getBBDC().getDirect(),point.x,point.y,[target.sid,target.getRoleId()]);
                           }
                        }
                     }
                  }
               }
               break;
            case "hit6":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 10)
                     {
                        if(p.x == 4)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 25;
                           }
                           else
                           {
                              point.x = this.x + 25;
                           }
                           point.y = this.y - 30;
                           this.doHit6(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"hit6",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               else if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(p.x == 3)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 25;
                        }
                        else
                        {
                           point.x = this.x + 25;
                        }
                        point.y = this.y - 30;
                        this.doHit6(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit6",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit7":
               if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(p.x == 2)
                  {
                     for each(var bb in this.magicBulletArray)
                     {
                        if(bb.getImcName() == "Role4Bullet7_1")
                        {
                           bb.destroy();
                        }
                     }
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 155;
                     }
                     else
                     {
                        point.x = this.x + 155;
                     }
                     point.y = this.y - 50;
                     this.doHit7_1(this.getBBDC().getDirect(),point);
                  }
               }
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 8)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 150;
                        }
                        else
                        {
                           point.x = this.x + 150;
                        }
                        point.y = this.y - 70;
                        this.doHit7_2(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit7_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit8":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(p.x == 2)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 125;
                           }
                           else
                           {
                              point.x = this.x + 125;
                           }
                           point.y = this.y - 30;
                           this.doHit8(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"hit8",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               else
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 75;
                        }
                        else
                        {
                           point.x = this.x + 75;
                        }
                        point.y = this.y - 60;
                        this.doHit8Arrow_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(p.x == 0)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 65;
                           }
                           else
                           {
                              point.x = this.x + 65;
                           }
                           point.y = this.y - 10;
                           this.doHit8Arrow_2(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"doHit8Arrow_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
                  if(p.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        this.isRight = true;
                        this.isLeft = false;
                        this.speed.x = 25;
                        this.speed.y = -25;
                     }
                     else
                     {
                        this.isLeft = true;
                        this.isRight = false;
                        this.speed.x = -25;
                        this.speed.y = -25;
                     }
                  }
                  else
                  {
                     this.setStatic();
                     this.speed.y = 0;
                  }
               }
               break;
            case "hit9":
               if(this.isNotArrow)
               {
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
                        point.y = this.y;
                        this.doHit9_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 13)
                     {
                        if(p.x == 2)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x;
                           }
                           else
                           {
                              point.x = this.x;
                           }
                           point.y = this.y - 80;
                           this.doHit9_2(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"hit9_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
                  if(p.x == 2)
                  {
                     this.speed.y = -10;
                  }
               }
               else
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 80;
                        }
                        else
                        {
                           point.x = this.x + 80;
                        }
                        point.y = this.y - 80;
                        this.doHit9Arrow_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(p.x == 1)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 60;
                           }
                           else
                           {
                              point.x = this.x + 60;
                           }
                           point.y = this.y + 30;
                           this.doHit9Arrow_2(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"doHit9Arrow_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
                  if(p.x <= 1)
                  {
                     this.speed.y = -35;
                  }
                  else
                  {
                     this.speed.y = 0;
                  }
                  this.setStatic();
               }
               break;
            case "hit10":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(p.x == 0)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 150;
                           }
                           else
                           {
                              point.x = this.x + 150;
                           }
                           point.y = this.y - 50;
                           this.doHit10(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"hit10",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
                  if(p.x < 2)
                  {
                     if(this.getBBDC().getDirect() == 0)
                     {
                        this.speed.x = -20;
                     }
                     else
                     {
                        this.speed.x = 20;
                     }
                  }
                  else
                  {
                     this.setStatic();
                  }
               }
               else
               {
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
                        point.y = this.y;
                        this.doHit10Arrow_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 24)
                     {
                        if(p.x == 4)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 225;
                           }
                           else
                           {
                              point.x = this.x + 225;
                           }
                           point.y = this.y - 80;
                           this.doHit10Arrow_2(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"doHit10Arrow_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit11":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 4)
                  {
                     if(p.x == 5)
                     {
                        point.x = this.x;
                        point.y = this.y;
                        this.doHit11(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit11",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit12":
               if(this.isNotArrow)
               {
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 14)
                     {
                        if(p.x == 2)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - 150;
                           }
                           else
                           {
                              point.x = this.x + 150;
                           }
                           point.y = this.y;
                           this.doHit12(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"hit12",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               else
               {
                  if(p.x == 0 || p.x == 1 && this.bbdc.getCurFrameCount() >= 16)
                  {
                     this.setStatic();
                     this.speed.y = -35;
                  }
                  else if(p.x >= 2 && p.x <= 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        this.speed.x = -25;
                     }
                     else
                     {
                        this.speed.x = 25;
                     }
                     this.speed.y = 0;
                  }
                  else if(p.x == 4 && this.bbdc.getCurFrameCount() == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        this.isRight = true;
                        this.isLeft = false;
                        this.bbdc.turnRight();
                     }
                     else
                     {
                        this.isRight = false;
                        this.isLeft = true;
                        this.bbdc.turnLeft();
                     }
                  }
                  else
                  {
                     this.setStatic();
                     this.speed.y = 0;
                  }
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0 || p.x == 4)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 80;
                        }
                        else
                        {
                           point.x = this.x + 80;
                        }
                        point.y = this.y - 100;
                        this.doHit12Arrow_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(gc.sid == this.sid || gc.isSingleGame())
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(p.x == 0 || p.x == 4)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x;
                           }
                           else
                           {
                              point.x = this.x;
                           }
                           point.y = this.y;
                           this.doHit12Arrow_2(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"doHit12Arrow_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                     if(this.bbdc.getCurFrameCount() == 17 || this.bbdc.getCurFrameCount() == 12 || this.bbdc.getCurFrameCount() == 6)
                     {
                        if(p.x == 1 || p.x == 5)
                        {
                           if(this.bbdc.getDirect() == 0)
                           {
                              point.x = this.x - (88 + this.bbdc.getCurFrameCount());
                           }
                           else
                           {
                              point.x = this.x + (88 + this.bbdc.getCurFrameCount());
                           }
                           point.y = this.y - (-7 + this.bbdc.getCurFrameCount() * 2);
                           this.doHit12Arrow_3(this.getBBDC().getDirect(),point);
                           gc.sendAttack(this.getRoleId(),"doHit12Arrow_3",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
         }
      }
      
      private function doHit1(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit1Arrow(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2Arrow(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet3");
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
         mm.play("Role4_hit4");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet4");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4Arrow(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit4Arrow");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow4");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit5");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet5");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit5");
         var idx:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5_2(direct:uint, p:Point, params:Array) : void
      {
         var targetBm:* = null;
         var entityId:* = 0;
         var target:* = null;
         var idx:int = gc.pWorld.likeMonsterArray.indexOf(this.role4Hit5);
         if(this.role4Hit5 && idx != -1)
         {
            this.role4Hit5.destroy();
            gc.pWorld.likeMonsterArray.splice(idx,1);
            this.role4Hit5 = null;
         }
         var sid:int = parseInt(params[0]);
         var roleId:uint = parseInt(params[1]);
         if(params.length > 2)
         {
            entityId = uint(parseInt(params[2]));
            targetBm = gc.getMonsterById(entityId);
         }
         for each(var bo in gc.obbsiteArray)
         {
            if(bo.sid == sid && bo.getRoleId() == roleId)
            {
               target = bo;
            }
         }
         if(gc.sid != this.sid)
         {
            if(!target)
            {
               if(targetBm)
               {
                  target = targetBm;
               }
               else
               {
                  target = gc.getHeroBySidAndRoleId(sid,roleId);
               }
            }
         }
         if(target)
         {
            this.role4Hit5 = new MonsterRole4Hit5(target,this);
            this.role4Hit5.x = p.x;
            this.role4Hit5.y = p.y;
            gc.gameSence.addChild(this.role4Hit5);
            gc.pWorld.likeMonsterArray.push(this.role4Hit5);
         }
      }
      
      private function doHit6(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role4_hit6");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            var newObbsiteArray:Array = gc.obbsiteArray.concat(gc.pWorld.likeMonsterArray);
            for each(bo in newObbsiteArray)
            {
               if(this.bbdc.getDirect() == 0)
               {
                  if(bo.x < this.x)
                  {
                     if(AUtils.GetDisBetweenTwoObj(bo,this) <= 500)
                     {
                        var target:BaseObject = bo;
                        break;
                     }
                  }
               }
               else if(bo.x > this.x)
               {
                  if(AUtils.GetDisBetweenTwoObj(bo,this) <= 500)
                  {
                     target = bo;
                     break;
                  }
               }
            }
            if(target)
            {
               var dis:Number = AUtils.GetDisBetweenTwoObj(target,this);
               var moveTime:Number = dis / 500 * 1.2;
               moveTime = Number(moveTime.toFixed(2));
               this.reHit6(b,target,8,moveTime);
            }
            else
            {
               TweenMax.to(b,1,{
                  "alpha":0,
                  "onComplete":function(_b:SpecialEffectBullet):*
                  {
                     _b.destroy();
                  },
                  "onCompleteParams":[b]
               });
            }
         }
      }
      
      private function reHit6(_b:SpecialEffectBullet, _target:BaseObject, _times:uint, _moveTime:Number) : void
      {
         _b = _b;
         _target = _target;
         _times = _times;
         _moveTime = _moveTime;
         if(_times > 0)
         {
            mm.play("Role4_hit6");
            _times--;
            TweenMax.to(_b,_moveTime,{
               "x":_target.x,
               "y":_target.y,
               "onComplete":function(_self:Role4, __b:SpecialEffectBullet, __target:BaseObject, __times:uint):*
               {
                  var img:* = null;
                  var tempArray:* = null;
                  var newObbsiteArray:* = null;
                  var dis:Number = NaN;
                  var randIdx:* = 0;
                  var boTemp:* = null;
                  var disTemp:Number = NaN;
                  if(!__target.isYourFather() && AUtils.GetDisBetweenTwoObj(__b,__target) <= 80)
                  {
                     if(__target.curAddEffect)
                     {
                        __target.curAddEffect.add([{
                           "name":BaseAddEffect.POISON_TIMES,
                           "time":gc.frameClips * 7
                        }]);
                        __target.curAddEffect.add([{
                           "name":BaseAddEffect.STUN,
                           "time":gc.frameClips * 0.5
                        }]);
                     }
                     img = AUtils.getNewObj("HeroBeHurt");
                     img.x = colipse.x;
                     img.y = colipse.y;
                     __target.addChild(img);
                     if(gc.isInRoom())
                     {
                        if(__target is BaseHero)
                        {
                           BaseHero(__target).beAttackDoing();
                           gc.sendOtherBuff(__target.sid,__target.getRoleId(),"Role4_hit6",[]);
                        }
                        else if(__target is BaseMonster)
                        {
                           gc.sendMonsterBuff(BaseMonster(__target),BaseAddEffect.STUN,gc.frameClips * 0.5);
                        }
                     }
                     tempArray = [];
                     newObbsiteArray = gc.obbsiteArray.concat(gc.pWorld.likeMonsterArray);
                     for each(var bo in newObbsiteArray)
                     {
                        if(bo != __target)
                        {
                           dis = AUtils.GetDisBetweenTwoObj(bo,__b);
                           if(dis <= 500)
                           {
                              tempArray.push(bo);
                           }
                        }
                     }
                     if(tempArray.length == 0)
                     {
                        __b.destroy();
                     }
                     else
                     {
                        randIdx = uint(Math.floor(RandomControllor.getIns().getRandom() * tempArray.length));
                        boTemp = tempArray[randIdx] as BaseObject;
                        disTemp = AUtils.GetDisBetweenTwoObj(boTemp,__b);
                        disTemp = Number(disTemp.toFixed(2));
                        _self.reHit6(__b,boTemp,__times,disTemp / 500 * 1.2);
                     }
                  }
                  else
                  {
                     __b.destroy();
                  }
               },
               "onCompleteParams":[this,_b,_target,_times]
            });
            gc.sendAttack(this.getRoleId(),"hit6_2",this.getBBDC().getDirect(),_b.x,_b.y,[int(_target.x),int(_target.y),_moveTime]);
         }
         else
         {
            _b.destroy();
         }
      }
      
      private function otherAttackHit6_2(direct:uint, p:Point, targetPointArray:Array) : void
      {
         direct = direct;
         p = p;
         targetPointArray = targetPointArray;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var targetX:int = parseInt(targetPointArray[0]);
         var targetY:int = parseInt(targetPointArray[1]);
         var moveTime:Number = targetPointArray[2];
         TweenMax.to(b,moveTime,{
            "x":targetX,
            "y":targetY,
            "onComplete":function():*
            {
               b.destroy();
            },
            "onCompleteParams":[b]
         });
      }
      
      private function doHit7_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit7");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet7_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit7_1");
         var idx:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
      }
      
      private function doHit7_2(direct:uint, p:Point) : void
      {
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Role4Bullet7_2")
            {
               bb.destroy();
            }
         }
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet7_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Role4Bullet7_2");
         if(direct == 0)
         {
            b.x = p.x - 40;
         }
         else
         {
            b.x = p.x + 40;
         }
         b.y = p.y - 20;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Role4Bullet7_2");
         if(direct == 0)
         {
            b.x = p.x + 40;
         }
         else
         {
            b.x = p.x - 40;
         }
         b.y = p.y - 10;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit8");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet8");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit8");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8Arrow_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit8Arrow");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow8_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit8");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8Arrow_2(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow8_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit8Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit9");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet9_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9_2(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet9_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9Arrow_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit9Arrow");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow9_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9Arrow_2(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow9_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit9Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit10(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit10");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet10");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit10Arrow_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit10Arrow");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow10_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit10");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit10Arrow_2(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow10_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit11(direct:uint, p:Point) : void
      {
         var idx:int = 0;
         if(!this.hit11Biaoji)
         {
            mm.play("Role4_hit11");
            this.hit11Biaoji = new SpecialEffectBullet("Role4Bullet11");
            this.curHit11BiaojiCount = 0;
            this.hit11Biaoji.x = p.x;
            this.hit11Biaoji.y = p.y;
            this.hit11Biaoji.setDestroyWhenLastFrame(false);
            this.hit11Biaoji.setDirect(direct);
            this.hit11Biaoji.setDisable();
            idx = gc.gameSence.getChildIndex(this);
            gc.gameSence.addChildAt(this.hit11Biaoji,idx);
            this.magicBulletArray.push(this.hit11Biaoji);
         }
      }
      
      override public function clearAllBullets() : void
      {
         super.clearAllBullets();
         this.hit11Biaoji = null;
      }
      
      private function doHit11_2(direct:uint, p:Point) : void
      {
         this.x = this.hit11Biaoji.x;
         this.y = this.hit11Biaoji.y;
         this.speed.y = 0;
      }
      
      public function clearBiaoJi() : void
      {
         if(this.hit11Biaoji)
         {
            this.hit11Biaoji.destroy();
            this.hit11Biaoji = null;
         }
      }
      
      private function doHit12(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit12");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet12");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit12");
         b.setDestroyInCount(gc.frameClips * 10);
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12Arrow_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit12Arrow");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow12_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setDisable();
         b.setAction("hit12");
         var idx:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12Arrow_2(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow12_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit12Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12Arrow_3(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow12_3");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit12Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function setOtherAttack(attackKind:String, direct:uint, point:Point, params:Array = null, initTimer:uint = 0) : void
      {
         switch(attackKind)
         {
            case "hit1":
               this.doHit1(direct,point);
               break;
            case "doHit1Arrow":
               this.doHit1Arrow(direct,point);
               break;
            case "hit2":
               this.doHit2(direct,point);
               break;
            case "doHit2Arrow":
               this.doHit2Arrow(direct,point);
               break;
            case "hit3":
               this.doHit3(direct,point);
               break;
            case "hit4":
               this.doHit4(direct,point);
               break;
            case "doHit4Arrow":
               this.doHit4Arrow(direct,point);
               break;
            case "hit5_2":
               this.doHit5_2(direct,point,params);
               break;
            case "hit6_2":
               this.otherAttackHit6_2(direct,point,params);
               break;
            case "hit7_2":
               this.doHit7_2(direct,point);
               break;
            case "hit8":
               this.doHit8(direct,point);
               break;
            case "doHit8Arrow_2":
               this.doHit8Arrow_2(direct,point);
               break;
            case "hit9_2":
               this.doHit9_2(direct,point);
               break;
            case "doHit9Arrow_2":
               this.doHit9Arrow_2(direct,point);
               break;
            case "hit10":
               this.doHit10(direct,point);
               break;
            case "doHit10Arrow_2":
               this.doHit10Arrow_2(direct,point);
               break;
            case "hit11":
               this.doHit11(direct,point);
               break;
            case "hit11_2":
               this.doHit11_2(direct,point);
               break;
            case "hit12":
               this.doHit12(direct,point);
               break;
            case "doHit12Arrow_2":
               this.doHit12Arrow_2(direct,point);
               break;
            case "doHit12Arrow_3":
               this.doHit12Arrow_3(direct,point);
               break;
            case "wushuangStart":
               this.turnToGXP();
               break;
            case "wushuangOver":
               this.turnToNormal();
               break;
            case "Role2Hit7":
               this.beAttackByRole2Hit7(point);
               break;
            case "Role3Hit6":
               this.beAttackByRole3Hit6(point);
         }
      }
      
      override public function setOtherBuff(action:String, params:Array) : void
      {
         switch(action)
         {
            case "poison_bomb":
               this.curAddEffect.poison_times_bomb_other();
               break;
            case "Role4_hit6":
               if(this.curAddEffect)
               {
                  this.curAddEffect.add([{
                     "name":BaseAddEffect.POISON_TIMES,
                     "time":gc.frameClips * 7
                  }]);
                  this.curAddEffect.add([{
                     "name":BaseAddEffect.STUN,
                     "time":gc.frameClips * 2
                  }]);
               }
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         super.step();
         if(this.hit11Biaoji)
         {
            if(this.curHit11BiaojiCount < this.hit11BiaojiCount)
            {
               this.curHit11BiaojiCount++;
            }
            if(this.curHit11BiaojiCount == this.hit11BiaojiCount)
            {
               this.hit11Biaoji.destroy();
               this.hit11Biaoji = null;
            }
         }
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(this.isGXP || this.curAction == "hit12")
         {
            canHurt = false;
         }
         super.reduceHp(re,canHurt);
      }
      
      override public function isCanHurtWhenBeingAttack() : Boolean
      {
         if(this.isGXP || this.curAction == "hit12")
         {
            return false;
         }
         return true;
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(!(this.isGXP || this.curAction == "hit12"))
         {
            super.setAttackBack(p);
         }
      }
      
      override protected function myKeyDown(keyStr:String) : *
      {
         keyStr = keyStr;
         super.myKeyDown(keyStr);
         if(cannextaction)
         {
            switch(keyStr)
            {
               case "0010":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.jump();
                  cannextaction = false;
                  break;
               case "0100":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.normalHit();
                  cannextaction = false;
                  break;
               case "1100":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.getFallDown();
                  cannextaction = false;
                  break;
               case "1010":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  cannextaction = false;
                  break;
               case "0110":
                  gc.pWorld.getBaseLevelListener().keyBoardDownForWAtCommon(this);
                  if(this.checkTransferDoor())
                  {
                     gc.pWorld.getBaseLevelListener().keyBoardDownForW(this);
                     if(gc.curStageAndCurLevel.curStage == 8 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 62 && gc.curStageAndCurLevel.curLevel == 1)
                     {
                        return;
                     }
                  }
                  if(!gc.isLevelClear && this.checkTransferDoor())
                  {
                     gc.isLevelClear = true;
                     gc.keyboardControl.destroy();
                     TweenMax.to(gc.gameInfo,1,{"alpha":0});
                     TweenMax.to(gc.gameSence,1,{
                        "alpha":0,
                        "onComplete":function():*
                        {
                           gc.eventManger.dispatchEvent(new Event("LevelVictor"));
                           MainGame.getInstance().levelClear();
                        }
                     });
                  }
                  break;
               case "0001":
            }
         }
      }
      
      override protected function showSkill(skill:String) : void
      {
         var skillArray:* = null;
         var needMp:* = 0;
         super.showSkill(skill);
         if(this.cannotuseskill())
         {
            return;
         }
         if(this.getPlayer())
         {
            skillArray = this.getPlayer().returnSkillNameBySkillKey(skill);
            if(skillArray)
            {
               skill = skillArray[0];
               needMp = uint(parseInt(skillArray[1]));
               if(skill == "zq")
               {
                  this.skill_zq(needMp);
               }
               else if(skill == "mbyj")
               {
                  this.skill_mbyj(needMp);
               }
               else if(skill == "wdww")
               {
                  this.skill_wdww(needMp);
               }
               else if(skill == "jdz")
               {
                  this.skill_jdz(needMp);
               }
               else if(skill == "mds")
               {
                  this.skill_mds(needMp);
               }
               else if(skill == "qlj")
               {
                  this.skill_qlj(needMp);
               }
               else if(skill == "tkj")
               {
                  this.skill_tkj(needMp);
               }
               else if(skill == "dzj")
               {
                  this.skill_dcj(needMp);
               }
               else if(skill == "lybj")
               {
                  this.skill_lvbj(needMp);
               }
               else if(skill == "mmw")
               {
                  this.skill_mmw(needMp);
               }
               if(this.curAddEffect.curDebuff(BaseAddEffect.MONSTER65_AOE) || this.curAddEffect.curDebuff(BaseAddEffect.MONSTER129Buff))
               {
                  this.reduceHp(needMp);
               }
            }
         }
      }
      
      private function skill_zq(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit4";
         this.setAction("hit4");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_mbyj(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit6";
         this.setAction("hit6");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_wdww(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit5";
         this.setAction("hit5");
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_jdz(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.isInSky())
         {
            return;
         }
         this.lastHit = "hit7";
         this.setAction("hit7");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_mmw(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isInSky())
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit12";
         this.setAction("hit12");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_mds(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         mm.play("Role4_mds");
         for each(var bo in gc.obbsiteArray)
         {
            if(this.getPlayer())
            {
               bo.curAddEffect.poison_times_bomb(this.roleProperies.getHurt(),this,this.player.returnSkillLevelBySkillName("mds"));
            }
            else
            {
               bo.curAddEffect.poison_times_bomb(this.roleProperies.getHurt(),this,1);
            }
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_qlj(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(!this.standInObj)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit8";
         this.setAction("hit8");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_tkj(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit9";
         this.setAction("hit9");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_dcj(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit10";
         this.setAction("hit10");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_lvbj(needMp:uint) : void
      {
         var thisRect:* = null;
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(!this.hit11Biaoji)
         {
            this.lastHit = "hit11";
            this.setAction("hit11");
            this.newAttackId();
            this.hitNum = 0;
            if(gc.sid == this.sid)
            {
               gc.sendPosition(this);
            }
         }
         else
         {
            thisRect = this.hit11Biaoji.getBounds(gc.gameSence.parent);
            if(thisRect.x < 30 || thisRect.x > 930)
            {
               this.hit11Biaoji.destroy();
               this.hit11Biaoji = null;
            }
            else
            {
               this.doHit11_2(this.getBBDC().getDirect(),new Point());
               if(gc.sid == this.sid)
               {
                  gc.sendPosition(this);
                  gc.sendAttack(this.getRoleId(),"hit11_2",this.getBBDC().getDirect(),0,0,[]);
               }
            }
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      override protected function showSkillKongGe() : void
      {
         var ri:* = null;
         if(gc.isSingleGame())
         {
            ri = gc.gameInfo.getRoleInfoByPlayer(this.player) as RoleInfo;
            if(ri.isGXPReady() && !this.isGXP)
            {
               this.turnToGXP();
               if(this.getPlayer())
               {
                  if(gc.isInRoom())
                  {
                     gc.sendRoleWushuangStart(this.getRoleId());
                  }
               }
            }
         }
      }
      
      private function refreshByWeapon() : void
      {
         this.initBBDC();
      }
      
      override public function refreshEquip() : void
      {
         super.refreshEquip();
         this.refreshByWeapon();
      }
      
      override public function normalHit() : *
      {
         this.curtime = getTimer();
         if(this.timers <= 0)
         {
            if(!this.isInSky())
            {
               if(!this.isRunning() && (!this.isAttacking() || this.isNormalHit()))
               {
                  this.timers = 13;
                  if(this.curtime - this.lasttime > 1500)
                  {
                     this.hitNum = 1;
                  }
                  else if(++this.hitNum > 3)
                  {
                     this.hitNum = 1;
                  }
                  this.setAction("hit" + this.hitNum);
                  this.lastHit = "hit" + this.hitNum;
                  if(this.isNotArrow)
                  {
                     mm.play("Role4_hit" + this.hitNum);
                  }
                  else if(this.hitNum == 1 || this.hitNum == 2)
                  {
                     mm.play("Role4_hit1Arrow");
                  }
                  else
                  {
                     mm.play("Role4_hit2Arrow");
                  }
                  if(this.getPlayer())
                  {
                     gc.sendPosition(this);
                  }
                  this.newAttackId();
               }
               else if(this.isRunning() && !this.isAttacking())
               {
                  this.doubleCount = 0;
                  this.normalHit();
               }
            }
            else
            {
               this.timers = 15;
               if(this.isNotArrow)
               {
                  this.setAction("hit2");
                  this.lastHit = "hit2";
                  mm.play("Role4_hit2");
               }
               else
               {
                  this.setAction("hit3");
                  this.lastHit = "hit3";
                  mm.play("Role4_hit2Arrow");
               }
               if(this.getPlayer())
               {
                  gc.sendPosition(this);
               }
               this.hitNum = 0;
               this.newAttackId();
            }
         }
         this.lasttime = this.curtime;
      }
      
      private function isDefending() : Boolean
      {
         return this.curAction == "hit6";
      }
      
      override public function isNormalHit() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      private function runAttack() : void
      {
         if(!this.isInSky())
         {
            if(this.roleProperies.getMMP() >= 20)
            {
               this.hitNum = 1;
               this.doubleCount = 0;
               this.lastHit = "hit6";
               this.curAction = "hit6";
               this.newAttackId();
               this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - 20]));
            }
            else
            {
               this.doubleCount = 0;
               this.normalHit();
            }
         }
      }
      
      override public function __keyBoardDown(evt:KeyboardEvent) : void
      {
         super.__keyBoardDown(evt);
      }
      
      override public function __keyBoardUp(evt:KeyboardEvent) : void
      {
         super.__keyBoardUp(evt);
      }
      
      override public function upGrade(first:Boolean = true) : *
      {
         super.upGrade();
         if(!first)
         {
            this.roleProperies.removeAllEquipAndPassive();
         }
         this.roleProperies.initAll();
      }
      
      override public function getRealPower(cur:String, crit:Boolean = true) : int
      {
         var v:int = 0;
         v = 0;
         var pinzhi:* = 0;
         var equip:* = null;
         pinzhi = 0;
         equip = null;
         pinzhi = 0;
         equip = null;
         var arr:* = null;
         var kind:* = 0;
         var jieshu:Number = NaN;
         equip = null;
         var addPower:Number = HeroSkillProtect.getInstance().hero4Anti.addPower1;
         if(this.isGXP)
         {
            addPower = HeroSkillProtect.getInstance().hero4Anti.addPower1dian5;
         }
         var isCrit:int = HeroSkillProtect.getInstance().hero4Anti.critNormal;
         if(crit && RandomControllor.getIns().getRandom() <= this.roleProperies.getTotalCrit() / 100)
         {
            isCrit = HeroSkillProtect.getInstance().hero4Anti.critNum;
         }
         switch(cur)
         {
            case "hit1":
            case "hit1Arrow":
            case "hit2":
            case "hit2Arrow":
               return this.roleProperies.getHurt() * addPower * isCrit;
            case "hit3":
               return HeroSkillProtect.getInstance().hero4Anti.hit3Shovel * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit4":
               return int(HeroSkillProtect.getInstance().hero4Anti.hit4Shovel * this.roleProperies.getHurt() * addPower * isCrit);
            case "hit4Arrow":
               return int(HeroSkillProtect.getInstance().hero4Anti.hit4Arrow * this.roleProperies.getHurt() * addPower * isCrit);
            case "hit5":
               return 0;
            case "hit6":
               return 0;
            case "hit7":
               return HeroSkillProtect.getInstance().hero4Anti.hit7Shovel * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit8":
               return HeroSkillProtect.getInstance().hero4Anti.hit8Shovel * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit8Arrow":
               return HeroSkillProtect.getInstance().hero4Anti.hit8Arrow * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit9":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("tkj");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               if(this._anti.skillLevel == 1)
               {
                  return HeroSkillProtect.getInstance().hero4Anti.hit9Shovel * this.roleProperies.getHurt() * addPower * isCrit;
               }
               if(this._anti.skillLevel == 2)
               {
                  return HeroSkillProtect.getInstance().hero4Anti.hit9ShovelLevel2 * this.roleProperies.getHurt() * addPower * isCrit;
               }
               return 0;
               break;
            case "hit9Arrow":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("tkj");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               if(this._anti.skillLevel == 1)
               {
                  return this.roleProperies.getHurt() * addPower * isCrit;
               }
               if(this._anti.skillLevel == 2)
               {
                  return HeroSkillProtect.getInstance().hero4Anti.hit9ArrowLevel2 * this.roleProperies.getHurt() * addPower * isCrit;
               }
               return 0;
               break;
            case "hit10":
               return HeroSkillProtect.getInstance().hero4Anti.hit10Shovel * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit10Arrow":
               return HeroSkillProtect.getInstance().hero4Anti.hit10Arrow * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit11":
               return 0;
            case "hit12":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("mmw");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return (HeroSkillProtect.getInstance().hero4Anti.hit12Shovel + (this._anti.skillLevel - 1) * 1) * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit12Arrow":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("mmw");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return (HeroSkillProtect.getInstance().hero4Anti.hit12Arrow + (this._anti.skillLevel - 1) * 2) * this.roleProperies.getHurt() * addPower * isCrit;
            case "fabao-sword":
               return this.roleProperies.getHurt() * addPower * isCrit;
            case "hitNiumowangSzBuff":
               pinzhi = uint(1);
               equip = this.getPlayer().getCurEquipByType("zbsz");
               if(equip)
               {
                  if(equip.getFillName() == "yxnmwsz")
                  {
                     pinzhi = uint(2);
                  }
                  else if(equip.getFillName() == "jlnmwsz")
                  {
                     pinzhi = uint(3);
                  }
                  else if(equip.getFillName() == "ssnmwsz")
                  {
                     pinzhi = uint(4);
                  }
               }
               return this.roleProperies.getHurt() * addPower * isCrit * (0.25 * pinzhi * pinzhi);
            case "hitZhuanlunwangSzBuff":
               pinzhi = uint(1);
               equip = this.getPlayer().getCurEquipByType("zbsz");
               if(equip)
               {
                  if(equip.getFillName() == "yxzlwsz")
                  {
                     pinzhi = uint(2);
                  }
                  else if(equip.getFillName() == "jlzlwsz")
                  {
                     pinzhi = uint(3);
                  }
                  else if(equip.getFillName() == "sszlwsz")
                  {
                     pinzhi = uint(4);
                  }
               }
               return this.roleProperies.getHurt() * addPower * isCrit * (0.25 * pinzhi * pinzhi);
            case "hitTiantingZhanshenSzBuff":
               pinzhi = uint(1);
               equip = this.getPlayer().getCurEquipByType("zbsz");
               if(equip)
               {
                  if(equip.getFillName() == "yxttzssz")
                  {
                     pinzhi = uint(2);
                  }
                  else if(equip.getFillName() == "jlttzssz")
                  {
                     pinzhi = uint(3);
                  }
                  else if(equip.getFillName() == "ssttzssz")
                  {
                     pinzhi = uint(4);
                  }
               }
               return this.roleProperies.getHurt() * addPower * isCrit * (0.25 * pinzhi * pinzhi);
            case "BossSkill_bs_qlj":
               return (3 + RandomControllor.getIns().getRandom() * 2) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_nh":
               return 100;
            case "BossSkill_bs_xz":
               return (1 + RandomControllor.getIns().getRandom() * 2) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_sfjz":
               return (3 + RandomControllor.getIns().getRandom() * 5) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_hlcj":
               return (3 + RandomControllor.getIns().getRandom() * 5) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_tl":
               return (3 + RandomControllor.getIns().getRandom() * 5) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_jt":
               return (3 + RandomControllor.getIns().getRandom() * 4) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_lx":
               return (1 + RandomControllor.getIns().getRandom() * 2) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_syfy":
               return (3 + RandomControllor.getIns().getRandom() * 6) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_erishiba_1":
            case "BossSkill_bs_erishiba_2":
            case "BossSkill_bs_erishiba_3":
            case "BossSkill_bs_erishiba_4":
            case "BossSkill_bs_erishiba_5":
            case "BossSkill_bs_erishiba_6":
            case "BossSkill_bs_erishiba_7":
            case "BossSkill_bs_erishiba_8":
            case "BossSkill_bs_erishiba_9":
            case "BossSkill_bs_erishiba_10":
            case "BossSkill_bs_erishiba_11":
            case "BossSkill_bs_erishiba_12":
            case "BossSkill_bs_erishiba_13":
               break;
            case "BossSkill_bs_erishiba_14":
               break;
            case "hzlFan":
               equip = this.getPlayer().getCurEquipByType("zbfb");
               if(equip && equip.getWX().indexOf("木") != -1)
               {
                  return 2 * this.roleProperies.getHurt();
               }
               return this.roleProperies.getHurt();
               break;
            case "football1":
            case "football2":
               return 8 * this.roleProperies.getHurt();
            default:
               return 0;
         }
         arr = cur.split("_");
         kind = uint(arr[arr.length - 1]);
         jieshu = gc.getAnalyzeConstellationsLevel(kind);
         if(jieshu <= 0)
         {
            jieshu = 0.5;
         }
         else if(jieshu > 10)
         {
            jieshu = 10;
         }
         return jieshu * this.roleProperies.getHurt() * addPower * isCrit;
      }
      
      private function isAttackingButCanAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         if(this.isNotArrow)
         {
            return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit9" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
         }
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         if(this.isNotArrow)
         {
            return this.curAction == "hit10" || this.curAction == "hit8";
         }
         return this.curAction == "hit8";
      }
   }
}
