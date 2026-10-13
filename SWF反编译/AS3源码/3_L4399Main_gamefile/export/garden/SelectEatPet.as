package export.garden
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import petInfo.PetInfo;
   import user.User;
   
   public class SelectEatPet extends Sprite
   {
       
      
      public var listtxt:TextField;
      
      public var btn_close:SimpleButton;
      
      public var prePage:SimpleButton;
      
      public var nextPage:SimpleButton;
      
      public var achievebtn:SimpleButton;
      
      public var play1btn:SimpleButton;
      
      public var play2btn:SimpleButton;
      
      public var pnametxt:TextField;
      
      public var atxt:TextField;
      
      public var levtxt:TextField;
      
      private var lastBtn1:String = "";
      
      private var btnState1;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 2;
      
      private var pageNum:uint = 5;
      
      private var gc:Config;
      
      private var player:User;
      
      private var pif:PetInfo;
      
      private var _anti:Antiwear;
      
      public function SelectEatPet(_landId:uint)
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.landId = _landId;
         this._anti.five_three_four = 534;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.pnametxt.wordWrap = false;
         btn_close.addEventListener("click",xClick);
         prePage.addEventListener("click",prePageClick);
         nextPage.addEventListener("click",nextPageClick);
         play1btn.addEventListener("click",player1Click);
         play2btn.addEventListener("click",player2Click);
         achievebtn.addEventListener("click",achieveClick);
         play1btn.dispatchEvent(new MouseEvent("click"));
         if(gc.playNum == 1)
         {
            this.play2btn.visible = false;
            this.play2btn.removeEventListener("click",player2Click);
         }
         if(gc.gameVip.getVipLevel() >= 3)
         {
            prePage.visible = true;
            nextPage.visible = true;
         }
         else
         {
            prePage.visible = false;
            nextPage.visible = false;
         }
      }
      
      private function removed(e:Event) : void
      {
         btn_close.removeEventListener("click",xClick);
         prePage.removeEventListener("click",prePageClick);
         nextPage.removeEventListener("click",nextPageClick);
         play1btn.removeEventListener("click",player1Click);
         play2btn.removeEventListener("click",player2Click);
         achievebtn.removeEventListener("click",achieveClick);
      }
      
      private function prePageClick(e:MouseEvent) : void
      {
         this.pif = null;
         this.setShow();
         this.setCurPage(-1);
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
         this.pif = null;
         this.setShow();
         this.setCurPage(1);
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
      
      public function setCurPage(cp:int) : void
      {
         var lastPage:uint = this.curPage;
         this.curPage += cp;
         if(this.curPage > this.allPage)
         {
            this.curPage = this.allPage;
         }
         if(this.curPage < 1)
         {
            this.curPage = 1;
         }
         if(this.curPage != lastPage)
         {
            this.setPetList();
         }
      }
      
      private function setPetList() : void
      {
         var i:* = 0;
         var petList:* = null;
         this.removedPetList();
         this.setTitleTxt();
         for(i = uint(0); i < 5; )
         {
            petList = AUtils.getNewObj("garden_petlist") as Sprite;
            petList.buttonMode = true;
            if(this.player.petsAry[i + (curPage - 1) * 5] != undefined)
            {
               petList["petname"].text = this.player.petsAry[i + (curPage - 1) * 5].getPetChinaName();
               petList.name = "garden_petlist" + i;
               petList.x = 391.9;
               petList.y = 166.5 + i * petList.height + 5;
               this.addChild(petList);
               petList.addEventListener("click",plClick);
            }
            i++;
         }
      }
      
      private function setTitleTxt() : void
      {
         var lage:* = 0;
         var canCatchNum:int = 0;
         if(gc.gameVip.getVipLevel() < 3)
         {
            lage = uint(1 + int(this.player.getCurLevel() / 10));
            canCatchNum = lage < 5 ? lage : 5;
            this.listtxt.text = "宠物列表" + this.player.petsAry.length + "/" + canCatchNum;
         }
         else
         {
            this.listtxt.text = "宠物列表" + this.player.petsAry.length + "/10";
         }
      }
      
      private function removedPetList() : void
      {
         var i:* = 0;
         for(i = uint(0); i < 5; )
         {
            if(this.getChildByName("garden_petlist" + i))
            {
               this.getChildByName("garden_petlist" + i).removeEventListener("click",plClick);
               this.removeChild(this.getChildByName("garden_petlist" + i));
            }
            i++;
         }
      }
      
      private function plClick(e:MouseEvent) : void
      {
         trace("plClick");
         var txtformat:TextFormat = new TextFormat();
         txtformat.color = "0x381d09";
         var pid:uint = int(String(e.currentTarget.name).substr(14,1));
         var selectPet:PetInfo = this.findPetInCurrentPetListById(pid + (curPage - 1) * 5);
         if(selectPet == null)
         {
            throw new Error("获取选择的宠物为null");
         }
         for(var plen:uint = this.player.petsAry.length; plen-- > 0; )
         {
            if(this.getChildByName("garden_petlist" + plen))
            {
               this.getChildByName("garden_petlist" + plen)["petname"].setTextFormat(txtformat);
            }
         }
         txtformat.color = "0xfdfcba";
         e.currentTarget.petname.setTextFormat(txtformat);
         trace("selectPet:" + selectPet);
         this.setPetInfomation(selectPet);
      }
      
      private function findPetInCurrentPetListById(id:uint) : PetInfo
      {
         if(this.player.petsAry[id])
         {
            return this.player.petsAry[id];
         }
         return null;
      }
      
      public function setPetInfomation(_pif:PetInfo) : void
      {
         this.pif = _pif;
         this.setShow();
      }
      
      private function setShow() : void
      {
         trace("eatpet-->>setShow");
         var obj:Object = gc.findObjectByLandId(this._anti.landId);
         if(this.pif)
         {
            if(obj)
            {
               if(obj.type == 2)
               {
                  this.levtxt.text = "收获经验:" + this.getPlantExpByPlantLevel(obj.plantingLevel);
               }
               else if(obj.type == 5)
               {
                  this.levtxt.text = "收获潜力:" + this.getPlantPotentialByPlantLevel(obj.plantingLevel);
               }
            }
            this.pnametxt.text = "名字:" + this.pif.getPetChinaName() + " 等级:" + this.pif.getLevel();
            this.atxt.text = "悟性:" + this.pif.getperception() + "根骨:" + this.pif.getwarpower() + "灵力:" + this.pif.gettechnique();
         }
         else
         {
            this.pnametxt.text = "";
            this.atxt.text = "";
            this.levtxt.text = "";
         }
      }
      
      private function player1Click(e:MouseEvent) : void
      {
         if(gc.player1)
         {
            this.pif = null;
            this.setShow();
            this.player = gc.player1;
            this.setPetList();
            if(btnState1)
            {
               if(lastBtn1 != "")
               {
                  this[lastBtn1].upState = btnState1;
               }
            }
            lastBtn1 = "play1btn";
            btnState1 = e.target.upState;
            e.target.upState = e.target.downState;
         }
      }
      
      private function player2Click(e:MouseEvent) : void
      {
         if(gc.player2)
         {
            this.pif = null;
            this.setShow();
            this.player = gc.player2;
            this.setPetList();
            if(btnState1)
            {
               if(lastBtn1 != "")
               {
                  this[lastBtn1].upState = btnState1;
               }
            }
            lastBtn1 = "play2btn";
            btnState1 = e.target.upState;
            e.target.upState = e.target.downState;
         }
      }
      
      private function achieveClick(e:MouseEvent) : void
      {
         if(this.pif == null)
         {
            gc.ts.setTxt("请选择要收获的宠物");
            gc.stage.addChild(gc.ts);
            return;
         }
         var obj:Object = gc.findObjectByLandId(this._anti.landId);
         if(obj)
         {
            if(obj.type == 2)
            {
               trace("getPlantExpByPlantLevel -->" + this.getPlantExpByPlantLevel(obj.plantingLevel));
               this.pif.setCurExper(this.pif.getCurExper() + this.getPlantExpByPlantLevel(obj.plantingLevel));
            }
            else if(obj.type == 5)
            {
               trace("getPlantPotentialByPlantLevel -->>" + this.getPlantPotentialByPlantLevel(obj.plantingLevel));
               this.pif.setpotential(this.pif.getpotential() + this.getPlantPotentialByPlantLevel(obj.plantingLevel));
            }
            obj.type = gc.dataObject.four;
            obj.plantingLevel = gc.dataObject.one;
            gc.ts.setTxt("收获成功");
            gc.stage.addChild(gc.ts);
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         gc.eventManger.dispatchEvent(new CommonEvent("REFRESHLANDSHOW"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function getPlantExpByPlantLevel(plevel:uint) : int
      {
         if(plevel == gc.dataObject.one)
         {
            return this._anti.five_three_four * this.getAverLevel();
         }
         if(plevel == gc.dataObject.two)
         {
            return this._anti.five_three_four * this.getAverLevel() * gc.dataObject.two;
         }
         if(plevel == gc.dataObject.three)
         {
            return this._anti.five_three_four * this.getAverLevel() * gc.dataObject.three;
         }
         if(plevel == gc.dataObject.four)
         {
            return this._anti.five_three_four * this.getAverLevel() * gc.dataObject.five;
         }
         if(plevel == gc.dataObject.five)
         {
            return this._anti.five_three_four * this.getAverLevel() * gc.dataObject.seven;
         }
         return gc.dataObject.zero;
      }
      
      private function getPlantPotentialByPlantLevel(plevel:uint) : int
      {
         if(plevel == gc.dataObject.one)
         {
            return gc.dataObject.one;
         }
         if(plevel == gc.dataObject.two)
         {
            return gc.dataObject.two;
         }
         if(plevel == gc.dataObject.three)
         {
            return gc.dataObject.three;
         }
         if(plevel == gc.dataObject.four)
         {
            return gc.dataObject.five;
         }
         if(plevel == gc.dataObject.five)
         {
            return gc.dataObject.ten;
         }
         return gc.dataObject.zero;
      }
      
      private function getAverLevel() : int
      {
         if(gc.playNum == 1)
         {
            return gc.player1.getCurLevel();
         }
         return (gc.player1.getCurLevel() + gc.player2.getCurLevel()) / 2;
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
