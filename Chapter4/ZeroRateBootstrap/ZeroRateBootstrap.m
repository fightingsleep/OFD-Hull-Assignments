# A very basic implementation of the zero rate bootstrap method described
# in Futures, Options, and Other Derivatives textbook
#
# Author: Chris Ross

function zeroRateCurve = ZeroRateBootstrap()

  bonds = {
    Bond(100,0.25,0,97.5),
    Bond(100,0.5,0,94.9),
    Bond(100,1,0,90.0),
    Bond(100,1.5,8,96.0),
    Bond(100,2,12,101.6)
  }
  
  zeroRateCurve = []
  terms = []
  
  for i = 1:length(bonds)
    terms = [terms bonds{i}.Term]
  end

  for i = 1:length(bonds)
    b = bonds{i}
    if b.Coupon == 0
      zeroRateCurve = [
        zeroRateCurve,
        CalcZeroRateForZeroCouponBond(b)
      ]
    elseif b.Coupon > 0
      zeroRateCurve = [
        zeroRateCurve,
        CalcZeroRateForCouponBond(b, zeroRateCurve, terms)
      ]
    end
  endfor
  
  function zeroRate = CalcZeroRateForZeroCouponBond(b)
    compFreq = 1/b.Term
    ret = b.Principal - b.MarketPrice
    rate = (ret * compFreq) / b.MarketPrice
    zeroRate = compFreq * log(1 + (rate/compFreq))
  end
  
  function zeroRate = CalcZeroRateForCouponBond(b, curve, terms)
    interestPayments = 0
    # Assume semiannual coupon
    couponValue = (b.Principal * b.Coupon/100) / 2
    for i = 1:length(curve)
      if mod(terms(i), 0.5) == 0
        interestPayments = interestPayments + ...
          couponValue * exp(-curve(i) * terms(i))
      end
    end
    zeroRate = -log((b.MarketPrice - interestPayments) / ...
      (b.Principal + couponValue)) / b.Term
  end
end