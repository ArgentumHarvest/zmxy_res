package export.rank
{
   import config.Config;
   import export.pack.HeadSprite;
   import export.pack.ShowObj;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MyEquipObj;
   
   public class ShowRankUser extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var txt_name:TextField;
      
      public var txt_zdl:TextField;
      
      public var levelmc:Sprite;
      
      public var zbwq:Sprite;
      
      public var zbsp:Sprite;
      
      public var zbfj:Sprite;
      
      public var zbfb:Sprite;
      
      public var zbsz:Sprite;
      
      public var zbcb:Sprite;
      
      public var showszmc:MovieClip;
      
      public var headSit:Sprite;
      
      public var p1:SimpleButton;
      
      public var p2:SimpleButton;
      
      private var gc:Config;
      
      private var headSprite:HeadSprite;
      
      private var rankUser:RankUsers;
      
      private var currentRankUser:RankUser;
      
      private var isshowfashion:Boolean = true;
      
      private var le:Sprite;
      
      private var btnState;
      
      private var lastBtn:String = "";
      
      public function ShowRankUser(_rankUser:RankUsers)
      {
         le = new Sprite();
         super();
         gc = Config.getInstance();
         this.rankUser = _rankUser;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.xbtn.addEventListener("click",xClick);
         this.p1.addEventListener("click",player1Click);
         showszmc.addEventListener("click",showSZClick);
         this.changeShowFashionMc();
         this.p1.dispatchEvent(new MouseEvent("click"));
         if(gc.playNum >= 2)
         {
            p2.visible = true;
            this.p2.addEventListener("click",player2Click);
         }
         else
         {
            p2.visible = false;
         }
      }
      
      private function removed(e:Event) : void
      {
         this.xbtn.removeEventListener("click",xClick);
         this.p1.removeEventListener("click",player1Click);
         this.p2.removeEventListener("click",player2Click);
         showszmc.removeEventListener("click",showSZClick);
         if(this.headSprite)
         {
            headSit.removeChild(this.headSprite);
            if(this.headSprite)
            {
               this.headSprite.destroy();
               this.headSprite = null;
            }
         }
         btnState = null;
      }
      
      private function setShow() : void
      {
         var obj:* = null;
         if(this.rankUser)
         {
            this.txt_name.text = this.rankUser.getUid() + "";
            this.txt_zdl.text = this.rankUser.getScore() - this.rankUser.getGongXun() + "";
         }
         else
         {
            this.txt_zdl.text = "";
         }
         if(this.currentRankUser)
         {
            this.leveImage("levelnum",currentRankUser.getLevel(),26);
            if(headSprite && headSit.contains(headSprite))
            {
               headSit.removeChild(this.headSprite);
               this.headSprite.destroy();
               this.headSprite = null;
            }
            obj = this.getEquipNum(this.currentRankUser.curEquipArray);
            this.headSprite = new HeadSprite(this.currentRankUser.getRoleId(),obj.zbfj,obj.zbwq);
            this.headSprite.name = "headSprite";
            headSit.addChild(this.headSprite);
            this.setEquipShow();
         }
      }
      
      private function player1Click(e:MouseEvent) : void
      {
         var ary:* = null;
         if(this.rankUser)
         {
            ary = this.rankUser.getRankUserArray();
            if(ary[0])
            {
               currentRankUser = ary[0];
               this.setShow();
            }
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "p1";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function player2Click(e:MouseEvent) : void
      {
         var ary:* = null;
         if(this.rankUser)
         {
            ary = this.rankUser.getRankUserArray();
            if(ary[1])
            {
               currentRankUser = ary[1];
               this.setShow();
            }
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "p2";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function setEquipShow() : void
      {
         var alen:* = 0;
         var sobj:* = null;
         if(this.currentRankUser)
         {
            this.removeEquipShow();
            for(alen = uint(this.currentRankUser.curEquipArray.length); alen-- > 0; )
            {
               sobj = new ShowObj(this.currentRankUser.curEquipArray[alen]);
               if(sobj.getMyEquipObj().type != "zbtx")
               {
                  sobj.y = -2;
                  if(this[this.currentRankUser.curEquipArray[alen].type].numChildren <= 1)
                  {
                     this[this.currentRankUser.curEquipArray[alen].type].addChild(sobj);
                  }
               }
            }
            this.headSprite.refreshEquip(this.getEquipNum(this.currentRankUser.curEquipArray).zbfj,this.getEquipNum(this.currentRankUser.curEquipArray).zbwq);
         }
      }
      
      private function removeEquipShow() : void
      {
         if(zbwq.getChildByName("curzb") != null)
         {
            zbwq.removeChild(zbwq.getChildByName("curzb"));
         }
         if(zbsp.getChildByName("curzb") != null)
         {
            zbsp.removeChild(zbsp.getChildByName("curzb"));
         }
         if(zbfj.getChildByName("curzb") != null)
         {
            zbfj.removeChild(zbfj.getChildByName("curzb"));
         }
         if(zbfb.getChildByName("curzb") != null)
         {
            zbfb.removeChild(zbfb.getChildByName("curzb"));
         }
         if(zbsz.getChildByName("curzb") != null)
         {
            zbsz.removeChild(zbsz.getChildByName("curzb"));
         }
         if(zbcb.getChildByName("curzb") != null)
         {
            zbcb.removeChild(zbcb.getChildByName("curzb"));
         }
      }
      
      private function showSZClick(e:MouseEvent) : void
      {
         if(this.currentRankUser)
         {
            if(this.isshowfashion == true || this.isshowfashion == "true")
            {
               this.isshowfashion = false;
            }
            else
            {
               this.isshowfashion = true;
            }
            this.changeShowFashionMc();
            this.headSprite.refreshEquip(this.getEquipNum(this.currentRankUser.curEquipArray).zbfj,this.getEquipNum(this.currentRankUser.curEquipArray).zbwq);
         }
      }
      
      private function changeShowFashionMc() : void
      {
         if(this.isshowfashion == true || this.isshowfashion == "true")
         {
            this.showszmc.gotoAndStop(2);
         }
         else
         {
            this.showszmc.gotoAndStop(1);
         }
      }
      
      private function getEquipNum(ary:Array) : Object
      {
         var myObj:* = null;
         var curList:Object = {
            "zbfj":0,
            "zbwq":0,
            "zbcb":0
         };
         var fashionId:uint = 0;
         var fjId:uint = 0;
         for(var clen:uint = ary.length; clen-- > 0; )
         {
            myObj = ary[clen];
            if(ary[clen].type == "zbfj")
            {
               fjId = myObj.showid;
            }
            if(ary[clen].type == "zbsz")
            {
               fashionId = myObj.showid;
            }
            if(ary[clen].type == "zbwq")
            {
               curList.zbwq = myObj.showid;
            }
            if(ary[clen].type == "zbcb")
            {
               curList.zbcb = myObj.showid;
            }
         }
         if(this.isshowfashion == true || this.isshowfashion == "true")
         {
            curList.zbfj = fashionId > 0 ? fashionId : fjId;
         }
         else
         {
            curList.zbfj = fjId;
         }
         return curList;
      }
      
      private function leveImage(name:String, num:int, distance:int) : *
      {
         var obj:* = undefined;
         var i:* = undefined;
         var j:* = 0;
         obj = undefined;
         if(le && this.levelmc.contains(le))
         {
            this.levelmc.removeChild(le);
            le = null;
         }
         le = new Sprite();
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
         this.levelmc.addChild(le);
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
