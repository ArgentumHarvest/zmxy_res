package export.hero
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseObject;
   import export.monster.Monster122;
   import export.monster.Monster31;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Role2Shadow extends BaseHero
   {
       
      
      public var source:BaseObject;
      
      private var maxCount:int;
      
      public function Role2Shadow(_source:BaseObject)
      {
         super();
         this.source = _source;
         this.horizenSpeed = 8;
         this.maxCount = gc.frameClips * 8;
         this.setAction("waik");
         this.setYourFather(9999);
         this.roleProperies = null;
      }
      
      public function setDirect(d:uint) : void
      {
         if(d == 0)
         {
            this.turnLeft();
         }
         else
         {
            this.turnRight();
         }
      }
      
      override public function step() : void
      {
         super.step();
         this.maxCount--;
         if(this.maxCount <= 0)
         {
            this.destroy();
         }
      }
      
      override protected function checkOver() : void
      {
         if(this.y >= 1500)
         {
            this.destroy();
         }
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE2_SHALLDOW");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(15,-5);
            bbdc.setFrameStopCount([[4,4,4,4],[2,10,2,40],[2,2,20],[30],[55]]);
            bbdc.setFrameCount([4,4,3,1,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("TANGSENG_SHALLDOW--BitmapData Error!");
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
            case "walk":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
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
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "hit1":
               this.destroy();
               break;
            case "hit2":
               this.destroy();
               break;
            case "hit3":
               this.destroy();
               break;
            case "hit4":
               this.destroy();
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(this.bbdc.getCurFrameCount() == 2)
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
                     point.y = this.y + 10;
                     if(this.source is Role2)
                     {
                        Role2(this.source).doHit3(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.source.sid)
                        {
                           gc.sendAttack(this.source.getRoleId(),"hit3",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                     else if(this.source is Monster31)
                     {
                        Monster31(this.source).doHit3(this.getBBDC().getDirect(),point);
                     }
                     else if(this.source is Monster122)
                     {
                        Monster122(this.source).doHit3(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() >= 20 && this.bbdc.getCurFrameCount() % 8 == 0)
                  {
                     gc.vControllor.shake(25);
                  }
               }
               break;
            case "hit2":
               if(this.bbdc.getCurFrameCount() == 20)
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
                     point.y = this.y - 25;
                     if(this.source is Role2)
                     {
                        Role2(this.source).doHit6(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.source.sid)
                        {
                           gc.sendAttack(this.source.getRoleId(),"hit6",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                     else if(this.source is Monster31)
                     {
                        Monster31(this.source).doHit6(this.getBBDC().getDirect(),point);
                     }
                     else if(this.source is Monster122)
                     {
                        Monster122(this.source).doHit6(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               break;
            case "hit3":
               if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x + 5;
                     }
                     else
                     {
                        point.x = this.x - 5;
                     }
                     point.y = this.y - 60;
                     if(this.source is Role2)
                     {
                        Role2(this.source).doHit8(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit8",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                     else if(this.source is Monster31)
                     {
                        Monster31(this.source).doHit8(this.getBBDC().getDirect(),point);
                     }
                     else if(this.source is Monster122)
                     {
                        Monster122(this.source).doHit8(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               break;
            case "hit4":
               if(this.bbdc.getCurFrameCount() == 55)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 20;
                     }
                     else
                     {
                        point.x = this.x + 20;
                     }
                     point.y = this.y - 20;
                     if(this.source is Role2)
                     {
                        Role2(this.source).doHit9_1(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit9_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                     else if(this.source is Monster31)
                     {
                        Monster31(this.source).doHit9_1(this.getBBDC().getDirect(),point);
                     }
                     else if(this.source is Monster122)
                     {
                        Monster122(this.source).doHit9_1(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 45)
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
                     point.y = this.y - 150;
                     if(this.source is Role2)
                     {
                        Role2(this.source).doHit9_2(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit9_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                     else if(this.source is Monster31)
                     {
                        Monster31(this.source).doHit9_2(this.getBBDC().getDirect(),point);
                     }
                     else if(this.source is Monster122)
                     {
                        Monster122(this.source).doHit9_2(this.getBBDC().getDirect(),point);
                     }
                  }
               }
         }
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function destroy() : void
      {
         if(this.source is Role2)
         {
            Role2(this.source).role2Shalldow = null;
         }
         else if(this.source is Monster31)
         {
            Monster31(this.source).role2Shalldow = null;
         }
         else if(this.source is Monster122)
         {
            Monster122(this.source).role2Shalldow = null;
         }
         super.destroy();
      }
   }
}
