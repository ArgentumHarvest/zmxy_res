package export.hero
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseObject;
   import export.monster.Monster121;
   import export.monster.Monster34;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Role1Shadow extends BaseHero
   {
       
      
      public var source:BaseObject;
      
      private var maxCount:int;
      
      public function Role1Shadow(_source:BaseObject)
      {
         super();
         this.source = _source;
         this.horizenSpeed = 8;
         this.maxCount = gc.frameClips * 3;
         this.setAction("walk");
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
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("ROLE1_SHALLDOW");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(15,-5);
            bbdc.setFrameStopCount([[72,72,72,72,72],[2,3,2,3],[2,12,16]]);
            bbdc.setFrameCount([[1,1,1,1,1],4,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("ROLE1_SHALLDOW--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         var randX:* = 0;
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "walk":
               randX = uint(int(RandomControllor.getIns().getRandom() * 5));
               this.bbdc.setFramePointX(randX);
               this.bbdc.setFramePointY(0);
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
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "walk":
               break;
            case "hit1":
               this.destroy();
               break;
            case "hit2":
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
                     if(this.source is Role1)
                     {
                        Role1(this.source).doHit8(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.source.sid && gc.isInRoom())
                        {
                           gc.sendAttack(this.source.getRoleId(),"hit8",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                     else if(this.source is Monster34)
                     {
                        Monster34(this.source).doHit8(this.getBBDC().getDirect(),point);
                     }
                     else if(this.source is Monster121)
                     {
                        Monster121(this.source).doHit8(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               break;
            case "hit2":
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
                     if(this.source is Role1)
                     {
                        Role1(this.source).doHit14_1(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.source.sid && gc.isInRoom())
                        {
                           gc.sendAttack(this.source.getRoleId(),"hit14_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                     else if(this.source is Monster34)
                     {
                        Monster34(this.source).doHit14_1(this.getBBDC().getDirect(),point);
                     }
                     else if(this.source is Monster121)
                     {
                        Monster121(this.source).doHit14_1(this.getBBDC().getDirect(),point);
                     }
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
                     if(this.source is Role1)
                     {
                        Role1(this.source).doHit14_2(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.source.sid && gc.isInRoom())
                        {
                           gc.sendAttack(this.source.getRoleId(),"hit14_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                     else if(this.source is Monster34)
                     {
                        Monster34(this.source).doHit14_2(this.getBBDC().getDirect(),point);
                     }
                     else if(this.source is Monster121)
                     {
                        Monster121(this.source).doHit14_2(this.getBBDC().getDirect(),point);
                     }
                  }
               }
         }
      }
      
      override protected function move() : void
      {
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
         super.destroy();
         this.source = null;
      }
   }
}
