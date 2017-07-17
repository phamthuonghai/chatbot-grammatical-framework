concrete SubwayEng of Subway = {

flags language = en_US;

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
  Order = "Hi. What would you like to order?" ;
  ListItem = "What else would you like?" ;

  SubwaySize = "What size subways would you like?" ;
  SubwayNumber = "How many subways would you like?" ;
  Fillings = "What fillings would you like?" ;

  DrinkSize = "What size drinks would you like?" ;
  DrinkNumber = "How many drinks would you like?" ;
  DrinkType = "What type of drink would you like?" ;

lin
  order is = { s = is.s!User } ;

  ConsItem x xs = { s = table {
		      User => variants { x.s ++ "and" ++ xs.s!User; x.s };
                      System => case xs.l of {
			           Empty => x.s ++ xs.s!System;
				   NonEmpty => x.s ++ "and" ++ xs.s!System
                                 } };
                    l = NonEmpty } ;
  BaseItem = { s = table { 
                     User => "nothing" ++ variants { "else" ; [] } 
		              ++ variants { please; thanks };
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
	 } ++ please } ;

  drink n s t = { s = giveMe ++
		    variants { n.s ++ s.s ++ t.s!n.n; 
				  n.s ++ t.s!n.n } 
		    ++ please } ;

lin
  subwayNumber n = n ;
  drinkNumber n = n ;

lin
  num_1 = { s = variants { "one"; "a" }; n = Sg } ;
  num_2 = { s = "two";   n = Pl } ;
  num_3 = { s = "three"; n = Pl } ;
  num_4 = { s = "four";  n = Pl } ;
  num_5 = { s = "five";  n = Pl } ;

lin
  subwaySize s = s ;
  drinkSize s = s ;

lin
  small  = { s = variants {"small"; "short"} } ;
  large  = { s = variants {"large"; "big"; "long" } } ;

lin
  cheese    = { s = "cheese" } ;
  ham       = { s = "ham" } ;
  tuna = { s = "tuna" } ;
  bacon = { s = "bacon" } ;
  chicken = { s = "chicken" } ;

lin
  fillings ts = { s = table { 
		             FillAdj  => ts.s;
			     FillPrep => "with" ++ ts.s
		      } };

  BaseFilling t = { s = t.s } ;
  ConsFilling t ts = { s = t.s ++ variants { "and"; []} ++ ts.s } ;

lin 
  coke = coke_N ;
  beer = beer_N ;


oper 
  giveMe = variants { [] ;  ["I want"]; ["I would like"]; ["give me"];
                      ["I want to order"]; ["I would like to order"];
		      ["I want to have"]; } ;
  please = variants { [] ; "please" } ;
  thanks = variants { [] ; "thanks"; ["thank you"] } ;

  subway_N = regN "subway" ;
  coke_N = variants { regN "coke"; regN ["coca cola"] } ;
  beer_N = regN "beer" ;

  regN : Str -> { s : Num => Str } = 
          \x -> { s = table { Sg => x; Pl => x + "s" } } ;


lincat 
  Output = { s : Str } ;

lin
  confirm o = { s = ["Thank you for ordering"] ++ o.s!System ++ "."} ;

}
