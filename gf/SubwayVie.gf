concrete SubwayVie of Subway = {

flags language = vi_VN;

param 
  Num = Sg | Pl ;
  FillingUse = FillAdj | FillPrep ;
  Speaker = User | System ;
  Length = Empty | NonEmpty ;

lincat
  Order = { s : Str } ;
  Item = { s : Str } ;
  [Item] = { s : Speaker => Str; l : Length } ;
  Number, SubwayNumber, DrinkNumber = { s : Str; n : Num } ;
  Size, SubwaySize, DrinkSize = { s : Str } ;
  Fillings = { s : FillingUse => Str } ;
  Filling = { s : Str } ;
  ListFilling = { s : Str } ;
  DrinkType = { s : Num => Str } ;

printname cat
  Order = "Xin chào. Bạn muốn dùng gì?" ;
  ListItem = "Bạn còn muốn dùng gì nữa không?" ;

  SubwaySize = "Bạn muốn dùng loại bánh nhỏ hay lớn?" ;
  SubwayNumber = "Bạn muốn dùng bao nhiêu bánh?" ;
  Fillings = "Bạn muốn dùng bánh với nhân gì?" ;

  DrinkSize = "Bạn muốn ly lớn hay nhỏ?" ;
  DrinkNumber = "Bạn muốn bao nhiêu ly?" ;
  DrinkType = "Bạn muốn dùng loại nước nào?" ;

lin
  order is = { s = is.s!User } ;

  ConsItem x xs = { s = table {
		      User => variants { x.s ++ "với" ++ xs.s!User; x.s };
                      System => case xs.l of {
			           Empty => x.s ++ xs.s!System;
				   NonEmpty => x.s ++ "với" ++ xs.s!System
                                 } };
                    l = NonEmpty } ;
  BaseItem = { s = table { 
                     User => "không" 
		              ++ variants { thanks };
                     System => [] };
               l = Empty } ;

  subway n s ts = 
    { s = giveMe ++
  	  variants { n.s ++ s.s ++ subway_N.s!n.n ++ ts.s!FillPrep ;
		     n.s ++ s.s ++ ts.s!FillAdj ++ subway_N.s!n.n ;
		     -- no size given:
		     n.s ++ subway_N.s!n.n ++ ts.s!FillPrep;
		     n.s ++ ts.s!FillAdj ++ subway_N.s!n.n;
		     -- no fillings given
		     n.s ++ s.s ++ subway_N.s!n.n;
		     -- no fillings or size given:
		     n.s ++ subway_N.s!n.n
	 } } ;

  drink n s t = { s = giveMe ++
		    variants { n.s ++ s.s ++ t.s!n.n; 
				  n.s ++ t.s!n.n } 
		    } ;

lin
  subwayNumber n = n ;
  drinkNumber n = n ;

lin
  num_1 = { s = variants { "một" }; n = Sg } ;
  num_2 = { s = "hai";   n = Pl } ;
  num_3 = { s = "ba"; n = Pl } ;
  num_4 = { s = "bốn";  n = Pl } ;
  num_5 = { s = "năm";  n = Pl } ;

lin
  subwaySize s = s ;
  drinkSize s = s ;

lin
  small  = { s = variants {"ngắn"; "nhỏ"} } ;
  large  = { s = variants {"dài"; "lớn"} } ;

lin
  cheese    = { s = "phô mai" } ;
  ham       = { s = "thịt nguội" } ;
  tuna = { s = "cá ngừ" } ;
  bacon = { s = "thịt hun khói" } ;
  chicken = { s = "thịt gà" } ;

lin
  fillings ts = { s = table { 
		             FillAdj  => ts.s;
			     FillPrep => "with" ++ ts.s
		      } };

  BaseFilling t = { s = t.s } ;
  ConsFilling t ts = { s = t.s ++ variants { "với"; []} ++ ts.s } ;

lin 
  coke = coke_N ;
  beer = beer_N ;


oper 
  giveMe = variants { [] ;  ["Tôi muốn"]; ["Cho tôi"]; ["Tôi muốn đặt"];
                      ["Làm cho tôi"]; ["Cho"];} ;
  thanks = variants { [] ; "cảm ơn"; ["cám ơn"] } ;

  subway_N = regN "phần" ;
  coke_N = variants { regN "coke"; regN "coca"; regN ["coca cola"] } ;
  beer_N = regN "bia" ;

  regN : Str -> { s : Num => Str } = 
          \x -> { s = table { Sg => x; Pl => x } } ;


lincat 
  Output = { s : Str } ;

lin
  confirm o = { s = ["Cảm ơn bạn đã đặt"] ++ o.s!System ++ "."} ;

}
