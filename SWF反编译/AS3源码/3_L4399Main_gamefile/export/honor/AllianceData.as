package export.honor
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   
   public class AllianceData
   {
       
      
      private var _anti:Antiwear;
      
      public function AllianceData()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         this.honorName = "";
         this.jobName = "";
         this.score = 0;
         this.allianceLevel = 1;
         this.groupId = -1;
         this.isAbled = true;
         this.nicheng = "";
      }
      
      public function findTypeIdByFillName(_fillName:String) : uint
      {
         switch(_fillName)
         {
            case "4399忠实玩家":
               return 1;
            case "造梦英雄":
               return 2;
            case "白牡丹":
               return 3;
            case "乐谱":
               return 4;
            case "拐杖":
               return 5;
            case "毛驴":
               return 6;
            case "檀木":
               return 7;
            case "玄铁":
               return 8;
            case "丝绸":
               return 9;
            case "避水珠":
               return 10;
            case "龙王令":
               return 11;
            case "骰子":
               return 12;
            case "金白菜":
               return 13;
            case "竹枕":
               return 14;
            case "梳妆镜":
               return 15;
            default:
               return 0;
         }
      }
      
      public function findPriceByFillName(_fillName:String) : uint
      {
         switch(_fillName)
         {
            case "_4399zswj":
            case "_zmxyanniversary":
               return 100;
            case "bmd":
            case "yp":
               return 150;
            case "gz":
            case "ml":
               return 160;
            case "sz":
            case "jbc":
               return 170;
            case "zz":
            case "szj":
               return 180;
            case "wptm":
            case "wpxt":
               break;
            case "wpsc":
               break;
            case "wpbsz":
            case "wplwl":
               return 20;
            default:
               return 0;
         }
         return 100;
      }
      
      public function get honorName() : String
      {
         return this._anti._honorName;
      }
      
      public function set honorName(value:String) : void
      {
         this._anti._honorName = value;
      }
      
      public function get jobName() : String
      {
         return this._anti._jobName;
      }
      
      public function set jobName(value:String) : void
      {
         this._anti._jobName = value;
      }
      
      public function get score() : uint
      {
         return this._anti._score;
      }
      
      public function set score(value:uint) : void
      {
         this._anti._score = value;
      }
      
      public function get allianceLevel() : uint
      {
         return this._anti._allianceLevel;
      }
      
      public function set allianceLevel(value:uint) : void
      {
         this._anti._allianceLevel = value;
      }
      
      public function get groupId() : int
      {
         return this._anti._groupId;
      }
      
      public function set groupId(value:int) : void
      {
         this._anti._groupId = value;
      }
      
      public function get isAbled() : Boolean
      {
         return this._anti._isAbled;
      }
      
      public function set isAbled(value:Boolean) : void
      {
         this._anti._isAbled = value;
      }
      
      public function get nicheng() : String
      {
         return this._anti._nicheng;
      }
      
      public function set nicheng(value:String) : void
      {
         this._anti._nicheng = value;
      }
   }
}
