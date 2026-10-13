package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import flash.display.MovieClip;
   import flash.events.Event;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class StageListener161 extends BaseLevelListenering
   {
       
      
      private var _light:MovieClip;
      
      private var _player1FuyuanMC:MovieClip;
      
      private var _player2FuyuanMC:MovieClip;
      
      public function StageListener161()
      {
         super();
         this.waitForRegisterDataArray = ["Monster69","Monster101"];
      }
      
      override public function step() : void
      {
         var shsjt:* = null;
         var isJinduOK:Boolean = false;
         super.step();
         if(this._light)
         {
            if(this._light.visible)
            {
               for each(var bh in gc.getPlayerArray())
               {
                  if(AUtils.GetDisBetweenTwoObj(bh,this._light) <= 100)
                  {
                     shsjt = bh.getPlayer().getCurEquipByType("zbsp");
                     if(shsjt)
                     {
                        if(shsjt.getFillName() == "psdclj")
                        {
                           isJinduOK = false;
                           if(bh.getPlayer() == gc.player1)
                           {
                              if(this._player1FuyuanMC)
                              {
                                 this._player1FuyuanMC.gotoAndStop(this._player1FuyuanMC.currentFrame + 1);
                                 if(this._player1FuyuanMC.currentFrame == this._player1FuyuanMC.totalFrames)
                                 {
                                    isJinduOK = true;
                                    gc.gameSence.removeChild(this._player1FuyuanMC);
                                    this._player1FuyuanMC = null;
                                 }
                              }
                              else
                              {
                                 this._player1FuyuanMC = AUtils.getNewObj("Stage151Jindutiao") as MovieClip;
                                 this._player1FuyuanMC.x = bh.x + 20;
                                 this._player1FuyuanMC.y = bh.y - 40;
                                 gc.gameSence.addChild(this._player1FuyuanMC);
                              }
                           }
                           else if(this._player2FuyuanMC)
                           {
                              this._player2FuyuanMC.gotoAndStop(this._player2FuyuanMC.currentFrame + 1);
                              if(this._player2FuyuanMC.currentFrame == this._player2FuyuanMC.totalFrames)
                              {
                                 isJinduOK = true;
                                 gc.gameSence.removeChild(this._player2FuyuanMC);
                                 this._player2FuyuanMC = null;
                              }
                           }
                           else
                           {
                              this._player2FuyuanMC = AUtils.getNewObj("Stage151Jindutiao") as MovieClip;
                              this._player2FuyuanMC.x = bh.x - 20;
                              this._player2FuyuanMC.y = bh.y - 40;
                              gc.gameSence.addChild(this._player2FuyuanMC);
                           }
                           if(isJinduOK)
                           {
                              if(bh.roleProperies)
                              {
                                 bh.roleProperies.removeAllEquip();
                                 bh.getPlayer().doWhenCljReduction();
                                 bh.roleProperies.addAllEquip();
                                 gc.ts.setTxt("成功复原了苍龙戒");
                                 gc.stage.addChild(gc.ts);
                              }
                           }
                        }
                     }
                  }
                  else if(bh.getPlayer() == gc.player1)
                  {
                     if(this._player1FuyuanMC)
                     {
                        this._player1FuyuanMC.gotoAndStop(1);
                        gc.gameSence.removeChild(this._player1FuyuanMC);
                        this._player1FuyuanMC = null;
                     }
                  }
                  else if(bh.getPlayer() == gc.player2)
                  {
                     if(this._player2FuyuanMC)
                     {
                        this._player2FuyuanMC.gotoAndStop(1);
                        gc.gameSence.removeChild(this._player2FuyuanMC);
                        this._player2FuyuanMC = null;
                     }
                  }
               }
            }
         }
      }
      
      override public function start() : void
      {
         super.start();
         this._light = gc.gameSence.getChildByNameInBgSprite("Light") as MovieClip;
         if(this._light)
         {
            this._light.visible = false;
         }
         MainGame.getInstance().createMonster(69,400,200);
         gc.eventManger.addEventListener("showStage161Light",showLight);
         gc.eventManger.addEventListener("hideStage161Light",hideLight);
      }
      
      private function showLight(evt:Event) : void
      {
         if(this._light)
         {
            this._light.visible = true;
         }
      }
      
      private function hideLight(evt:Event) : void
      {
         if(this._light)
         {
            this._light.visible = false;
         }
      }
      
      override public function destroy() : void
      {
         gc.eventManger.removeEventListener("showStage161Light",showLight);
         gc.eventManger.removeEventListener("hideStage161Light",hideLight);
         super.destroy();
         this._light = null;
      }
   }
}
