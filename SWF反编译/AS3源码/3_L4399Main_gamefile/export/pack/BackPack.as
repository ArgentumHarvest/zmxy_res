package export.pack
{
   import base.BaseHero;
   import config.Config;
   import event.CommonEvent;
   import export.rank.RankPropertyCount;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MainGame;
   import my.MyEquipObj;
   import user.User;
   
   public class BackPack extends Sprite
   {
       
      
      private var gc:Config;
      
      private var headSprite:HeadSprite;
      
      public var headSit:Sprite;
      
      public var btn_close:SimpleButton;
      
      public var mc_exp:MovieClip;
      
      public var txt_name:TextField;
      
      public var txt_zdl:TextField;
      
      public var txt_hp:TextField;
      
      public var txt_mp:TextField;
      
      public var txt_att:TextField;
      
      public var txt_def:TextField;
      
      public var txt_baoji:TextField;
      
      public var txt_sb:TextField;
      
      public var txt_hx:TextField;
      
      public var txt_hl:TextField;
      
      public var txt_lh:TextField;
      
      public var txt_exp:TextField;
      
      public var txt_luck:TextField;
      
      public var txt_mdef:TextField;
      
      public var zbwq:Sprite;
      
      public var zbsp:Sprite;
      
      public var zbfj:Sprite;
      
      public var zbfb:Sprite;
      
      public var zbsz:Sprite;
      
      public var zbtx:Sprite;
      
      public var prePage:SimpleButton;
      
      public var nextPage:SimpleButton;
      
      public var thirdPage:SimpleButton;
      
      public var blackmc:Sprite;
      
      public var sellwhite:SimpleButton;
      
      public var showszmc:MovieClip;
      
      public var parentInterface:String = "";
      
      private var bpe:BackPackElement;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      public var levelmc:Sprite;
      
      private var le:Sprite;
      
      private var packNum:uint = 1;
      
      private var hero:BaseHero;
      
      private var player:User;
      
      private var renewalse:RenewalseThisSZ;
      
      private var renewEquip:MyEquipObj;
      
      public function BackPack()
      {
         le = new Sprite();
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         txt_name.selectable = false;
         txt_hp.selectable = false;
         txt_mp.selectable = false;
         txt_att.selectable = false;
         txt_def.selectable = false;
         txt_baoji.selectable = false;
         txt_sb.selectable = false;
         txt_hx.selectable = false;
         txt_hl.selectable = false;
         txt_lh.selectable = false;
         txt_luck.selectable = false;
         txt_mdef.selectable = false;
         txt_exp.selectable = false;
         txt_zdl.selectable = false;
         thirdPage.visible = false;
      }
      
      public function getUser() : User
      {
         return this.player;
      }
      
      public function setpack(num:uint) : void
      {
         this.packNum = num;
         hero = gc["hero" + this.packNum] as BaseHero;
         player = hero.getPlayer();
         if(this.player.getCurLevel() >= 50)
         {
            thirdPage.visible = true;
         }
         if(gc.gameVip.getVipLevel() >= 1)
         {
            this.player.setTadayLuckValue();
         }
      }
      
      public function setInfoTxt() : void
      {
         this.leveImage("levelnum",hero.roleProperies.getLevel(),26);
         this.mc_exp.gotoAndStop(Math.round(30 * hero.roleProperies.getExper() / hero.roleProperies.getExp()));
         if(hero.isPlayer3())
         {
            if(gc.isHideDebug && GMain.serviceHold.isSecondaryLog && GMain.serviceHold.isSecondaryLog.nickName)
            {
               this.txt_name.text = GMain.serviceHold.isSecondaryLog.nickName;
            }
            else
            {
               this.txt_name.text = hero.roleName;
            }
         }
         else if(gc.logInfo && gc.logInfo.nickName)
         {
            this.txt_name.text = gc.logInfo.nickName;
         }
         else
         {
            this.txt_name.text = hero.roleName;
         }
         this.txt_zdl.text = RankPropertyCount.getFightingForce(this.player) + "";
         this.txt_hp.text = hero.roleProperies.getHHP() + " / " + hero.roleProperies.getSHHP();
         this.txt_mp.text = hero.roleProperies.getMMP() + " / " + hero.roleProperies.getSMMP();
         this.txt_exp.text = hero.roleProperies.getExper() + " / " + hero.roleProperies.getExp();
         this.txt_att.text = String(hero.roleProperies.getPowerInPack());
         this.txt_mdef.text = hero.roleProperies.getMagicDef() + " %";
         this.txt_luck.text = this.player.getTotalLuckData() + " ";
         this.txt_baoji.text = hero.roleProperies.getTotalCrit() + " %";
         this.txt_def.text = Math.round(hero.roleProperies.getDefense()) + "";
         this.txt_sb.text = hero.roleProperies.getMiss() + " %";
         this.txt_hx.text = hero.roleProperies.getTotalHx() + "";
         this.txt_hl.text = hero.roleProperies.getHl() + "";
         this.txt_lh.text = hero.getPlayer().getLhValue() + "";
      }
      
      private function added(e:Event) : void
      {
         mc_exp.stop();
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         this.setInfoTxt();
         this.addBackPackAgeMc();
         var obj:Object = this.player.getEquipNum();
         this.headSprite = new HeadSprite(this.player.roleid,obj.zbfj,obj.zbwq,obj.zbtx);
         this.headSprite.name = "headSprite";
         headSit.addChild(this.headSprite);
         btn_close.addEventListener("click",close);
         zbsz.addEventListener("click",szClick);
         zbtx.addEventListener("click",szClick);
         zbwq.addEventListener("click",szClick);
         zbfj.addEventListener("click",szClick);
         zbsp.addEventListener("click",szClick);
         zbfb.addEventListener("click",szClick);
         prePage.addEventListener("click",prePageClick);
         nextPage.addEventListener("click",nextPageClick);
         thirdPage.addEventListener("click",thirdPageClick);
         prePage.dispatchEvent(new MouseEvent("click"));
         sellwhite.addEventListener("click",deleteWhiteEquipment);
         showszmc.addEventListener("click",showSZClick);
         gc.eventManger.addEventListener("ISNOTENOUGH",isNotEnough);
         gc.eventManger.addEventListener("USETRANSFERSTONE",useTransferStone);
         gc.eventManger.addEventListener("closeBackpack",__closeBackpack);
         this.curequip();
         this.changeShowFashionMc();
         gc.eventManger.addEventListener("RefreshBackpackTxt",this.refreshTxt);
      }
      
      private function removed(e:Event) : void
      {
         btn_close.removeEventListener("click",close);
         zbsz.removeEventListener("click",szClick);
         zbtx.removeEventListener("click",szClick);
         zbwq.removeEventListener("click",szClick);
         zbfj.removeEventListener("click",szClick);
         zbsp.removeEventListener("click",szClick);
         zbfb.removeEventListener("click",szClick);
         prePage.removeEventListener("click",prePageClick);
         nextPage.removeEventListener("click",nextPageClick);
         thirdPage.removeEventListener("click",thirdPageClick);
         sellwhite.removeEventListener("click",deleteWhiteEquipment);
         showszmc.removeEventListener("click",showSZClick);
         gc.eventManger.removeEventListener("ISNOTENOUGH",isNotEnough);
         gc.eventManger.removeEventListener("USETRANSFERSTONE",useTransferStone);
         gc.eventManger.removeEventListener("closeBackpack",__closeBackpack);
         if(this.headSprite)
         {
            if(headSit.contains(this.headSprite))
            {
               headSit.removeChild(this.headSprite);
            }
            this.headSprite.destroy();
            this.headSprite = null;
         }
         this.hero = null;
         if(gc.isSingleGame())
         {
            MainGame.getInstance().continueGame();
         }
         btnState = null;
         gc.eventManger.removeEventListener("RefreshBackpackTxt",this.refreshTxt);
      }
      
      protected function refreshTxt(evt:CommonEvent) : void
      {
         this.txt_att.text = String(hero.roleProperies.getPowerInPack());
         this.txt_mdef.text = hero.roleProperies.getMagicDef() + " %";
         this.txt_luck.text = this.player.getTotalLuckData() + " ";
         this.txt_baoji.text = hero.roleProperies.getTotalCrit() + " %";
         this.txt_def.text = Math.round(hero.roleProperies.getDefense()) + "";
         this.txt_sb.text = hero.roleProperies.getMiss() + " %";
         this.txt_hx.text = hero.roleProperies.getTotalHx() + "";
         this.txt_hl.text = hero.roleProperies.getHl() + "";
         this.txt_lh.text = hero.getPlayer().getLhValue() + "";
      }
      
      private function addBackPackAgeMc() : void
      {
         if(this.bpe != null && contains(this.bpe))
         {
            this.removeChild(this.bpe);
            this.bpe = null;
         }
         bpe = new BackPackElement();
         this.addChild(bpe);
         if(this.getChildIndex(bpe) > this.getChildIndex(this.blackmc))
         {
            this.swapChildren(bpe,this.blackmc);
         }
         bpe.setPlayer(this.player);
         this.bpe.x = 516.2;
         this.bpe.y = 114.35;
      }
      
      private function useTransferStone(evt:Event) : void
      {
         this.close(null);
         MainGame.getInstance().destroyGame();
         gc.eventManger.dispatchEvent(new Event("ReStart"));
      }
      
      private function prePageClick(e:MouseEvent) : void
      {
         if(bpe)
         {
            bpe.setCurPage(1);
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "prePage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function nextPageClick(e:MouseEvent) : void
      {
         if(bpe)
         {
            bpe.setCurPage(2);
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "nextPage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function thirdPageClick(e:MouseEvent) : void
      {
         if(bpe)
         {
            bpe.setCurPage(3);
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "thirdPage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function deleteWhiteEquipment(e:MouseEvent) : void
      {
         var temp:* = null;
         for(var zlen:uint = this.player.zblist.length; zlen-- > 0; )
         {
            if(this.player.zblist[zlen])
            {
               temp = this.player.zblist[zlen];
               if(temp.quality == "普 通" && temp.type != "zbtx")
               {
                  this.player.zblist.splice(zlen,1);
                  this.player.setLhValue(this.player.getLhValue() + gc.dataObject.twenty);
               }
            }
         }
         gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
         this.setInfoTxt();
      }
      
      private function showSZClick(e:MouseEvent) : void
      {
         if(this.player)
         {
            if(this.player.isshowfashion == true || this.player.isshowfashion == "true")
            {
               this.player.isshowfashion = false;
            }
            else
            {
               this.player.isshowfashion = true;
            }
            this.changeShowFashionMc();
            this.hero.changeEquip(this.player.getEquipNum());
            this.headSprite.refreshEquip(this.player.getEquipNum().zbfj,this.player.getEquipNum().zbwq,this.player.getEquipNum().zbtx);
            this.setInfoTxt();
         }
      }
      
      private function changeShowFashionMc() : void
      {
         if(this.player.isshowfashion == true || this.player.isshowfashion == "true")
         {
            this.showszmc.gotoAndStop(2);
         }
         else
         {
            this.showszmc.gotoAndStop(1);
         }
      }
      
      private function leveImage(name:String, num:int, distance:int) : *
      {
         var obj:* = undefined;
         var i:* = undefined;
         var j:* = 0;
         obj = undefined;
         if(this.getChildByName("le"))
         {
            this.levelmc.removeChild(this.getChildByName("le"));
         }
         if(String(num).length == 1)
         {
            obj = AUtils.getImageObj(name + num);
            obj.x = 21.8;
            obj.y = 13;
            le.addChild(obj);
         }
         else
         {
            for(i = 0; i < String(num).length; )
            {
               j = uint(int(String(num).charAt(i)));
               obj = AUtils.getImageObj(name + j);
               obj.x = 5.8 + i * distance;
               obj.y = 13;
               le.addChild(obj);
               i++;
            }
         }
         le.name = "le";
         this.levelmc.addChild(le);
      }
      
      private function isNotEnough(e:CommonEvent) : void
      {
         gc.ts.setTxt("数量不够");
         this.addChild(gc.ts);
      }
      
      private function szClick(e:MouseEvent) : void
      {
         var sit:int = 0;
         if(e.currentTarget.name == "zbfb")
         {
            if(this.hero.getCurMagicWeapon().isUsing())
            {
               gc.ts.setTxt("当前法宝正在使用");
               gc.stage.addChild(gc.ts);
               return;
            }
         }
         var sz:ShowObj = e.currentTarget.getChildByName("curzb") as ShowObj;
         if(sz)
         {
            e.currentTarget.removeChild(sz);
            sit = this.player.curarray.indexOf(sz.getMyEquipObj());
            this.player.curarray.splice(sit,1);
            this.hero.roleProperies.removeEquip(sz.getMyEquipObj());
            if(sz.getMyEquipObj().type == "zbcb" || sz.getMyEquipObj().type == "zbsz")
            {
               this.player.szlist.push(sz.getMyEquipObj());
            }
            else
            {
               this.player.zblist.push(sz.getMyEquipObj());
            }
            this.curequip();
            if(sz.getMyEquipObj().type == "zbfb")
            {
               this.hero.changeMagicWeapon();
            }
            sz = null;
            gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
         }
      }
      
      private function __closeBackpack(evt:CommonEvent) : void
      {
         this.close(null);
      }
      
      private function close(e:*) : void
      {
         gc.isOpenBackPack = false;
         MainGame.getInstance().continueGame();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function equip(_name:String, zb:MyEquipObj) : *
      {
         var temp:* = null;
         var sit:int = 0;
         if(zb.type == "zbcb")
         {
            return;
         }
         if(this[_name].getChildByName("curzb") != null)
         {
            temp = this[_name].getChildByName("curzb");
            this[_name].removeChild(temp);
            this.hero.roleProperies.removeEquip(temp.getMyEquipObj());
            sit = this.player.curarray.indexOf(temp.getMyEquipObj());
            this.player.curarray.splice(sit,1);
            if(temp.getMyEquipObj().type == "zbsz" || temp.getMyEquipObj().type == "zbcb")
            {
               this.player.szlist.push(temp.getMyEquipObj());
            }
            else
            {
               this.player.zblist.push(temp.getMyEquipObj());
            }
            temp = null;
            gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
         }
         this.player.curarray.push(zb);
         this.hero.roleProperies.addEquip(zb);
         this.curequip();
         if(zb.type == "zbfb")
         {
            this.hero.changeMagicWeapon();
         }
      }
      
      private function curequip() : void
      {
         var sobj:* = null;
         for(var alen:uint = this.player.curarray.length; alen-- > 0; )
         {
            sobj = new ShowObj(this.player.curarray[alen]);
            sobj.y = -2;
            if(this[this.player.curarray[alen].type].numChildren <= 1)
            {
               this[this.player.curarray[alen].type].addChild(sobj);
            }
         }
         this.hero.changeEquip(this.player.getEquipNum());
         this.headSprite.refreshEquip(this.player.getEquipNum().zbfj,this.player.getEquipNum().zbwq,this.player.getEquipNum().zbtx);
         this.setInfoTxt();
      }
      
      public function addRenewalseMask(fn:MyEquipObj, cn:String) : void
      {
         this.renewEquip = fn;
         if(fn.getFillName() == "ptsmsrsz" || fn.getFillName() == "yxsmsrsz" || fn.getFillName() == "jlsmsrsz" || fn.getFillName() == "sssmsrsz")
         {
            renewalse["txt"].text = "您确定花100点券续费" + cn + "吗?";
         }
         else
         {
            renewalse["txt"].text = "您确定花500点券续费" + cn + "吗?";
         }
         this.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         gc.renewalseEquip(this.player.getControlPlayer() + 1,renewEquip);
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
   }
}
