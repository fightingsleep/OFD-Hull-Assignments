# A very basic implementation of the zero rate bootstrap method described
# in Futures, Options, and Other Derivatives textbook
#
# Author: Chris Ross

a = Bond(100,0.25,0,97.5)
b = Bond(100,0.5,0,94.9)
c = Bond(100,1,0,90.0)
d = Bond(100,1.5,8,96.0)
e = Bond(100,2,12,101.6)

bonds = {a,b,c,d,e}

zeroRateCurve = {}

for i = 1:length(bonds)
  b = bonds{i}
  if b.Coupon == 0 && mod(b.Term, 0.5) == 0
    compFreq = 1/b.Term
    ret = b.Principal - b.MarketPrice
    rate = (ret * compFreq) / b.MarketPrice
    contRate = compFreq * log(1 + (rate/compFreq))
    zeroRateCurve{length(zeroRateCurve) + 1} = contRate
  elseif (b.Coupon > 0)
    # Assume semiannual coupon
    j = length(zeroRateCurve)
    answer = 0
    couponValue = (b.Principal * b.Coupon/100) / 2
    while j > 0
      answer = answer + couponValue * exp(-1 * zeroRateCurve{j} * j/2)
      j = j - 1
    end
    answer = -1 * log((b.MarketPrice - answer) / (b.Principal + couponValue)) / b.Term
    zeroRateCurve{length(zeroRateCurve) + 1} = answer
  end
endfor