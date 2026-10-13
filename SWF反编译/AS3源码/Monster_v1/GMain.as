package
{
   import PhysicsWorlds.PhysicsWorld;
   import com.greensock.TweenMax;
   import com.hexagonstar.util.debug.Debug;
   import config.Config;
   import event.CommonEvent;
   import export.AboutUs;
   import export.ComeBackAlert;
   import export.FirstAlert;
   import export.GameMenu;
   import export.Help;
   import export.LoadingBar;
   import export.SelectPLace;
   import export.SelectRole;
   import export.lose.GameFail;
   import export.scene.Opening;
   import export.shop.BuySkill;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.LocalConnection;
   import flash.utils.setTimeout;
   import loader.Aloader;
   import manager.SoundManager;
   import my.MainGame;
   import unit4399.events.SaveEvent;
   
   public class GMain extends MovieClip
   {
      
      public static var _4399_function_store_id:String = "3885799f65acec467d97b4923caebaae";
      
      public static var _4399_function_ad_id:String = "92d6cef76cd06829e088932fe9fd819b";
      
      public static var _4399_function_score_id:String = "d8c8d4731a33a0a581edc746e73eadc7200";
      
      public static var serviceHold = null;
      
      private static var _this:GMain;
       
      
      private var gc:Config;
      
      private var _loader:Aloader;
      
      private var mainSence:Sprite;
      
      private var gm:GameMenu;
      
      public function GMain()
      {
         this.gc = new Config();
         super();
         this._loader = new Aloader();
         this._loader.init();
         _this = this;
         this.gc.pWorld = new PhysicsWorld();
         this.gc.lc = new LocalConnection();
         this.gc.num8 = 9;
         this.mainSence = new Sprite();
         this.addChild(this.mainSence);
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      public static function getInstance() : GMain
      {
         return _this;
      }
      
      public function setHold(param1:*) : void
      {
         serviceHold = param1;
      }
      
      private function saveProcess(param1:SaveEvent) : void
      {
         var e:SaveEvent = param1;
         switch(e.type)
         {
            case SaveEvent.SAVE_GET:
               Debug.trace("--SaveEvent.SAVE_GET--");
               Debug.trace("e.data:" + e.data);
               if(this.gc.loginAlert && this.gc.loginAlert.name == "LoginAlert" && this.gc.loginAlert.parent)
               {
                  this.gc.loginAlert.parent.removeChild(this.gc.loginAlert);
                  this.gc.loginAlert = null;
               }
               if(e.data != null)
               {
                  if(!this.gc.loginAlert)
                  {
                     this.gc.loginAlert = new ComeBackAlert();
                     ComeBackAlert(this.gc.loginAlert).x = 470;
                     ComeBackAlert(this.gc.loginAlert).y = 295;
                     ComeBackAlert(this.gc.loginAlert).setUsername(this.gc.logInfo.name);
                     this.addChild(this.gc.loginAlert);
                     setTimeout(function():*
                     {
                        TweenMax.to(gc.loginAlert,2,{
                           "alpha":0,
                           "onComplete":function():*
                           {
                              if(gc.loginAlert && gc.loginAlert.parent)
                              {
                                 gc.loginAlert.parent.removeChild(gc.loginAlert);
                                 gc.loginAlert = null;
                              }
                           }
                        });
                     },2000);
                  }
                  this.gc.memory.storageValue(e.data.index,e.data.data);
               }
               else if(!this.gc.loginAlert)
               {
                  this.gc.loginAlert = new FirstAlert();
                  FirstAlert(this.gc.loginAlert).x = 470;
                  FirstAlert(this.gc.loginAlert).y = 295;
                  FirstAlert(this.gc.loginAlert).setUsername(this.gc.logInfo.name);
                  this.addChild(this.gc.loginAlert);
                  setTimeout(function():*
                  {
                     TweenMax.to(gc.loginAlert,2,{
                        "alpha":0,
                        "onComplete":function():*
                        {
                           if(gc.loginAlert && gc.loginAlert.parent)
                           {
                              gc.loginAlert.parent.removeChild(gc.loginAlert);
                              gc.loginAlert = null;
                           }
                        }
                     });
                  },2000);
               }
               this.gm.showAndHide();
               break;
            case SaveEvent.SAVE_SET:
               if(e.ret as Boolean == true)
               {
                  Debug.trace("======存档成功=======");
                  this.gc.ts.setTxt("存档成功");
                  this.addChild(this.gc.ts);
               }
               else
               {
                  Debug.trace("======存档失败=======");
                  this.gc.ts.setTxt("存档失败");
                  this.addChild(this.gc.ts);
               }
               break;
            case "logreturn":
               this.gc.logInfo = e.ret;
               Debug.trace("e.ret:" + e.ret);
               Debug.trace("e.ret.uid:" + e.ret.uid);
               Debug.trace("e.ret.name:" + e.ret.name);
               Debug.trace("gc.logInfo:" + this.gc.logInfo);
               if(this.gc.usernameHash == "")
               {
                  this.gc.usernameHash = e.ret.name;
               }
               if(e.ret)
               {
                  this.gm.doSelectNum();
               }
         }
      }
      
      public function showProgress(param1:int, param2:int) : void
      {
         var _loc3_:LoadingBar = null;
         if(!this.getChildByName("showProgress"))
         {
            _loc3_ = new LoadingBar();
            _loc3_.name = "showProgress";
            _loc3_.setProcess(param1,param2);
            _loc3_.x = 470;
            _loc3_.y = 295;
            this.addChild(_loc3_);
         }
         else
         {
            LoadingBar(this.getChildByName("showProgress")).setProcess(param1,param2);
         }
      }
      
      public function processComplete() : void
      {
         var _loc1_:MovieClip = this.getChildByName("showProgress") as MovieClip;
         if(_loc1_)
         {
            this.removeChild(_loc1_);
            _loc1_ = null;
         }
      }
      
      public function switchSence(param1:String) : void
      {
         switch(param1)
         {
            case "startFighting":
               this.startGame(this.gc.curStage,this.gc.curLevel);
               break;
            case "GameMenu":
               this.showGameMenu();
               break;
            case "SelectRole":
               this.showSelectRolw();
               break;
            case "showStageMap":
               this.showStageMap();
               break;
            case "gameOver":
               this.showGameOver();
               break;
            case "OpenAnimation":
               this.showOpenAnimation();
         }
      }
      
      private function added(param1:*) : void
      {
         this.gc.eventManger.addEventListener("LoadOver",this.loaderOver);
         this.gc.eventManger.addEventListener("StartSelectRole",this.selectRole);
         this.gc.eventManger.addEventListener("SelectOver",this.SelectRoleOver);
         this.gc.eventManger.addEventListener("selectStageOver",this.selectStageOver);
         this.gc.eventManger.addEventListener("showBuySkill",this.showBuySkill);
         this.gc.eventManger.addEventListener("heroDead",this.heroDead);
         this.gc.eventManger.addEventListener("GameOver",this.gameOver);
         this.gc.eventManger.addEventListener("ReStart",this.reStart);
         this.gc.eventManger.addEventListener("ShowOpenAnimation",this.showOpenAnimation);
         this.gc.eventManger.addEventListener("ShowOpenAnimationOver",this.showOpenAnimationOver);
         this.gc.eventManger.addEventListener("showAboutUs",this.showAboutUs);
         this.gc.eventManger.addEventListener("GameHelp",this.gameHelp);
         stage.addEventListener("netSaveError",this.netSaveErrorHandler,false,0,true);
         stage.addEventListener("MVC_CLOSE_PANEL",this.closePanelHandler,false,0,true);
         stage.addEventListener(SaveEvent.SAVE_GET,this.saveProcess);
         stage.addEventListener(SaveEvent.SAVE_SET,this.saveProcess);
         stage.addEventListener("logreturn",this.saveProcess);
         this.gc.stage = this.stage;
      }
      
      private function removed(param1:*) : void
      {
         this.gc.eventManger.removeEventListener("LoadOver",this.loaderOver);
         this.gc.eventManger.removeEventListener("StartSelectRole",this.selectRole);
         this.gc.eventManger.removeEventListener("SelectOver",this.SelectRoleOver);
         this.gc.eventManger.removeEventListener("selectStageOver",this.selectStageOver);
         this.gc.eventManger.removeEventListener("showBuySkill",this.showBuySkill);
         this.gc.eventManger.removeEventListener("heroDead",this.heroDead);
         this.gc.eventManger.removeEventListener("GameOver",this.gameOver);
         this.gc.eventManger.removeEventListener("ReStart",this.reStart);
         this.gc.eventManger.removeEventListener("ShowOpenAnimation",this.showOpenAnimation);
         this.gc.eventManger.removeEventListener("ShowOpenAnimationOver",this.showOpenAnimationOver);
         this.gc.eventManger.removeEventListener("showAboutUs",this.showAboutUs);
         this.gc.eventManger.removeEventListener("GameHelp",this.gameHelp);
      }
      
      private function closePanelHandler(param1:Event) : void
      {
         if(this.gc.loginAlert && this.gc.loginAlert.parent)
         {
            this.gc.loginAlert.parent.removeChild(this.gc.loginAlert);
            this.gc.loginAlert = null;
         }
      }
      
      private function showAboutUs(param1:CommonEvent) : void
      {
         var _loc2_:AboutUs = AUtils.getNewObj("export.AboutUs") as AboutUs;
         this.mainSence.addChild(_loc2_);
      }
      
      private function gameHelp(param1:CommonEvent) : void
      {
         var _loc2_:Help = AUtils.getNewObj("export.Help") as Help;
         this.mainSence.addChild(_loc2_);
      }
      
      private function showOpenAnimation() : void
      {
         var _loc1_:Opening = AUtils.getNewObj("export.scene.Opening") as Opening;
         this.mainSence.addChild(_loc1_);
      }
      
      private function showOpenAnimationOver(param1:*) : void
      {
         this.switchSence("showStageMap");
      }
      
      private function showBuySkill(param1:CommonEvent) : void
      {
         var _loc2_:BuySkill = AUtils.getNewObj("export.shop.BuySkill") as BuySkill;
         _loc2_.setCurrentState(param1.data.state);
         this.mainSence.addChild(_loc2_);
      }
      
      private function SelectRoleOver(param1:*) : void
      {
         if(this.gc.memory.judgeSave() || this.gc.opening)
         {
            this.switchSence("showStageMap");
         }
         else
         {
            this.switchSence("OpenAnimation");
         }
      }
      
      private function showStageMap() : void
      {
         SoundManager.play("begin");
         var _loc1_:SelectPLace = AUtils.getNewObj("export.SelectPLace") as SelectPLace;
         this.mainSence.addChild(_loc1_);
      }
      
      private function selectStageOver(param1:*) : void
      {
         this.switchSence("startFighting");
      }
      
      private function showGameMenu() : void
      {
         if(this.gm == null)
         {
            this.gm = AUtils.getNewObj("export.GameMenu") as GameMenu;
         }
         this.mainSence.addChild(this.gm);
      }
      
      private function selectRole(param1:*) : *
      {
         this.switchSence("SelectRole");
      }
      
      private function showSelectRolw() : void
      {
         var _loc1_:SelectRole = AUtils.getNewObj("export.SelectRole") as SelectRole;
         this.mainSence.addChild(_loc1_);
      }
      
      private function gameOver(param1:*) : void
      {
         this.switchSence("gameOver");
      }
      
      private function showGameOver() : void
      {
         SoundManager.play("over");
         var _loc1_:GameFail = AUtils.getNewObj("export.lose.GameFail") as GameFail;
         this.mainSence.addChild(_loc1_);
      }
      
      private function reStart(param1:*) : void
      {
         this.switchSence("startFighting");
      }
      
      private function heroDead(param1:CommonEvent) : void
      {
         var _loc2_:* = AUtils.getNewObj("deadmb");
         _loc2_.x = param1.data.x;
         _loc2_.y = param1.data.y - 10;
         this.gc.gameSence.addChild(_loc2_);
         param1.data.destroy();
      }
      
      public function startGame(param1:uint, param2:uint) : void
      {
         new MainGame(this.mainSence).GameStart(this.gc.curStage,this.gc.curLevel);
      }
      
      private function doLoadOK() : void
      {
         var _loc2_:* = undefined;
         this.gc.pWorld.destroy();
         var _loc1_:int = 0;
         while(_loc1_ < this.numChildren)
         {
            _loc2_ = this.getChildAt(_loc1_);
            this.gc.pWorld.addSubObj(_loc2_);
            _loc1_++;
         }
         this.switchSence("GameMenu");
      }
      
      private function loaderOver(param1:*) : *
      {
         this.gc.eventManger.removeEventListener("loaderOver",this.loaderOver);
         AUtils.checkLoadOK(this,this.doLoadOK);
      }
      
      public function getMainSence() : Sprite
      {
         return this.mainSence;
      }
      
      private function netSaveErrorHandler(param1:Event) : void
      {
         this.gc.ts.setTxt("存档失败");
         this.addChild(this.gc.ts);
      }
   }
}
