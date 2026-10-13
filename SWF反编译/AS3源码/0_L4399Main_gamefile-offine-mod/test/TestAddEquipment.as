package test
{
   import config.Config;
   import export.huodong.mysterious.DragonSingleShop;
   import export.level.StageListener01;
   import export.level.StageListener02;
   import export.level.StageListener101;
   import export.level.StageListener11;
   import export.level.StageListener111;
   import export.level.StageListener112;
   import export.level.StageListener113;
   import export.level.StageListener12;
   import export.level.StageListener121;
   import export.level.StageListener122;
   import export.level.StageListener123;
   import export.level.StageListener124;
   import export.level.StageListener125;
   import export.level.StageListener13;
   import export.level.StageListener131;
   import export.level.StageListener141;
   import export.level.StageListener142;
   import export.level.StageListener151;
   import export.level.StageListener161;
   import export.level.StageListener171;
   import export.level.StageListener172;
   import export.level.StageListener173;
   import export.level.StageListener201;
   import export.level.StageListener21;
   import export.level.StageListener211;
   import export.level.StageListener212;
   import export.level.StageListener213;
   import export.level.StageListener22;
   import export.level.StageListener221;
   import export.level.StageListener222;
   import export.level.StageListener223;
   import export.level.StageListener23;
   import export.level.StageListener253;
   import export.level.StageListener31;
   import export.level.StageListener32;
   import export.level.StageListener33;
   import export.level.StageListener401;
   import export.level.StageListener41;
   import export.level.StageListener411;
   import export.level.StageListener42;
   import export.level.StageListener421;
   import export.level.StageListener43;
   import export.level.StageListener431;
   import export.level.StageListener44;
   import export.level.StageListener441;
   import export.level.StageListener442;
   import export.level.StageListener443;
   import export.level.StageListener451;
   import export.level.StageListener461;
   import export.level.StageListener471;
   import export.level.StageListener4710;
   import export.level.StageListener4711;
   import export.level.StageListener4712;
   import export.level.StageListener4713;
   import export.level.StageListener4714;
   import export.level.StageListener472;
   import export.level.StageListener473;
   import export.level.StageListener474;
   import export.level.StageListener475;
   import export.level.StageListener476;
   import export.level.StageListener477;
   import export.level.StageListener478;
   import export.level.StageListener479;
   import export.level.StageListener481;
   import export.level.StageListener491;
   import export.level.StageListener51;
   import export.level.StageListener61;
   import export.level.StageListener71;
   import export.level.StageListener81;
   import export.level.StageListener91;
   import fl.controls.Button;
   import fl.controls.TextInput;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.ContinuitySignIn;
   import my.MainGame;
   import my.MyEquipObj;
   import my.PetEquipObj;
   import petInfo.PetInfo;
   import user.User;
   
   public class TestAddEquipment extends Sprite
   {
       
      
      private var addBtn:Button;
      
      private var inputTxt:TextInput;
      
      private var resulttxt:TextField;
      
      private var stageTxt:TextInput;
      
      private var levelTxt:TextInput;
      
      private var commandTxt:TextInput;
      
      private var tranferBtn:Button;
      
      private var hideAndShowBtn:Button;
      
      private var gc:Config;
      
      private var stageListener01:StageListener01;
      
      private var stageListener02:StageListener02;
      
      private var stageListener11:StageListener11;
      
      private var stageListener12:StageListener12;
      
      private var stageListener13:StageListener13;
      
      private var stageListener21:StageListener21;
      
      private var stageListener22:StageListener22;
      
      private var stageListener23:StageListener23;
      
      private var stageListener31:StageListener31;
      
      private var stageListener32:StageListener32;
      
      private var stageListener33:StageListener33;
      
      private var stageListener41:StageListener41;
      
      private var stageListener42:StageListener42;
      
      private var stageListener43:StageListener43;
      
      private var stageListener44:StageListener44;
      
      private var stageListener51:StageListener51;
      
      private var stageListener61:StageListener61;
      
      private var stageListener71:StageListener71;
      
      private var stageListener81:StageListener81;
      
      private var stageListener91:StageListener91;
      
      private var stageListener101:StageListener101;
      
      private var stageListener111:StageListener111;
      
      private var stageListener112:StageListener112;
      
      private var stageListener113:StageListener113;
      
      private var stageListener121:StageListener121;
      
      private var stageListener122:StageListener122;
      
      private var stageListener123:StageListener123;
      
      private var stageListener124:StageListener124;
      
      private var stageListener125:StageListener125;
      
      private var stageListener131:StageListener131;
      
      private var stageListener141:StageListener141;
      
      private var stageListener142:StageListener142;
      
      private var stageListener151:StageListener151;
      
      private var stageListener161:StageListener161;
      
      private var stageListener171:StageListener171;
      
      private var stageListener172:StageListener172;
      
      private var stageListener173:StageListener173;
      
      private var stageListener201:StageListener201;
      
      private var stageListener211:StageListener211;
      
      private var stageListener212:StageListener212;
      
      private var stageListener213:StageListener213;
      
      private var stageListener221:StageListener221;
      
      private var stageListener222:StageListener222;
      
      private var stageListener223:StageListener223;
      
      private var stageListener401:StageListener401;
      
      private var stageListener411:StageListener411;
      
      private var stageListener421:StageListener421;
      
      private var stageListener431:StageListener431;
      
      private var stageListener441:StageListener441;
      
      private var stageListener442:StageListener442;
      
      private var stageListener443:StageListener443;
      
      private var stageListener451:StageListener451;
      
      private var stageListener461:StageListener461;
      
      private var stageListener471:StageListener471;
      
      private var stageListener472:StageListener472;
      
      private var stageListener473:StageListener473;
      
      private var stageListener474:StageListener474;
      
      private var stageListener475:StageListener475;
      
      private var stageListener476:StageListener476;
      
      private var stageListener477:StageListener477;
      
      private var stageListener478:StageListener478;
      
      private var stageListener479:StageListener479;
      
      private var stageListener4710:StageListener4710;
      
      private var stageListener4711:StageListener4711;
      
      private var stageListener4712:StageListener4712;
      
      private var stageListener4713:StageListener4713;
      
      private var stageListener4714:StageListener4714;
      
      private var stageListener481:StageListener481;
      
      private var stageListener491:StageListener491;
      
      private var clearBtn:Button;
      
      private var allopen:Button;
      
      public function TestAddEquipment()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         var i:* = 0;
         var obj:* = undefined;
         var bg:Sprite = new Sprite();
         bg.graphics.beginFill(16711680,0.2);
         bg.graphics.drawRect(0,0,150,60);
         bg.graphics.endFill();
         this.addChild(bg);
         this.removeEventListener("addedToStage",added);
         this.x = 0;
         this.y = 400;
         this.inputTxt = new TextInput();
         this.inputTxt.setSize(100,20);
         this.addChild(this.inputTxt);
         this.resulttxt = new TextField();
         this.resulttxt.y = 22;
         this.addChild(this.resulttxt);
         this.addBtn = new Button();
         this.addBtn.setSize(50,20);
         this.addBtn.label = "添加";
         this.addBtn.x = 110;
         this.addChild(this.addBtn);
         this.addBtn.addEventListener("click",add_onClickHandler);
         clearBtn = new Button();
         this.clearBtn.setSize(50,20);
         this.clearBtn.label = "清除签到信息";
         this.clearBtn.x = 170;
         this.addChild(this.clearBtn);
         this.clearBtn.addEventListener("click",clear_onClickHandler);
         this.stageTxt = new TextInput();
         this.stageTxt.setSize(50,20);
         this.stageTxt.y = -30;
         this.addChild(this.stageTxt);
         this.levelTxt = new TextInput();
         this.levelTxt.setSize(50,20);
         this.levelTxt.x = 60;
         this.levelTxt.y = -30;
         this.addChild(this.levelTxt);
         this.tranferBtn = new Button();
         this.tranferBtn.x = 120;
         this.tranferBtn.y = -30;
         this.tranferBtn.setSize(50,20);
         this.tranferBtn.label = "传送";
         this.addChild(this.tranferBtn);
         this.tranferBtn.addEventListener("click",__transfer);
         this.hideAndShowBtn = new Button();
         this.hideAndShowBtn.label = "隐藏";
         this.hideAndShowBtn.setSize(50,20);
         this.hideAndShowBtn.x = 180;
         this.hideAndShowBtn.y = -30;
         this.addChild(this.hideAndShowBtn);
         this.hideAndShowBtn.addEventListener("click",__showAndHideClick);
         this.allopen = new Button();
         this.allopen.label = "全部开启";
         this.allopen.setSize(50,20);
         this.allopen.x = 240;
         this.allopen.y = -30;
         this.addChild(this.allopen);
         this.allopen.addEventListener("click",__allOpenClick);
         this.commandTxt = new TextInput();
         this.commandTxt.setSize(150,20);
         this.commandTxt.y = 30;
         this.addChild(this.commandTxt);
         this.commandTxt.addEventListener("keyDown",__keydown);
         for(i = uint(0); i < this.numChildren; )
         {
            obj = this.getChildAt(i);
            if(obj is TextInput)
            {
               obj.addEventListener("click",__getFocus);
            }
            i++;
         }
      }
      
      protected function __allOpenClick(evt:MouseEvent) : void
      {
         DragonSingleShop;
      }
      
      protected function __keydown(evt:KeyboardEvent) : void
      {
         var command:* = null;
         var commArr:* = null;
         if(evt.keyCode == 13)
         {
            command = this.commandTxt.text;
            commArr = command.split(" ");
            if(commArr.length != 3)
            {
               return;
            }
            if(commArr[0] == "add")
            {
               if(commArr[1] == "potential")
               {
                  for each(var pi in gc.player1.petsAry)
                  {
                     pi.setpotential(pi.getpotential() + int(commArr[2]));
                  }
                  gc.ts.setTxt("成功增加宠物潜力 " + commArr[2] + " 点");
                  gc.stage.addChild(gc.ts);
               }
               else if(commArr[1] == "petexp")
               {
                  for each(pi in gc.player1.petsAry)
                  {
                     pi.setCurExper(int(commArr[2]));
                  }
                  gc.ts.setTxt("成功增加宠物经验 " + commArr[2] + " 点");
                  gc.stage.addChild(gc.ts);
               }
            }
            this.commandTxt.text = "";
         }
      }
      
      protected function clear_onClickHandler(evt:MouseEvent) : void
      {
         ContinuitySignIn.getIns().init();
      }
      
      private function __getFocus(evt:MouseEvent) : void
      {
         trace("设置焦点");
         gc.stage.focus = evt.currentTarget as TextInput;
      }
      
      protected function __transfer(event:MouseEvent) : void
      {
         var level:* = 0;
         var isStage10:Boolean = false;
         if(gc.curStageAndCurLevel.curStage == 10)
         {
            isStage10 = true;
         }
         gc.curStageAndCurLevel.curStage = this.stageTxt.text;
         gc.curStageAndCurLevel.curLevel = this.levelTxt.text;
         if(isStage10)
         {
            if(gc.curStageAndCurLevel.curStage == 10)
            {
               level = uint(gc.curStageAndCurLevel.curLevel);
               level = uint(level > 8 ? 8 : level);
               if(gc.pWorld.getBaseLevelListener())
               {
                  (gc.pWorld.getBaseLevelListener() as StageListener101).gotoLevel(level);
                  return;
               }
            }
         }
         if(gc.curStageAndCurLevel.curStage == 56 && gc.curStageAndCurLevel.curLevel == 1)
         {
            gc.guoqingMonsterId = 182 + Math.floor(RandomControllor.getIns().getRandom() * 2);
         }
         try
         {
            AUtils.getClass("export.level.StageListener" + gc.curStageAndCurLevel.curStage + gc.curStageAndCurLevel.curLevel);
         }
         catch(e:*)
         {
            this.resulttxt.text = "没有这个关卡！";
            return;
         }
         if(gc.curStageAndCurLevel.curStage == 25 && gc.curStageAndCurLevel.curLevel == 3)
         {
            StageListener253.curType1 = 0;
            StageListener253.curType2 = 0;
            StageListener253.curType3 = 0;
         }
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
            gc.eventManger.dispatchEvent(new Event("ReStart"));
         }
         else
         {
            gc.eventManger.dispatchEvent(new Event("selectStageOver"));
         }
      }
      
      protected function __showAndHideClick(event:MouseEvent) : void
      {
         if(this.hideAndShowBtn.label == "隐藏")
         {
            this.hideAndShowBtn.label = "显示";
            gc.stage.focus = null;
            this.x = -170;
         }
         else
         {
            this.hideAndShowBtn.label = "隐藏";
            this.x = 0;
         }
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         this.addBtn.removeEventListener("click",add_onClickHandler);
      }
      
      private function add_onClickHandler(e:MouseEvent) : void
      {
         var up:Number = NaN;
         var fname:String = this.inputTxt.text;
         var equip:* = gc.allEquip.findByName(fname);
         if(fname == "tjbg")
         {
            if(equip is MyEquipObj)
            {
               up = Number((2 + RandomControllor.getIns().getRandom()).toFixed(1));
               (equip as MyEquipObj).setEupdata(up);
            }
         }
         if(equip)
         {
            if(gc.player1.roleid > 0)
            {
               this.putEquipmentInBackpack(gc.player1,equip);
            }
            if(gc.player2.roleid > 0)
            {
               this.putEquipmentInBackpack(gc.player2,equip);
            }
            this.resulttxt.text = "添加成功";
         }
         else
         {
            this.resulttxt.text = "没找到该装备";
         }
      }
      
      private function putEquipmentInBackpack(player:User, equip:Object) : void
      {
         if(equip is PetEquipObj)
         {
            player.plist.push(equip);
         }
         else if(equip.type == "zbfb" || equip.type == "zbwq" || equip.type == "zbfj" || equip.type == "zbsp" || equip.type == "zbtx")
         {
            player.zblist.push(equip);
         }
         else if(equip.type == "zbsz")
         {
            player.szlist.push(equip);
         }
         else if(equip.type == "wpqhs" || equip.type == "zbwp")
         {
            gc.putQhsInBackPack(player,equip.getFillName());
         }
      }
   }
}
