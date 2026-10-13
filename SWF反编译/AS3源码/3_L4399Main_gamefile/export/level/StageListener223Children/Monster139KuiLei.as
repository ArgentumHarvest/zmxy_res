package export.level.StageListener223Children
{
   import base.BaseBullet;
   import base.BaseObject;
   import config.Config;
   import export.monster.Monster139;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.MusicManager;
   import my.HitTest;
   
   public class Monster139KuiLei extends BaseObject
   {
       
      
      private var targetRole:BaseObject;
      
      private var sourceRole:BaseObject;
      
      private var speedVal:Number = 2;
      
      private var beattackedIdArray:Array;
      
      private var hitSprite:Sprite;
      
      public var continueCount:uint = 1440;
      
      private var mm:MusicManager;
      
      public function Monster139KuiLei(target:BaseObject, sourceRole:BaseObject)
      {
         beattackedIdArray = [];
         hitSprite = new Sprite();
         super();
         gc = Config.getInstance();
         mm = MusicManager.getInstance();
         this.targetRole = target;
         this.sourceRole = sourceRole;
         this.addEventListener("addedToStage",__added,false,0,true);
      }
      
      override protected function __added(evt:Event) : void
      {
         this.addChild(AUtils.getNewObj("Monster139Bullet3"));
         this.hitSprite.graphics.beginFill(16711680,0);
         this.hitSprite.graphics.drawRect(-15,-20,30,60);
         this.hitSprite.graphics.endFill();
         this.addChild(this.hitSprite);
      }
      
      override public function step() : void
      {
         var beattackArray:* = null;
         var hurt:int = 0;
         var img:* = null;
         var point:Point = AUtils.GetNextPointByTwoObj(this,this.targetRole);
         this.x += point.x * speedVal;
         this.y += point.y * speedVal;
         beattackArray = gc.getPlayerAndPetArray().concat(this.sourceRole);
         beattackArray = [this.sourceRole];
         for each(var bo in beattackArray)
         {
            for each(var bb in bo.magicBulletArray)
            {
               if(this.beattackedIdArray.indexOf(bb.getAttackId()) == -1)
               {
                  if(!bb.isDisabled)
                  {
                     if(HitTest.complexHitTestObject(this.hitSprite,bb))
                     {
                        hurt = bb.hurt;
                        this.targetRole.reduceHp(hurt);
                        img = AUtils.getNewObj("MonsterBeHurt2") as MovieClip;
                        this.addChild(img);
                        mm.play("BeattackByRole1");
                        if(this.sourceRole is Monster139 && bb is Monster139TantantanBullet)
                        {
                           (this.sourceRole as Monster139).hit4Hit(bb);
                        }
                        this.beattackedIdArray.push(bb.getAttackId());
                     }
                  }
               }
            }
         }
         if(this.continueCount > 0)
         {
            this.continueCount--;
         }
      }
      
      public function destroy() : void
      {
         this.targetRole = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
