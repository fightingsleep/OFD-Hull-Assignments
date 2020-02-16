classdef Bond
  properties
    Principal
    Term
    Coupon
    MarketPrice
  end
  methods        
    function obj = Bond(p,t,c,m)
        obj.Principal = p;
        obj.Term = t;
        obj.Coupon = c;
        obj.MarketPrice = m;
    end
    
    function disp (obj)
      printf("Principal: %f\nTerm: %f\nCoupon: %f\nMarketPrice: %f\n", ...
        obj.Principal, obj.Term, obj.Coupon, obj.MarketPrice)
    end
  end
end