package export
{
   import base.BaseHero;
   import com.greensock.TweenMax;
   import com.multi4399.ResponseEvent;
   import config.Config;
   import event.CommonEvent;
   import export.muti.ArenaSprite;
   import export.muti.TotalOtherUserInfo;
   import fl.controls.TextArea;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FPS;
   import user.MutiUser;
   import user.User;
   
   public class GameInfo extends MovieClip
   {
       
      
      private var gc:Config;
      
      private var preBatterNum:int = 0;
      
      private var batterSi:int;
      
      private var rilist:Array;
      
      public var pointmc:Sprite;
      
      public var fpsShow:TextField;
      
      public var buffSprite:HeroBuff;
      
      public var hideOtherPlayerBtn:SimpleButton;
      
      public var showOtherPlayerBtn:SimpleButton;
      
      public var backToHostBtn:SimpleButton;
      
      private var infoSprite:Sprite;
      
      public var bossBloodArray:Array;
      
      private var chatSprite:ChatInHostSprite;
      
      private var arenaSprite:ArenaSprite;
      
      private var totalOtherUserInfoSprite:TotalOtherUserInfo;
      
      private var isHideOther:Boolean = false;
      
      private var fps:FPS;
      
      var bpanel:Batter;
      
      public function GameInfo()
      {
         rilist = [];
         bossBloodArray = [];
         fps = new FPS();
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         this.addEventListener("click",__clickHandler);
         this.init();
      }
      
      private function init() : void
      {
         this.refreshRoleInfo();
         fps.display = fpsShow;
         fps.startCalc();
      }
      
      private function __clickHandler(evt:MouseEvent) : void
      {
         var bh:* = null;
         var sprite:* = null;
         if(evt.target.name == "hideOtherPlayerBtn")
         {
            for each(bh in gc.pWorld.getOtherHeroArray())
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
            this.isHideOther = true;
         }
         else if(evt.target.name == "showOtherPlayerBtn")
         {
            for each(bh in gc.pWorld.getOtherHeroArray())
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
            this.isHideOther = false;
         }
         else if(evt.target.name == "backToHostBtn")
         {
            gc.quitRoom();
            sprite = new Sprite();
            sprite.name = "mask";
            sprite.graphics.beginFill(16777215,0.5);
            sprite.graphics.drawRect(0,0,940,590);
            sprite.graphics.endFill();
            this.addChild(sprite);
         }
         else if(!(evt.target is TextField) && !(evt.target is TextArea))
         {
            gc.stage.focus = null;
         }
      }
      
      public function pkStart() : void
      {
         this.backToHostBtn.visible = false;
      }
      
      public function showArenaSprite() : void
      {
         if(!this.arenaSprite)
         {
            this.arenaSprite = new ArenaSprite();
            GMain.getInstance().getTopSence().addChild(this.arenaSprite);
         }
      }
      
      private function refreshRoleInfo() : void
      {
         var ri:* = null;
         for each(var r in this.rilist)
         {
            if(this.contains(r))
            {
               this.removeChild(r);
            }
         }
         this.rilist = [];
         if(gc.player1.roleid > 0)
         {
            ri = new RoleInfo(1);
            this.addChild(ri);
            rilist.push(ri);
         }
         if(gc.player2.roleid > 0)
         {
            ri = new RoleInfo(2);
            ri.x = 920;
            this.addChild(ri);
            AUtils.flipHorizontal(ri,-1);
            rilist.push(ri);
         }
         else if(gc.player3.roleid > 0)
         {
            if(!gc.isCannotUsePlayer3())
            {
               ri = new RoleInfo(3);
               ri.x = 920;
               this.addChild(ri);
               AUtils.flipHorizontal(ri,-1);
               rilist.push(ri);
            }
         }
      }
      
      public function addHeroBuff() : void
      {
         for each(var r in this.rilist)
         {
            r.addHeroBuff();
         }
      }
      
      public function removeHeroBuff(name:String) : void
      {
         for each(var r in this.rilist)
         {
            r.removeHeroBuff(name);
         }
      }
      
      public function joinRoomReturn(result:uint) : void
      {
         if(result == 1)
         {
            if(this.arenaSprite)
            {
               this.arenaSprite.destroy();
               this.arenaSprite = null;
            }
            this.totalOtherUserInfoSprite = new TotalOtherUserInfo();
            this.totalOtherUserInfoSprite.x = 240;
            this.totalOtherUserInfoSprite.y = 30;
            this.addChild(this.totalOtherUserInfoSprite);
            this.doWhenIntoRoom();
         }
         else if(this.arenaSprite)
         {
            this.arenaSprite.joinOrCreateFail();
         }
      }
      
      public function createReturn(result:uint) : void
      {
         if(result == 1)
         {
            if(this.arenaSprite)
            {
               this.arenaSprite.destroy();
               this.arenaSprite = null;
            }
            this.totalOtherUserInfoSprite = new TotalOtherUserInfo();
            this.totalOtherUserInfoSprite.x = 240;
            this.totalOtherUserInfoSprite.y = 30;
            this.addChild(this.totalOtherUserInfoSprite);
            this.doWhenIntoRoom();
         }
         else if(this.arenaSprite)
         {
            this.arenaSprite.joinOrCreateFail();
         }
      }
      
      public function clearOtherUserInfoSprite() : void
      {
         if(this.totalOtherUserInfoSprite)
         {
            this.totalOtherUserInfoSprite.clear();
         }
      }
      
      public function quitRoom() : void
      {
         hideOtherPlayerBtn.visible = true;
         showOtherPlayerBtn.visible = true;
         backToHostBtn.visible = false;
         var sp:Sprite = this.getChildByName("mask") as Sprite;
         if(sp)
         {
            this.removeChild(sp);
         }
         gc.createHeroWhenQuitRoom();
         if(this.totalOtherUserInfoSprite && this.contains(this.totalOtherUserInfoSprite))
         {
            this.removeChild(this.totalOtherUserInfoSprite);
            this.totalOtherUserInfoSprite = null;
         }
         this.refreshRoleInfo();
         this.showArenaSprite();
      }
      
      public function addOtherUserInfoOne(muti:MutiUser) : void
      {
         if(this.totalOtherUserInfoSprite)
         {
            this.totalOtherUserInfoSprite.addOne(muti);
         }
      }
      
      public function removeOtherUserInfoOne(sid:*) : void
      {
         if(this.totalOtherUserInfoSprite)
         {
            this.totalOtherUserInfoSprite.removeOne(sid);
         }
      }
      
      public function updateInfo(_roomName:*, _gameMode:*, _mpInfo:*, _maxPlayers:*, _averLevel:*) : void
      {
         if(this.arenaSprite)
         {
            this.arenaSprite.updateAllInfo(_roomName,_gameMode,_mpInfo,_maxPlayers,_averLevel);
         }
      }
      
      public function addChatSprite() : void
      {
         if(gc.isInHost() || gc.isInRoom())
         {
         }
      }
      
      private function __sendChat(evt:CommonEvent) : void
      {
         var str:String = evt.data[0];
         gc.sendChat(str);
      }
      
      public function singleGame() : void
      {
         hideOtherPlayerBtn.visible = false;
         showOtherPlayerBtn.visible = false;
         backToHostBtn.visible = false;
      }
      
      public function mutiGame() : void
      {
         hideOtherPlayerBtn.visible = true;
         showOtherPlayerBtn.visible = true;
         backToHostBtn.visible = false;
      }
      
      private function doWhenIntoRoom() : void
      {
         hideOtherPlayerBtn.visible = false;
         showOtherPlayerBtn.visible = false;
         backToHostBtn.visible = true;
      }
      
      public function updateRoomList(e:ResponseEvent) : void
      {
         if(this.arenaSprite)
         {
            this.arenaSprite.refreshData(e);
         }
      }
      
      public function updataChatData(name:String, str:String) : void
      {
         if(this.chatSprite && this.contains(this.chatSprite))
         {
            this.chatSprite.updateData(name,str);
         }
      }
      
      public function showBuff() : void
      {
         if(!this.buffSprite)
         {
            this.buffSprite = new HeroBuff();
            this.buffSprite.x = 0;
            this.buffSprite.y = 80;
            this.addChild(this.buffSprite);
         }
      }
      
      public function getRoleInfoByPlayer(p:User) : RoleInfo
      {
         return this.rilist[p.getControlPlayer()];
      }
      
      private function added(e:Event) : *
      {
         trace("GameInfo--added");
         gc.eventManger.addEventListener("MonsterIsBeat",batterPanel);
         gc.eventManger.addEventListener("MonsterIsBeat",addWs);
         gc.eventManger.addEventListener("HeroIsBeat",addWs);
         gc.eventManger.addEventListener("AuraEvent",addWarriors);
         hideOtherPlayerBtn.visible = false;
         showOtherPlayerBtn.visible = false;
         backToHostBtn.visible = false;
         gc.savedBuff.y = 200;
         this.addChild(gc.savedBuff);
      }
      
      private function removed(e:Event) : *
      {
         trace("GameInfo--removed");
         gc.eventManger.removeEventListener("MonsterIsBeat",batterPanel);
         gc.eventManger.removeEventListener("MonsterIsBeat",addWs);
         gc.eventManger.removeEventListener("HeroIsBeat",addWs);
         gc.eventManger.removeEventListener("AuraEvent",addWarriors);
      }
      
      private function addWs(e:*) : void
      {
         var rlen:uint = this.rilist.length;
         while(rlen-- > 0)
         {
            this.rilist[rlen].addWs(e.data);
         }
      }
      
      private function addWarriors(e:*) : void
      {
         var rlen:uint = this.rilist.length;
         while(rlen-- > 0)
         {
            this.rilist[rlen].addWarriors(e.data);
         }
      }
      
      public function destroy() : void
      {
         var j:int = 0;
         if(this.arenaSprite)
         {
            this.arenaSprite.destroy();
            this.arenaSprite = null;
         }
         if(this.totalOtherUserInfoSprite)
         {
            this.removeChild(this.totalOtherUserInfoSprite);
            this.totalOtherUserInfoSprite = null;
         }
         if(gc.ts && this.contains(gc.ts))
         {
            this.removeChild(gc.ts);
         }
         if(this.infoSprite)
         {
            if(this.contains(this.infoSprite))
            {
               this.removeChild(this.infoSprite);
            }
            this.infoSprite = null;
         }
         if(this.buffSprite)
         {
            if(this.contains(this.buffSprite))
            {
               this.removeChild(this.buffSprite);
            }
            this.buffSprite = null;
         }
         this.bossBloodArray.length = 0;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.chatSprite)
         {
            this.chatSprite.removeEventListener("sendChat",__sendChat);
            this.chatSprite.destroy();
            this.chatSprite = null;
         }
         if(gc.savedBuff)
         {
            gc.savedBuffString = gc.savedBuff.getMemoryString();
            gc.savedBuff.destroy();
         }
         for(j = 0; j < this.numChildren; )
         {
            this.removeChild(this.getChildAt(0));
            j++;
         }
         this.removeEventListener("click",__clickHandler);
      }
      
      public function step() : *
      {
         batterSi++;
         if(batterSi % 20 == 0)
         {
            this.batter();
         }
         var rlen:uint = rilist.length;
         while(rlen-- > 0)
         {
            rilist[rlen].step();
         }
         if(this.buffSprite)
         {
            this.buffSprite.step();
         }
         if(gc.savedBuff)
         {
            gc.savedBuff.step();
         }
         fps.update();
         if(this.totalOtherUserInfoSprite)
         {
            this.totalOtherUserInfoSprite.step();
         }
      }
      
      private function batterPanel(e:CommonEvent) : *
      {
         if(User.batterNum >= 2)
         {
            if(bpanel == null)
            {
               bpanel = new Batter();
               addChild(bpanel);
               bpanel.x = 694.95;
               bpanel.y = 234.95;
            }
            bpanel.alpha = 1;
            TweenMax.to(bpanel,3.5,{
               "alpha":0,
               "onComplete":this.removeBPanel
            });
            bpanel.addBatterNum(User.batterNum);
         }
      }
      
      private function removeBPanel() : *
      {
         if(bpanel && contains(bpanel))
         {
            removeChild(bpanel);
            bpanel = null;
         }
      }
      
      private function batter() : *
      {
         User.biggestbatterNum = User.biggestbatterNum > User.batterNum ? User.biggestbatterNum : User.batterNum;
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
      
      public function addBossBlood(name:String, data:int) : void
      {
         var blood:* = null;
         if(!getChildByName(name))
         {
            blood = new gc.bossBloodClass();
            blood.name = name;
            blood.stop();
            blood.namemc.gotoAndStop(name);
            blood.x = 465;
            blood.y = 50 + this.bossBloodArray.length * 50;
            this.addChild(blood);
            this.bossBloodArray.push(blood);
         }
         else
         {
            MovieClip(getChildByName(name)).gotoAndStop(data);
         }
      }
      
      public function clearBossBlood() : void
      {
         for each(var obj in this.bossBloodArray)
         {
            if(this.contains(obj))
            {
               this.removeChild(obj);
            }
         }
         this.bossBloodArray.length = 0;
      }
      
      public function getIsHideOther() : Boolean
      {
         return this.isHideOther;
      }
   }
}
