package export.strength
{
   import base.BaseHero;
   import config.Config;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class SutraInterface extends Sprite
   {
       
      
      private var txt_fbname:TextField;
      
      public var txt_fbdj:TextField;
      
      public var txt_fbczl:TextField;
      
      public var txt_fbwx:TextField;
      
      public var txt_fbatk:TextField;
      
      public var txt_fbdef:TextField;
      
      public var txt_fbhx:TextField;
      
      public var txt_fbhl:TextField;
      
      public var txt_fblh:TextField;
      
      public var btn_sj:SimpleButton;
      
      public var btn_close:SimpleButton;
      
      public var lhmc:MovieClip;
      
      public var showmc:MovieClip;
      
      public var introducemc:MovieClip;
      
      public var resetbtn:SimpleButton;
      
      private var currentSura:MyEquipObj;
      
      private var oldEquip:MyEquipObj;
      
      private var hero:BaseHero;
      
      private var gc:Config;
      
      private var issave:Boolean = false;
      
      private var isKeyOperation:Boolean = false;
      
      private var renewalse:RenewalseThisSZ;
      
      public function SutraInterface()
      {
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         var txtformat:TextFormat = new TextFormat();
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = 16777215;
         txtformat.size = 14;
         this.txt_fbname = new TextField();
         this.txt_fbname.embedFonts = true;
         this.txt_fbname.wordWrap = true;
         this.txt_fbname.defaultTextFormat = txtformat;
         this.txt_fbname.x = 207;
         this.txt_fbname.y = 175;
         this.txt_fbname.width = 122;
         this.txt_fbname.height = 22;
         this.addChild(this.txt_fbname);
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      public function setRole(who:BaseHero) : void
      {
         this.hero = who;
         currentSura = hero.getPlayer().getCurEquipByType("zbfb");
         if(currentSura)
         {
            this.oldEquip = currentSura;
            this.showmc.gotoAndStop(currentSura.ename);
            this.introducemc.gotoAndStop(currentSura.ename);
            if(this.introducemc["saymc"])
            {
               if(this.currentSura.getELevel() >= 6)
               {
                  this.introducemc["saymc"].gotoAndStop(2);
               }
            }
            this.setTxt();
         }
      }
      
      private function added(e:Event) : void
      {
         this.btn_close.addEventListener("click",close);
         this.btn_sj.addEventListener("click",sjMethod);
         resetbtn.addEventListener("click",pushSutraAttribut);
      }
      
      private function removed(e:Event) : void
      {
         this.btn_close.removeEventListener("click",close);
         this.btn_sj.removeEventListener("click",sjMethod);
         resetbtn.removeEventListener("click",pushSutraAttribut);
         this.hero = null;
         if(this.issave)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
      }
      
      private function setTxt() : void
      {
         if(currentSura)
         {
            this.lhmc.gotoAndStop(int(this.hero.getPlayer().getLhValue() / (this.getNextGradeLHValue(currentSura.getELevel()) + 1) * 50));
            this.txt_fblh.text = int(this.hero.getPlayer().getLhValue()) + "/" + this.getNextGradeLHValue(currentSura.getELevel());
            this.txt_fbname.text = currentSura.ename;
            this.txt_fbdj.text = currentSura.getELevel() + "";
            this.txt_fbczl.text = currentSura.getEUpdata() + "";
            this.txt_fbwx.text = currentSura.getWX();
            this.txt_fbatk.text = int(currentSura.geteatt()) + "";
            this.txt_fbdef.text = int(currentSura.getedef()) + "";
            this.txt_fbhx.text = int(currentSura.getehp()) + "";
            this.txt_fbhl.text = int(currentSura.getemp()) + "";
         }
      }
      
      private function close(e:Event) : void
      {
         if(this.isKeyOperation)
         {
            this.hero.roleProperies.removeEquip(this.oldEquip);
            this.hero.roleProperies.addEquip(this.currentSura);
            hero.getPlayer().setCurrentByType("zbfb",this.currentSura);
         }
         MainGame.getInstance().continueGame();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function sjMethod(e:Event) : void
      {
         var nextNeedLHValue:int = 0;
         var obj:* = null;
         var nextNeedZZValue:int = 0;
         var ms:* = null;
         if(currentSura)
         {
            if(this.currentSura.getFillName() == "tjbg")
            {
               if(this.currentSura.getELevel() < 9)
               {
                  this.upDataTJBG();
               }
               else
               {
                  gc.ts.setTxt("该法宝已无法升级");
                  gc.stage.addChild(gc.ts);
               }
               return;
            }
            if(this.currentSura.getELevel() < 10)
            {
               nextNeedLHValue = this.getNextGradeLHValue(currentSura.getELevel());
               if(this.hero.getPlayer().getLhValue() >= nextNeedLHValue)
               {
                  this.hero.roleProperies.removeEquip(this.currentSura);
                  obj = currentSura.getGrowthByName(currentSura.getFillName());
                  this.currentSura.growth(obj);
                  this.hero.getPlayer().setLhValue(this.hero.getPlayer().getLhValue() - nextNeedLHValue);
                  this.setTxt();
                  this.hero.roleProperies.addEquip(this.currentSura);
                  this.isKeyOperation = true;
               }
               else
               {
                  gc.ts.setTxt("灵魂不够");
                  gc.stage.addChild(gc.ts);
               }
            }
            else if(this.currentSura.getELevel() >= 10 && this.currentSura.getELevel() < 15)
            {
               nextNeedZZValue = this.getNextGradeZZValue(currentSura.getELevel() - 9);
               ms = AUtils.getNewObj("updataFBWithLvdyl");
               ms.name = "updataFBWithLvdyl";
               ms["txt"].text = "您确定将法宝升级到" + (currentSura.getELevel() + 1) + "级，消耗" + nextNeedZZValue + "龙女的眼泪";
               ms["okbtn"].addEventListener("click",uokClick);
               ms["nobtn"].addEventListener("click",unoClick);
               this.addChild(ms);
            }
         }
      }
      
      private function upDataTJBG() : void
      {
         var ms:Sprite = AUtils.getNewObj("updataFBWithLvdyl");
         ms.name = "updataFBWithLvdyl";
         ms["txt"].text = "";
         var obj:Object = this.getNextGradeKLYValue(this.currentSura.getELevel() + 1);
         ms["txt"].text = "您确定将法宝升级到" + (currentSura.getELevel() + 1) + "级，消耗" + obj.num + "个" + obj.cname;
         if(ms["txt"].text != "")
         {
            ms["okbtn"].addEventListener("click",specialUokClick);
            ms["nobtn"].addEventListener("click",unoClick);
            this.addChild(ms);
         }
      }
      
      private function specialUokClick(e:MouseEvent) : void
      {
         var obj2:* = null;
         this.removeYLupdataMask();
         var obj:Object = this.getNextGradeKLYValue(this.currentSura.getELevel() + 1);
         if(this.hero.getPlayer().getSomeOneEquipNumberByName(obj.kly) >= obj.num)
         {
            this.hero.roleProperies.removeEquip(this.currentSura);
            obj2 = currentSura.getGrowthByName(currentSura.getFillName());
            this.currentSura.growth(obj2);
            this.hero.getPlayer().removeEquipFormBack(obj.kly,2,obj.num);
            this.setTxt();
            this.hero.roleProperies.addEquip(this.currentSura);
            this.isKeyOperation = true;
         }
         else
         {
            gc.ts.setTxt(obj.cname + "数量不够");
            gc.stage.addChild(gc.ts);
         }
         if(this.introducemc["saymc"])
         {
            if(this.currentSura.getELevel() >= 6)
            {
               this.introducemc["saymc"].gotoAndStop(2);
            }
         }
      }
      
      private function uokClick(e:MouseEvent) : void
      {
         var obj:* = null;
         this.removeYLupdataMask();
         var nextNeedZZValue:int = this.getNextGradeZZValue(currentSura.getELevel() - 9);
         if(this.hero.getPlayer().getSomeOneEquipNumberByName("wplvdyl") >= nextNeedZZValue)
         {
            this.hero.roleProperies.removeEquip(this.currentSura);
            obj = currentSura.getGrowthByName(currentSura.getFillName());
            this.currentSura.growth(obj);
            this.hero.getPlayer().removeEquipFormBack("wplvdyl",2,nextNeedZZValue);
            this.setTxt();
            this.hero.roleProperies.addEquip(this.currentSura);
            this.isKeyOperation = true;
         }
         else
         {
            gc.ts.setTxt("龙女的眼泪不够");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function unoClick(e:MouseEvent) : void
      {
         this.removeYLupdataMask();
      }
      
      private function removeYLupdataMask() : void
      {
         var ms:Sprite = this.getChildByName("updataFBWithLvdyl") as Sprite;
         ms["okbtn"].removeEventListener("click",uokClick);
         ms["nobtn"].removeEventListener("click",unoClick);
         if(ms)
         {
            this.removeChild(ms);
         }
      }
      
      private function pushSutraAttribut(e:MouseEvent) : void
      {
         if(!gc.isHideDebug)
         {
            this.renewalseOk(null);
         }
         else if(gc.gameVip.getVipLevel() >= 4)
         {
            if(gc.gameVip.vipsavelist[5] < 3)
            {
               this.addRenewalseMask("您确定要洗练法宝属性？ 还剩" + (3 - gc.gameVip.vipsavelist[5]) + "次");
            }
            else
            {
               gc.ts.setTxt("您的次数已经用完!");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            gc.ts.setTxt("您的VIP等级不够");
            gc.stage.addChild(gc.ts);
         }
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         this.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         this.issave = true;
         this.isKeyOperation = true;
         gc.gameVip.vipsavelist[5] += 1;
         this.hero.roleProperies.removeEquip(this.currentSura);
         gc.allEquip.refreshSutraAttribute(this.currentSura);
         this.hero.roleProperies.addEquip(this.currentSura);
         this.setTxt();
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function getNextGradeKLYValue(level:int) : Object
      {
         var obj:Object = {};
         var stype:String = "kly";
         var sCname:String = "级昆仑玉";
         if(level <= 5)
         {
            stype = "kly";
            sCname = "级昆仑玉";
            obj.kly = stype + (level - 1);
            obj.num = Math.pow(2,level - 1);
         }
         else if(level > 5 && level <= 9)
         {
            stype = "xns";
            sCname = "级仙女石";
            obj.kly = stype + (level - 5);
            obj.num = Math.pow(2,level - 4);
         }
         var title:String = "1";
         if(level == 3 || level == 7)
         {
            title = "2";
         }
         else if(level == 4 || level == 8)
         {
            title = "3";
         }
         else if(level == 5 || level == 9)
         {
            title = "4";
         }
         obj.cname = title + sCname;
         return obj;
      }
      
      private function getNextGradeZZValue(level:int) : int
      {
         return level * level * 2;
      }
      
      private function getNextGradeLHValue(level:int) : int
      {
         return level * level * 1000;
      }
   }
}
