package my
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import myanalysis.MyAllEquipId;
   
   public class MyEquipObj
   {
       
      
      private var gc:Config;
      
      private var meid:MyAllEquipId;
      
      private var backpackid:uint = 0;
      
      public var showid:uint = 1;
      
      public var ename:String = "";
      
      public var user:String = "";
      
      public var quality:String = "";
      
      public var color;
      
      public var aStrengthen:Object;
      
      public var etype:String;
      
      public var instruction:String = "";
      
      private var jin:Boolean = false;
      
      private var mu:Boolean = false;
      
      private var shui:Boolean = false;
      
      private var huo:Boolean = false;
      
      private var tu:Boolean = false;
      
      private var _anti:Antiwear;
      
      public function MyEquipObj(_showid:uint = 0, _ename:String = "", _fillName:String = "", _type:String = "", _user:String = "", _quality:String = "", _color:* = null, _ehp:int = 0, _emp:int = 0, _eatt:int = 0, _edef:int = 0, _ecrit:Number = 0.0, _emiss:Number = 0.0, _eahp:int = 0, _eamp:int = 0, _eatblood:Number = 0.0, _magicdef:Number = 0.0, _deephit:Number = 0.0, _aStrength:Object = null, _inst:String = "", _changeobj:Object = null, _eprob:Object = null, mutiLevel:uint = 0)
      {
         aStrengthen = {};
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.ten = 10;
         this._anti.__eupdata = -1;
         this._anti.__magicdef = -1;
         this._anti.__eamp = -1;
         this._anti.__eahp = -1;
         this._anti.__emiss = -1;
         this._anti.__ecrit = -1;
         this._anti.__edef = -1;
         this._anti.__eatt = -1;
         this._anti.__emp = -1;
         this._anti.__ehp = -1;
         this.showid = _showid;
         this.ename = _ename;
         this.setFillName(_fillName);
         this._anti._type = _type;
         this.user = _user;
         this.quality = _quality;
         this.color = _color;
         this.setehp(_ehp);
         this.setemp(_emp);
         this.seteatt(_eatt);
         this.setedef(_edef);
         this.setecrit(_ecrit);
         this.setemiss(_emiss);
         this.seteahp(_eahp);
         this.seteamp(_eamp);
         this.seteatblood(_eatblood);
         this.setmagicdef(_magicdef);
         this.setdeephit(_deephit);
         this.setnum(1);
         this.setstrengthValue(0);
         this.setShopAttribute(0);
         this.instruction = _inst;
         if(_aStrength != null)
         {
            this.aStrengthen = _aStrength;
         }
         if(_changeobj != null)
         {
            this.setELevel(int(_changeobj.elevel));
            this.setEupdata(Number(_changeobj.eupdata));
         }
         else
         {
            this.setELevel(0);
            this.setEupdata(0);
         }
         if(_eprob != null)
         {
            this.setWX(_eprob);
         }
         this.trans(_type);
         this.transValue();
         this.setMutiLevel(mutiLevel);
         this.strengthenEquip();
      }
      
      public function get type() : String
      {
         return this._anti._type;
      }
      
      public function set type(value:String) : void
      {
         this._anti._type = value;
      }
      
      public function setWX(_eprob:Object) : void
      {
         this.jin = Boolean(_eprob.jin);
         this.mu = Boolean(_eprob.mu);
         this.shui = Boolean(_eprob.shui);
         this.huo = Boolean(_eprob.huo);
         this.tu = Boolean(_eprob.tu);
      }
      
      public function setShopAttribute(_value:int) : void
      {
         this._anti.shopvalue = _value;
      }
      
      public function getShopAttribtue() : int
      {
         return this._anti.shopvalue;
      }
      
      public function strengthenEquip() : void
      {
         if(this.aStrengthen.att != undefined)
         {
            this.setSatkValue(this.getStrengthValue() * this.aStrengthen.att);
         }
         else
         {
            this.setSatkValue(0);
         }
         if(this.aStrengthen.def != undefined)
         {
            this.setSdefValue(this.getStrengthValue() * this.aStrengthen.def);
         }
         else
         {
            this.setSdefValue(0);
         }
         if(this.aStrengthen.hp != undefined)
         {
            this.setShpValue(this.getStrengthValue() * this.aStrengthen.hp);
         }
         else
         {
            this.setShpValue(0);
         }
         if(this.aStrengthen.mp != undefined)
         {
            this.setSmpValue(this.getStrengthValue() * this.aStrengthen.mp);
         }
         else
         {
            this.setSmpValue(0);
         }
         if(this.aStrengthen.crit != undefined)
         {
            this.setScritValue(this.getStrengthValue() * this.aStrengthen.crit);
         }
         else
         {
            this.setScritValue(0);
         }
         if(this.aStrengthen.miss != undefined)
         {
            this.setSmissValue(this.getStrengthValue() * this.aStrengthen.miss);
         }
         else
         {
            this.setSmissValue(0);
         }
         if(this.aStrengthen.ehp != undefined)
         {
            this.setSehpValue(this.getStrengthValue() * this.aStrengthen.ehp);
         }
         else
         {
            this.setSehpValue(0);
         }
         if(this.aStrengthen.emp != undefined)
         {
            this.setSempValue(this.getStrengthValue() * this.aStrengthen.emp);
         }
         else
         {
            this.setSempValue(0);
         }
         if(this.aStrengthen.mdef != undefined)
         {
            this.setSmdefValue(this.getStrengthValue() * this.aStrengthen.mdef);
         }
         else
         {
            this.setSmdefValue(0);
         }
         if(this.aStrengthen.ebol != undefined)
         {
            this.setSebolValue(this.getStrengthValue() * this.aStrengthen.ebol);
         }
         else
         {
            this.setSebolValue(0);
         }
         if(this.aStrengthen.dhit != undefined)
         {
            this.setSdhitValue(this.getStrengthValue() * this.aStrengthen.dhit);
         }
         else
         {
            this.setSdhitValue(0);
         }
      }
      
      public function upStrengthValue(incr:int) : void
      {
         this.setstrengthValue(this.getStrengthValue() + incr);
         this.strengthenEquip();
      }
      
      public function setNum(data:int) : void
      {
         this.setnum(this.getENum() + data);
      }
      
      public function getbackpackid() : int
      {
         return backpackid;
      }
      
      public function setbackpackid(id:int) : void
      {
         this.backpackid = id;
      }
      
      private function trans(s:String) : void
      {
         switch(s)
         {
            case "zbfj":
               this.etype = "防具";
               break;
            case "zbwq":
               this.etype = "武器";
               break;
            case "zbsp":
               this.etype = "饰品";
               break;
            case "zbfb":
               if(this.getFillName() == "wpfbyyin" || this.getFillName() == "wpfbyyan" || this.getFillName() == "wpfbtc")
               {
                  this.etype = "法宝碎片";
               }
               else
               {
                  this.etype = "法宝";
               }
               break;
            case "zbsz":
               this.etype = "时装";
               break;
            case "zbtx":
               this.etype = "头衔";
               break;
            case "wpqhs":
               this.etype = "强化石";
               break;
            case "zbwp":
               if(this.getFillName() == "wpxyf")
               {
                  this.etype = "幸运符";
               }
               else if(this.getFillName() == "wpbdf")
               {
                  this.etype = "神恩符";
               }
               else if(this.getFillName().indexOf("zzs") != -1)
               {
                  this.etype = "制作书";
               }
               else if(this.getFillName().indexOf("sms") != -1 || this.getFillName().indexOf("mfs") != -1 || this.getFillName().indexOf("fys") != -1 || this.getFillName().indexOf("gjs") != -1 || this.getFillName().indexOf("tlz") != -1 || this.getFillName().indexOf("llz") != -1 || this.getFillName().indexOf("hlz") != -1 || this.getFillName().indexOf("flz") != -1 || this.getFillName().indexOf("slz") != -1 || this.getFillName().indexOf("rls") != -1 || this.getFillName().indexOf("yhs") != -1 || this.getFillName().indexOf("tss") != -1 || this.getFillName().indexOf("kly") != -1 || this.getFillName().indexOf("xns") != -1)
               {
                  if(this.showid != 100)
                  {
                     this.etype = "宝石";
                  }
               }
               else if(this.getFillName() == "xssp" || this.getFillName() == "wpsc" || this.getFillName() == "wpxt" || this.getFillName() == "wptm" || this.getFillName() == "wpxh" || this.getFillName() == "wplh" || this.getFillName() == "wpxm" || this.getFillName() == "wpll" || this.getFillName() == "wpsg" || this.getFillName() == "wprs" || this.getFillName() == "wpygs" || this.getFillName() == "hsj" || this.getFillName() == "wpfbyyin" || this.getFillName() == "wpfbyyan" || this.getFillName() == "wpfbtc" || this.getFillName().indexOf("wpsh") != -1 || this.getFillName().indexOf("wpst") != -1 || this.getFillName().indexOf("lssp") != -1 || this.getFillName().indexOf("lxfs") != -1)
               {
                  this.etype = "材料";
               }
               else if(this.getFillName() == "mpyj" || this.getFillName() == "wphhd" || this.getFillName() == "wpcsd" || this.getFillName() == "wpmgh" || this.getFillName() == "wpzz" || this.getFillName() == "wpbsz" || this.getFillName() == "wplwl" || this.getFillName() == "wplvdyl" || this.getFillName() == "wpdd" || this.getFillName() == "yjpyinsp" || this.getFillName() == "yjpyansp" || this.getFillName() == "sbjyd" || this.getFillName() == "jyys" || this.getFillName() == "jyd3" || this.getFillName() == "djyys" || this.getFillName() == "cdjyys" || this.getFillName().indexOf("ttlpsp") != -1 || this.getFillName() == "ttlp" || this.getFillName() == "xjyys" || this.getFillName() == "lhys" || this.getFillName() == "dlhys" || this.getFillName() == "ghyb" || this.getFillName() == "hjxz" || this.getFillName() == "zsxz" || this.getFillName() == "bmd" || this.getFillName() == "yp" || this.getFillName() == "ml" || this.getFillName() == "gz" || this.getFillName() == "sz" || this.getFillName() == "zz" || this.getFillName() == "jbc" || this.getFillName() == "szj" || this.getFillName() == "xnhdl" || this.getFillName().indexOf("ttsl") != -1 || this.getFillName() == "yysn" || this.getFillName() == "lxzhs" || this.getFillName() == "sxzhs" || this.getFillName() == "bnnxz")
               {
                  this.etype = "道具";
               }
               else if(this.getFillName() == "css6" || this.getFillName() == "css12" || this.getFillName() == "css18" || this.getFillName() == "css_2" || this.getFillName() == "css_3")
               {
                  this.etype = "传送石";
               }
               else if(this.getFillName().indexOf("wpsmd") != -1 || this.getFillName().indexOf("cwjnxld") != -1 || this.getFillName().indexOf("cwzzxld") != -1 || this.getFillName().indexOf("wphtd") != -1 || this.getFillName() == "nianqld" || this.getFillName() == "nianjhd" || this.getFillName() == "nianjhdd")
               {
                  this.etype = "丹药";
               }
               else if(this.getFillName().indexOf("jns") != -1)
               {
                  this.etype = "技能书";
               }
         }
      }
      
      private function transValue() : void
      {
         switch(this.quality)
         {
            case "粗 糙":
               this.setValue(10);
               break;
            case "普 通":
               this.setValue(20);
               break;
            case "优 秀":
               this.setValue(40);
               break;
            case "精 良":
               this.setValue(80);
               break;
            case "史 诗":
               this.setValue(160);
               break;
            case "传 说":
               this.setValue(320);
               break;
            case "邪 灵":
               this.setValue(640);
               break;
            case "渊 邪":
               this.setValue(640);
               break;
            case "魂 器":
               this.setValue(1280);
               break;
            default:
               this.setValue(0);
         }
      }
      
      public function getWX() : String
      {
         var str:String = "";
         if(jin)
         {
            str += "金 ";
         }
         if(mu)
         {
            str += "木 ";
         }
         if(shui)
         {
            str += "水 ";
         }
         if(huo)
         {
            str += "火 ";
         }
         if(tu)
         {
            str += "土 ";
         }
         return str;
      }
      
      public function setWXFromRank(str:String) : void
      {
         var wxObj:Object = {};
         if(str.length == 5)
         {
            if(str.charAt(0) == "1")
            {
               wxObj.jin = true;
            }
            if(str.charAt(1) == "1")
            {
               wxObj.mu = true;
            }
            if(str.charAt(2) == "1")
            {
               wxObj.shui = true;
            }
            if(str.charAt(3) == "1")
            {
               wxObj.huo = true;
            }
            if(str.charAt(4) == "1")
            {
               wxObj.tu = true;
            }
         }
         this.setWX(wxObj);
      }
      
      public function getWXForRank() : String
      {
         var str:String = "";
         if(jin)
         {
            str += "1";
         }
         else
         {
            str += "0";
         }
         if(mu)
         {
            str += "1";
         }
         else
         {
            str += "0";
         }
         if(shui)
         {
            str += "1";
         }
         else
         {
            str += "0";
         }
         if(huo)
         {
            str += "1";
         }
         else
         {
            str += "0";
         }
         if(tu)
         {
            str += "1";
         }
         else
         {
            str += "0";
         }
         return str;
      }
      
      public function growth(data:Object, isGrowth:Boolean = true) : void
      {
         if(isGrowth)
         {
            this.setELevel(this.getELevel() + 1);
         }
         if(jin)
         {
            this.seteatt(this.geteatt(true) + (data.fatk + Math.floor(data.fatk * this.getEUpdata())));
         }
         else
         {
            this.seteatt(this.geteatt(true) + Math.floor(data.fatk * this.getEUpdata()));
         }
         if(!mu)
         {
         }
         if(shui)
         {
            this.setemp(this.getemp(true) + (data.fmp + Math.floor(data.fmp * this.getEUpdata())));
         }
         else
         {
            this.setemp(this.getemp(true) + Math.floor(data.fmp * this.getEUpdata()));
         }
         if(huo)
         {
            this.setehp(this.getehp(true) + (data.fhp + Math.floor(data.fhp * this.getEUpdata())));
         }
         else
         {
            this.setehp(this.getehp(true) + Math.floor(data.fhp * this.getEUpdata()));
         }
         if(tu)
         {
            this.setedef(this.getedef(true) + (data.fdef + Math.floor(data.fdef * this.getEUpdata())));
         }
         else
         {
            this.setedef(this.getedef(true) + Math.floor(data.fdef * this.getEUpdata()));
         }
      }
      
      public function growthDown(data:Object) : void
      {
         if(jin)
         {
            this.seteatt(this.geteatt(true) - (data.fatk + Math.floor(data.fatk * this.getEUpdata())) * (this.getELevel() - 1));
         }
         else
         {
            this.seteatt(this.geteatt(true) - Math.floor(data.fatk * this.getEUpdata()) * (this.getELevel() - 1));
         }
         if(!mu)
         {
         }
         if(shui)
         {
            this.setemp(this.getemp(true) - (data.fmp + Math.floor(data.fmp * this.getEUpdata())) * (this.getELevel() - 1));
         }
         else
         {
            this.setemp(this.getemp(true) - Math.floor(data.fmp * this.getEUpdata()) * (this.getELevel() - 1));
         }
         if(huo)
         {
            this.setehp(this.getehp(true) - (data.fhp + Math.floor(data.fhp * this.getEUpdata())) * (this.getELevel() - 1));
         }
         else
         {
            this.setehp(this.getehp(true) - Math.floor(data.fhp * this.getEUpdata()) * (this.getELevel() - 1));
         }
         if(tu)
         {
            this.setedef(this.getedef(true) - (data.fdef + Math.floor(data.fdef * this.getEUpdata())) * (this.getELevel() - 1));
         }
         else
         {
            this.setedef(this.getedef(true) - Math.floor(data.fdef * this.getEUpdata()) * (this.getELevel() - 1));
         }
      }
      
      public function getGrowthByName(_name:String) : Object
      {
         var obj:Object = {
            "fhp":0,
            "fmp":0,
            "fatk":0,
            "fdef":0
         };
         switch(_name)
         {
            case "kyl":
               obj = {
                  "fhp":20,
                  "fmp":20,
                  "fatk":4,
                  "fdef":2
               };
               break;
            case "xhhl":
               obj = {
                  "fhp":30,
                  "fmp":30,
                  "fatk":5,
                  "fdef":2
               };
               break;
            case "qyj":
               obj = {
                  "fhp":30,
                  "fmp":50,
                  "fatk":5,
                  "fdef":2
               };
               break;
            case "hyzzs":
               obj = {
                  "fhp":50,
                  "fmp":30,
                  "fatk":5,
                  "fdef":4
               };
               break;
            case "zjld":
               obj = {
                  "fhp":30,
                  "fmp":30,
                  "fatk":9,
                  "fdef":2
               };
               break;
            case "gcxdyy":
               obj = {
                  "fhp":50,
                  "fmp":50,
                  "fatk":12,
                  "fdef":3
               };
               break;
            case "yjp":
               obj = {
                  "fhp":60,
                  "fmp":30,
                  "fatk":12,
                  "fdef":5
               };
               break;
            case "qljfb":
               obj = {
                  "fhp":60,
                  "fmp":60,
                  "fatk":14,
                  "fdef":5
               };
               break;
            case "nmwdnh":
               obj = {
                  "fhp":70,
                  "fmp":40,
                  "fatk":12,
                  "fdef":5
               };
               break;
            case "zlwdah":
               obj = {
                  "fhp":50,
                  "fmp":70,
                  "fatk":12,
                  "fdef":4
               };
               break;
            case "xhhhl":
               obj = {
                  "fhp":60,
                  "fmp":60,
                  "fatk":10,
                  "fdef":5
               };
               break;
            case "yyzlj":
               obj = {
                  "fhp":65,
                  "fmp":65,
                  "fatk":14,
                  "fdef":6
               };
               break;
            case "ywhl":
               obj = {
                  "fhp":80,
                  "fmp":50,
                  "fatk":10,
                  "fdef":5
               };
               break;
            case "zhyx":
               obj = {
                  "fhp":50,
                  "fmp":80,
                  "fatk":10,
                  "fdef":5
               };
               break;
            case "bjs":
               obj = {
                  "fhp":50,
                  "fmp":50,
                  "fatk":14,
                  "fdef":5
               };
               break;
            case "hsqq":
               obj = {
                  "fhp":50,
                  "fmp":10,
                  "fatk":2,
                  "fdef":1
               };
               break;
            case "h_sqq":
               obj = {
                  "fhp":10,
                  "fmp":10,
                  "fatk":2,
                  "fdef":5
               };
               break;
            case "lsqq":
               obj = {
                  "fhp":10,
                  "fmp":50,
                  "fatk":2,
                  "fdef":1
               };
               break;
            case "csqq":
               obj = {
                  "fhp":60,
                  "fmp":20,
                  "fatk":4,
                  "fdef":6
               };
               break;
            case "l_sqq":
               obj = {
                  "fhp":20,
                  "fmp":60,
                  "fatk":4,
                  "fdef":6
               };
               break;
            case "zsqq":
               obj = {
                  "fhp":60,
                  "fmp":60,
                  "fatk":4,
                  "fdef":2
               };
               break;
            case "fsqq":
               obj = {
                  "fhp":100,
                  "fmp":100,
                  "fatk":20,
                  "fdef":10
               };
               break;
            case "sxyg":
               obj = {
                  "fhp":50,
                  "fmp":50,
                  "fatk":15,
                  "fdef":5
               };
               break;
            case "dkhl":
               obj = {
                  "fhp":100,
                  "fmp":20,
                  "fatk":10,
                  "fdef":4
               };
               break;
            case "yyb":
               obj = {
                  "fhp":50,
                  "fmp":50,
                  "fatk":12,
                  "fdef":5
               };
               break;
            case "hehua":
               obj = {
                  "fhp":50,
                  "fmp":80,
                  "fatk":10,
                  "fdef":5
               };
               break;
            case "tjbg":
               obj = {
                  "fhp":300,
                  "fmp":300,
                  "fatk":30,
                  "fdef":10
               };
               break;
            case "lxfb":
               obj = {
                  "fhp":0,
                  "fmp":0,
                  "fatk":20,
                  "fdef":0
               };
               break;
            case "sxfb":
               obj = {
                  "fhp":0,
                  "fmp":0,
                  "fatk":20,
                  "fdef":0
               };
               break;
            case "bxzq":
               obj = {
                  "fhp":60,
                  "fmp":60,
                  "fatk":10,
                  "fdef":5
               };
               break;
            case "yxfb":
               obj = {
                  "fhp":100,
                  "fmp":100,
                  "fatk":20,
                  "fdef":0
               };
         }
         return obj;
      }
      
      public function getEquipSaveObj() : String
      {
         var saveString:* = null;
         var ft:* = null;
         if(this.etype == "技能书")
         {
            saveString = this.showid + "|" + "" + "|" + this.getFillName() + "|" + this.getENum();
         }
         else
         {
            saveString = this.showid + "|" + "" + "|" + this.getFillName() + "|" + this.type + "|" + this.getShopAttribtue() + "|" + "" + "|" + "" + "|" + this._anti.ehp + "|" + this._anti.emp + "|" + this._anti.eatt + "|" + this._anti.edef + "|" + this._anti.emiss + "|" + this._anti.ecrit + "|" + this._anti.eahp + "|" + this._anti.eamp + "|" + this.jin + "|" + this.mu + "|" + this.shui + "|" + this.huo + "|" + this.tu + "|" + this.getELevel() + "|" + this._anti.Eupdata + "|" + this.getENum() + "|" + this.getStrengthValue() + "|" + this._anti.magicdef + "|" + this.geteatblood(true) + "|" + this.getdeephit(true);
            if(this.type == "zbsz" || this.type == "zbcb")
            {
               ft = "";
               if(this.getFashionTime() == "永久")
               {
                  ft = "never";
               }
               else
               {
                  ft = this.getFashionTime();
               }
               saveString += "|" + ft;
            }
            saveString += "|" + this.getMutiLevel();
         }
         return saveString;
      }
      
      public function setEquipSaveObj(data:*) : void
      {
         var mutiLevel:int = 0;
         var elv:int = 0;
         var getArray:Array = data.split("|");
         this.showid = int(getArray[0]);
         this.ename = getArray[1];
         this.setFillName(getArray[2]);
         var tempEquip:MyEquipObj = gc.allEquip.findByName(this.getFillName());
         this.instruction = tempEquip.instruction;
         if(this.getFillName().indexOf("jns") != -1)
         {
            this.setnum(int(getArray[3]));
            this.type = "zbwp";
         }
         else
         {
            this.type = getArray[3];
            this.setShopAttribute(int(getArray[4]));
            if(this.getShopAttribtue() > 0)
            {
               trace(" getFillName -->>" + this.getFillName() + " getShopAttribtue -->>" + this.getShopAttribtue());
            }
            this.quality = getArray[5];
            this.color = getArray[6];
            this.setehp(int(getArray[7]));
            this.setemp(int(getArray[8]));
            this.seteatt(int(getArray[9]));
            this.setedef(int(getArray[10]));
            this.setemiss(Number(getArray[11]));
            this.setecrit(Number(getArray[12]));
            this.seteahp(int(getArray[13]));
            this.seteamp(int(getArray[14]));
            if(getArray[15] == "false" || getArray[15] == false)
            {
               this.jin = false;
            }
            else
            {
               this.jin = true;
            }
            if(getArray[16] == "false" || getArray[16] == false)
            {
               this.mu = false;
            }
            else
            {
               this.mu = true;
            }
            if(getArray[17] == "false" || getArray[17] == false)
            {
               this.shui = false;
            }
            else
            {
               this.shui = true;
            }
            if(getArray[18] == "false" || getArray[18] == false)
            {
               this.huo = false;
            }
            else
            {
               this.huo = true;
            }
            if(getArray[19] == "false" || getArray[19] == false)
            {
               this.tu = false;
            }
            else
            {
               this.tu = true;
            }
            this.setELevel(int(getArray[20]));
            this.setEupdata(Number(getArray[21]));
            this.setnum(int(getArray[22]));
            this.setstrengthValue(int(getArray[23]));
            this.setmagicdef(Number(getArray[24]));
            this.seteatblood(Number(getArray[25]));
            this.setdeephit(Number(getArray[26]));
            if(tempEquip.type == "zbsz" || tempEquip.type == "zbcb")
            {
               if(getArray[27] != undefined)
               {
                  this.setFashionTime(getArray[27]);
               }
            }
            else if(tempEquip.quality == "传 说")
            {
               if(getArray[27] != undefined)
               {
                  mutiLevel = getArray[27];
                  if(mutiLevel > 5)
                  {
                     mutiLevel = 5;
                  }
                  this.setMutiLevel(mutiLevel);
               }
            }
            else
            {
               this.setMutiLevel(0);
            }
         }
         this.ename = tempEquip.ename;
         this.user = tempEquip.user;
         this.quality = tempEquip.quality;
         this.color = tempEquip.color;
         this.trans(tempEquip.type);
         this.transValue();
         this.aStrengthen = tempEquip.aStrengthen;
         this.strengthenEquip();
         if(this.getFillName() == "sxfb")
         {
            elv = this.getELevel();
            if(elv > 1)
            {
               if(this._anti.eatt == 100)
               {
                  while(elv > 1)
                  {
                     this.growth(this.getGrowthByName(this.getFillName()),false);
                     elv--;
                  }
               }
            }
         }
      }
      
      public function hasPassTime() : Boolean
      {
         if(this.getFashionTime() == "never")
         {
            return false;
         }
         if(this.getFillName() == "ptsmsrsz" || this.getFillName() == "yxsmsrsz" || this.getFillName() == "jlsmsrsz" || this.getFillName() == "sssmsrsz")
         {
            if(AUtils.getDayBetweenDate(this.getFashionTime(),gc.dataObjectInstance.curDate) > 7)
            {
               return true;
            }
            return false;
         }
         if(AUtils.getDayBetweenDate(this.getFashionTime(),gc.dataObjectInstance.curDate) > 30)
         {
            return true;
         }
         return false;
      }
      
      private function getLastDay() : int
      {
         if(this.getFillName() == "ptsmsrsz" || this.getFillName() == "yxsmsrsz" || this.getFillName() == "jlsmsrsz" || this.getFillName() == "sssmsrsz")
         {
            return 7 - AUtils.getDayBetweenDate(this.getFashionTime(),gc.dataObjectInstance.curDate);
         }
         return 30 - AUtils.getDayBetweenDate(this.getFashionTime(),gc.dataObjectInstance.curDate);
      }
      
      public function setFillName(fn:String) : void
      {
         this._anti.fillName = fn;
      }
      
      public function getFillName() : String
      {
         return this._anti.fillName;
      }
      
      public function setFashionTime(ft:String) : void
      {
         this._anti.fashiontime = ft;
         if(this.type == "zbsz" || this.type == "zbcb")
         {
            if(this.hasPassTime())
            {
               this.instruction += "</font>\n<font face=\'FZCuYuan-M03S\' size=\'14\' color=\'#ff0000\'>时装已经过期</font>";
            }
            else
            {
               this.instruction += "</font>\n<font face=\'FZCuYuan-M03S\' size=\'14\' color=\'#ff0000\'>还剩" + this.getLastDay() + "天</font>";
            }
         }
      }
      
      public function getFashionTime() : String
      {
         try
         {
            this._anti.fashiontime;
         }
         catch(e:*)
         {
            this.setFashionTime("1999-01-01");
            return "1999-01-01";
         }
         if(this._anti.fashiontime == "never")
         {
            return "永久";
         }
         return this._anti.fashiontime;
      }
      
      public function setEupdata(v:Number) : void
      {
         this._anti.Eupdata = v;
      }
      
      public function getEUpdata() : Number
      {
         if(this._anti.__eupdata >= 0)
         {
            return this._anti.__eupdata;
         }
         return Number(Number(this._anti.Eupdata).toFixed(1));
      }
      
      public function setELevel(v:int) : void
      {
         this._anti.ELevel = v;
      }
      
      public function getELevel() : int
      {
         return this._anti.ELevel;
      }
      
      public function setnum(value:int) : void
      {
         this._anti.num = value;
         if(this.getFillName() == "hjxz" || this.getFillName() == "zsxz")
         {
            this._anti.num = 1;
         }
      }
      
      public function getENum() : uint
      {
         return this._anti.num;
      }
      
      public function setehp(value:int) : void
      {
         if(value < -1000)
         {
            value = -1000;
         }
         this._anti.ehp = value;
      }
      
      public function getehp(isbase:Boolean = false, _mutiLev:int = 0) : int
      {
         if(this._anti.__ehp >= 0)
         {
            return this._anti.__ehp;
         }
         if(!isbase)
         {
            return this._anti.ehp + this.getShpValue() + this._anti.ehp * this.getMutiLevel() * 0.1;
         }
         if(_mutiLev == 1)
         {
            return this._anti.ehp + this._anti.ehp * this.getMutiLevel() * 0.1;
         }
         return this._anti.ehp;
      }
      
      public function setemp(value:int) : void
      {
         if(value < -1000)
         {
            value = -1000;
         }
         this._anti.emp = value;
      }
      
      public function getemp(isbase:Boolean = false, _mutiLev:int = 0) : int
      {
         if(this._anti.__emp >= 0)
         {
            return this._anti.__emp;
         }
         if(!isbase)
         {
            return this._anti.emp + this.getSmpValue() + this._anti.emp * this.getMutiLevel() * 0.1;
         }
         if(_mutiLev == 1)
         {
            return this._anti.emp + this._anti.emp * this.getMutiLevel() * 0.1;
         }
         return this._anti.emp;
      }
      
      public function seteatt(value:int) : void
      {
         if(value < -1000)
         {
            value = -1000;
         }
         this._anti.eatt = value;
      }
      
      public function geteatt(isbase:Boolean = false, _mutiLev:int = 0) : int
      {
         if(this._anti.__eatt >= 0)
         {
            return this._anti.__eatt;
         }
         if(!isbase)
         {
            return this._anti.eatt + this.getSatkValue() + this._anti.eatt * this.getMutiLevel() * 0.1;
         }
         if(_mutiLev == 1)
         {
            return this._anti.eatt + this._anti.eatt * this.getMutiLevel() * 0.1;
         }
         return this._anti.eatt;
      }
      
      public function setedef(value:int) : void
      {
         if(value < -1000)
         {
            value = -1000;
         }
         this._anti.edef = value;
      }
      
      public function getedef(isbase:Boolean = false, _mutiLev:int = 0) : int
      {
         if(this._anti.__edef >= 0)
         {
            return this._anti.__edef;
         }
         if(!isbase)
         {
            return this._anti.edef + this.getSdefValue() + this._anti.edef * this.getMutiLevel() * 0.1;
         }
         if(_mutiLev == 1)
         {
            return this._anti.edef + this._anti.edef * this.getMutiLevel() * 0.1;
         }
         return this._anti.edef;
      }
      
      public function setValue(v:int) : void
      {
         if(v < -1000)
         {
            v = -1000;
         }
         this._anti.value = v;
      }
      
      public function getValue() : int
      {
         return this._anti.value;
      }
      
      public function setemiss(value:Number) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         this._anti.emiss = value;
      }
      
      public function getemiss(isbase:Boolean = false, _mutiLev:int = 0) : Number
      {
         if(this._anti.__emiss >= 0)
         {
            return this._anti.__emiss;
         }
         if(!isbase)
         {
            return AUtils.numberAdd(this._anti.emiss + this._anti.emiss * this.getMutiLevel() * 0.1,this.getSmissValue(),2);
         }
         if(_mutiLev == 1)
         {
            return int((this._anti.emiss + this._anti.emiss * this.getMutiLevel() * 0.1) * 100) / 100;
         }
         return Number(Number(this._anti.emiss).toFixed(2));
      }
      
      public function setecrit(value:Number) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         this._anti.ecrit = value;
      }
      
      public function getecrit(isbase:Boolean = false, _mutiLev:int = 0) : Number
      {
         if(this._anti.__ecrit >= 0)
         {
            return this._anti.__ecrit;
         }
         if(!isbase)
         {
            return AUtils.numberAdd(this._anti.ecrit + this._anti.ecrit * this.getMutiLevel() * 0.1,this.getScritValue(),2);
         }
         if(_mutiLev == 1)
         {
            return int((this._anti.ecrit + this._anti.ecrit * this.getMutiLevel() * 0.1) * 100) / 100;
         }
         return Number(Number(this._anti.ecrit).toFixed(2));
      }
      
      public function seteahp(value:int) : void
      {
         if(value < -1000)
         {
            value = -1000;
         }
         this._anti.eahp = value;
      }
      
      public function geteahp(isbase:Boolean = false, _mutiLev:int = 0) : int
      {
         if(this._anti.__eahp >= 0)
         {
            return this._anti.__eahp;
         }
         if(!isbase)
         {
            return this._anti.eahp + this.getSehpValue() + this._anti.eahp * this.getMutiLevel() * 0.1;
         }
         if(_mutiLev == 1)
         {
            return this._anti.eahp + this._anti.eahp * this.getMutiLevel() * 0.1;
         }
         return this._anti.eahp;
      }
      
      public function seteamp(value:int) : void
      {
         if(value < -1000)
         {
            value = -1000;
         }
         this._anti.eamp = value;
      }
      
      public function geteamp(isbase:Boolean = false, _mutiLev:int = 0) : int
      {
         if(this._anti.__eamp >= 0)
         {
            return this._anti.__eamp;
         }
         if(!isbase)
         {
            return this._anti.eamp + this.getSempValue() + this._anti.eamp * this.getMutiLevel() * 0.1;
         }
         if(_mutiLev == 1)
         {
            return this._anti.eamp + this._anti.eamp * this.getMutiLevel() * 0.1;
         }
         return this._anti.eamp;
      }
      
      public function seteatblood(value:Number) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         this._anti.eatblood = value;
      }
      
      public function geteatblood(isbase:Boolean = false, _mutiLev:int = 0) : Number
      {
         if(!isbase)
         {
            return AUtils.numberAdd(Number(this._anti.eatblood) + this._anti.eatblood * this.getMutiLevel() * 0.1,this.getSebloValue(),2);
         }
         if(_mutiLev == 1)
         {
            return int((this._anti.eatblood + this._anti.eatblood * this.getMutiLevel() * 0.1) * 100) / 100;
         }
         return Number(Number(this._anti.eatblood).toFixed(2));
      }
      
      public function setmagicdef(value:Number) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         this._anti.magicdef = value;
      }
      
      public function getmagicdef(isbase:Boolean = false, _mutiLev:int = 0) : Number
      {
         if(this._anti.__magicdef >= 0)
         {
            return this._anti.__magicdef;
         }
         if(!isbase)
         {
            trace("this._anti.magicdef:" + this._anti.magicdef);
            trace("this.getMutiLevel():" + this.getMutiLevel());
            trace("this.getSmdefValue():" + this.getSmdefValue());
            return AUtils.numberAdd(Number(this._anti.magicdef) + this._anti.magicdef * this.getMutiLevel() * 0.1,this.getSmdefValue(),2);
         }
         if(_mutiLev == 1)
         {
            return int((this._anti.magicdef + this._anti.magicdef * this.getMutiLevel() * 0.1) * 100) / 100;
         }
         return Number(Number(this._anti.magicdef).toFixed(2));
      }
      
      public function setdeephit(value:Number) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         this._anti.deephit = value;
      }
      
      public function getdeephit(isbase:Boolean = false, _mutiLev:int = 0) : Number
      {
         if(!isbase)
         {
            return AUtils.numberAdd(Number(this._anti.deephit) + this._anti.deephit * this.getMutiLevel() * 0.1,this.getSdhitValue(),2);
         }
         if(_mutiLev == 1)
         {
            return int((this._anti.deephit + this._anti.deephit * this.getMutiLevel() * 0.1) * 100) / 100;
         }
         return Number(Number(this._anti.deephit).toFixed(2));
      }
      
      public function setstrengthValue(value:int) : void
      {
         this._anti.strengthValue = value;
      }
      
      public function getStrengthValue() : int
      {
         return this._anti.strengthValue;
      }
      
      public function setMutiLevel(value:int) : void
      {
         this._anti.mutiLevel = value;
      }
      
      public function getMutiLevel() : int
      {
         return this._anti.mutiLevel;
      }
      
      public function setShpValue(v:int) : void
      {
         this._anti.ShpValue = v;
      }
      
      public function getShpValue() : int
      {
         return this._anti.ShpValue;
      }
      
      public function setSmpValue(v:int) : void
      {
         this._anti.SmpValue = v;
      }
      
      public function getSmpValue() : int
      {
         return this._anti.SmpValue;
      }
      
      public function setSatkValue(v:int) : void
      {
         this._anti.SatkValue = v;
      }
      
      public function getSatkValue() : int
      {
         return this._anti.SatkValue;
      }
      
      public function setSdefValue(v:int) : void
      {
         this._anti.SdefValue = v;
      }
      
      public function getSdefValue() : int
      {
         return this._anti.SdefValue;
      }
      
      public function setSehpValue(v:int) : void
      {
         this._anti.SehpValue = v;
      }
      
      public function getSehpValue() : int
      {
         return this._anti.SehpValue;
      }
      
      public function setSempValue(v:int) : void
      {
         this._anti.SempValue = v;
      }
      
      public function getSempValue() : int
      {
         return this._anti.SempValue;
      }
      
      public function setScritValue(value:Number) : void
      {
         this._anti.ScritValue = value;
      }
      
      public function getScritValue() : Number
      {
         return Number(Number(this._anti.ScritValue).toFixed(2));
      }
      
      public function setSmissValue(value:Number) : void
      {
         this._anti.SmissValue = value;
      }
      
      public function getSmissValue() : Number
      {
         return Number(Number(this._anti.SmissValue).toFixed(2));
      }
      
      public function setSebolValue(value:Number) : void
      {
         this._anti.SebolValue = value;
      }
      
      public function getSebloValue() : Number
      {
         return Number(Number(this._anti.SebolValue).toFixed(2));
      }
      
      public function setSmdefValue(value:Number) : void
      {
         this._anti.SmdefValue = value;
      }
      
      public function getSmdefValue() : Number
      {
         return Number(Number(this._anti.SmdefValue).toFixed(2));
      }
      
      public function setSdhitValue(value:Number) : void
      {
         this._anti.SdhitValue = value;
      }
      
      public function getSdhitValue() : Number
      {
         return Number(Number(this._anti.SdhitValue).toFixed(2));
      }
      
      private function getDeCodeValue(v:Number) : int
      {
         return Math.round(v * 100 + 21);
      }
      
      private function getDeCodeNumber(v:Number) : Number
      {
         return AUtils.numberAdd(11.5,v,2);
      }
      
      private function enCodeNumber(v:Number) : Number
      {
         return AUtils.numberSub(v,11.5,2);
      }
      
      private function enCodeValue(v:int) : Number
      {
         return (v - 21) / 100;
      }
      
      private function enCodeString(str:String) : Array
      {
         var i:* = 0;
         var slen:uint = str.length;
         var arr:Array = [];
         for(i = uint(0); i < slen; )
         {
            arr.push(str.charAt(i));
            i++;
         }
         return arr;
      }
      
      private function getDeCodeString(arr:Array) : String
      {
         var i:* = 0;
         var alen:uint = arr.length;
         var str:String = "";
         for(i = uint(0); i < alen; )
         {
            str += arr[i];
            i++;
         }
         return str;
      }
      
      public function findUsedByShowId() : String
      {
         var useStr:String = "";
         if(this.showid == 100)
         {
            useStr = "zzs";
         }
         else if(this.showid == 101)
         {
            useStr = "bs";
         }
         return useStr;
      }
      
      public function isFashion() : Boolean
      {
         if(this.type == "zbsz" || this.type == "zbcb")
         {
            return true;
         }
         return false;
      }
      
      public function isSms() : Boolean
      {
         var sit:int = this.getFillName().indexOf("sms");
         if(sit != -1)
         {
            if(this.type == "zbwp")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isMfs() : Boolean
      {
         var sit:int = this.getFillName().indexOf("mfs");
         if(sit != -1)
         {
            if(this.type == "zbwp")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isGjs() : Boolean
      {
         var sit:int = this.getFillName().indexOf("gjs");
         if(sit != -1)
         {
            if(this.type == "zbwp")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isFys() : Boolean
      {
         var sit:int = this.getFillName().indexOf("fys");
         if(sit != -1)
         {
            if(this.type == "zbwp")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isTlz() : Boolean
      {
         if(this.getFillName() == "wptlz")
         {
            if(this.type == "zbwp")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isLlz() : Boolean
      {
         if(this.getFillName() == "wpllz")
         {
            if(this.type == "zbwp")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isHlz() : Boolean
      {
         if(this.getFillName() == "wphlz")
         {
            if(this.type == "zbwp")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isFlz() : Boolean
      {
         if(this.getFillName() == "wpflz")
         {
            if(this.type == "zbwp")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isSlz() : Boolean
      {
         if(this.getFillName() == "wpslz")
         {
            if(this.type == "zbwp")
            {
               return true;
            }
         }
         return false;
      }
      
      private function isCanFallInGame() : Boolean
      {
         if(this.getFillName() == "wpqhs1" || this.getFillName() == "sms1" || this.getFillName() == "mfs1" || this.getFillName() == "fys1" || this.getFillName() == "gjs1" || this.getFillName() == "tlzsp" || this.getFillName() == "llzsp" || this.getFillName() == "hlzsp" || this.getFillName() == "flzsp" || this.getFillName() == "slzsp" || this.getFillName() == "yhs" || this.getFillName() == "tss" || this.getFillName() == "rls")
         {
            return true;
         }
         return false;
      }
      
      public function checkDataAbnormal(xmllist:XMLList) : void
      {
         if(xmllist == null || xmllist.length() <= 0)
         {
            return;
         }
         if(xmllist.ehp != undefined)
         {
            if(this.getehp() > int(xmllist.ehp) + this._anti.ten)
            {
               if(this.getFillName() == "csqq" || this.getFillName() == "l_sqq" || this.getFillName() == "zsqq" || this.getFillName() == "fsqq")
               {
                  this.setehp(int(xmllist.ehp));
               }
               else
               {
                  this._anti.__ehp = 0;
               }
            }
         }
         if(xmllist.emp != undefined)
         {
            if(this.getemp() > int(xmllist.emp) + this._anti.ten)
            {
               if(this.getFillName() == "csqq" || this.getFillName() == "l_sqq" || this.getFillName() == "zsqq" || this.getFillName() == "fsqq")
               {
                  this.setemp(int(xmllist.emp));
               }
               else
               {
                  this._anti.__emp = 0;
               }
            }
         }
         if(xmllist.eatt != undefined)
         {
            if(this.geteatt() > int(xmllist.eatt) + this._anti.ten)
            {
               if(this.getFillName() == "csqq" || this.getFillName() == "l_sqq" || this.getFillName() == "zsqq" || this.getFillName() == "fsqq")
               {
                  this.seteatt(int(xmllist.eatt));
               }
               else
               {
                  this._anti.__eatt = 0;
               }
            }
         }
         if(xmllist.edef != undefined)
         {
            if(this.getedef() > int(xmllist.edef) + this._anti.ten)
            {
               if(this.getFillName() == "csqq" || this.getFillName() == "l_sqq" || this.getFillName() == "zsqq" || this.getFillName() == "fsqq")
               {
                  this.setedef(int(xmllist.edef));
               }
               else
               {
                  this._anti.__edef = 0;
               }
            }
         }
         if(xmllist.ecrit != undefined)
         {
            if(this.getecrit() > Number(xmllist.ecrit))
            {
               if(this.getFillName() == "csqq" || this.getFillName() == "l_sqq" || this.getFillName() == "zsqq" || this.getFillName() == "fsqq")
               {
                  this.setecrit(Number(xmllist.ecrit));
               }
               else
               {
                  this._anti.__ecrit = 0;
               }
            }
         }
         if(xmllist.emiss != undefined)
         {
            if(this.getemiss() > Number(xmllist.emiss))
            {
               if(this.getFillName() == "csqq" || this.getFillName() == "l_sqq" || this.getFillName() == "zsqq" || this.getFillName() == "fsqq")
               {
                  this.setemiss(Number(xmllist.emiss));
               }
               else
               {
                  this._anti.__emiss = 0;
               }
            }
         }
         if(xmllist.eahp != undefined)
         {
            if(this.geteahp() > int(xmllist.eahp))
            {
               if(this.getFillName() == "csqq" || this.getFillName() == "l_sqq" || this.getFillName() == "zsqq" || this.getFillName() == "fsqq")
               {
                  this.seteahp(int(xmllist.eahp));
               }
               else
               {
                  this._anti.__eahp = 0;
               }
            }
         }
         if(xmllist.eamp != undefined)
         {
            if(this.geteamp() > int(xmllist.eamp))
            {
               if(this.getFillName() == "csqq" || this.getFillName() == "l_sqq" || this.getFillName() == "zsqq" || this.getFillName() == "fsqq")
               {
                  this.seteamp(int(xmllist.eamp));
               }
               else
               {
                  this._anti.__eamp = 0;
               }
            }
         }
         if(xmllist.magicdef != undefined)
         {
            if(this.getmagicdef() > Number(xmllist.magicdef))
            {
               if(this.getFillName() == "csqq" || this.getFillName() == "l_sqq" || this.getFillName() == "zsqq" || this.getFillName() == "fsqq")
               {
                  this.setmagicdef(Number(xmllist.magicdef));
               }
               else
               {
                  this._anti.__magicdef = 0;
               }
            }
         }
         if(xmllist.eupdata != undefined)
         {
            if(this.getEUpdata() > Number(xmllist.eupdata))
            {
               this._anti.__eupdata = 0;
            }
         }
         if(this.geteatblood() > 0)
         {
            this.seteatblood(0);
         }
      }
   }
}
