package export
{
   import com.greensock.*;
   import config.*;
   import event.CommonEvent;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import my.*;
   import user.*;
   
   public class GameInfo extends MovieClip
   {
       
      
      private var gc:Config;
      
      private var preBatterNum:int = 0;
      
      private var batterSi:int;
      
      private var rilist:Array;
      
      public var pointmc:Sprite;
      
      public var fpsShow:TextField;
      
      public var canGet:TextField;
      
      private var fps:FPS;
      
      var bpanel:Batter;
      
      public function GameInfo()
      {
         this.rilist = new Array();
         this.fps = new FPS();
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
         this.init();
      }
      
      private function init() : void
      {
         var _loc2_:RoleInfo = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.gc.playNum)
         {
            _loc2_ = new RoleInfo(_loc1_ + 1);
            _loc2_.x = _loc1_ * 920;
            this.addChild(_loc2_);
            if(_loc1_ == 1)
            {
               AUtils.flipHorizontal(_loc2_,-1);
            }
            this.rilist.push(_loc2_);
            _loc1_++;
         }
         this.fps.display = this.fpsShow;
         this.fps.startCalc();
      }
      
      public function getRoleInfoByPlayer(param1:User) : RoleInfo
      {
         return this.rilist[param1.getControlPlayer()];
      }
      
      private function added(param1:Event) : *
      {
         this.gc.eventManger.addEventListener("MonsterIsBeat",this.batterPanel);
         this.gc.eventManger.addEventListener("MonsterIsBeat",this.addWs);
         this.gc.eventManger.addEventListener("HeroIsBeat",this.addWs);
         this.gc.eventManger.addEventListener("AuraEvent",this.addWarriors);
      }
      
      private function removed(param1:Event) : *
      {
         this.gc.eventManger.removeEventListener("MonsterIsBeat",this.batterPanel);
         this.gc.eventManger.removeEventListener("MonsterIsBeat",this.addWs);
         this.gc.eventManger.removeEventListener("HeroIsBeat",this.addWs);
         this.gc.eventManger.removeEventListener("AuraEvent",this.addWarriors);
      }
      
      private function addWs(param1:*) : void
      {
         var _loc2_:uint = this.rilist.length;
         while(_loc2_-- > 0)
         {
            this.rilist[_loc2_].addWs(param1.data);
         }
      }
      
      private function addWarriors(param1:*) : void
      {
         var _loc2_:uint = this.rilist.length;
         while(_loc2_-- > 0)
         {
            this.rilist[_loc2_].addWarriors(param1.data);
         }
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function step() : *
      {
         ++this.batterSi;
         if(this.batterSi % 20 == 0)
         {
            this.batter();
         }
         var _loc1_:uint = this.rilist.length;
         while(_loc1_-- > 0)
         {
            this.rilist[_loc1_].step();
         }
         this.fps.update();
      }
      
      private function batterPanel(param1:CommonEvent) : *
      {
         if(User.batterNum >= 2)
         {
            if(this.bpanel == null)
            {
               this.bpanel = new Batter();
               addChild(this.bpanel);
               this.bpanel.x = 694.95;
               this.bpanel.y = 234.95;
            }
            this.bpanel.alpha = 1;
            TweenMax.to(this.bpanel,3.5,{
               "alpha":0,
               "onComplete":this.removeBPanel
            });
            this.bpanel.addBatterNum(User.batterNum);
         }
      }
      
      private function removeBPanel() : *
      {
         if(this.bpanel && contains(this.bpanel))
         {
            removeChild(this.bpanel);
            this.bpanel = null;
         }
      }
      
      private function batter() : *
      {
         if(this.preBatterNum == User.batterNum)
         {
            User.batterNum = 0;
            this.preBatterNum = 0;
         }
         else
         {
            this.preBatterNum = User.batterNum;
         }
      }
      
      public function addBossBlood(param1:String, param2:int) : void
      {
         var _loc3_:* = undefined;
         if(!getChildByName("blood"))
         {
            _loc3_ = AUtils.getNewObj("BossBlood");
            _loc3_.name = "blood";
            _loc3_.namemc.gotoAndStop(param1);
            _loc3_.x = 450;
            _loc3_.y = 50;
            this.addChild(_loc3_);
         }
         else
         {
            MovieClip(getChildByName("blood")).gotoAndStop(param2);
         }
      }
   }
}
