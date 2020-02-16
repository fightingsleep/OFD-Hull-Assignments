terms = [1,2,3,4,5]
zeroRates = [3, 4, 4.6, 5.0, 5.3]

zeroRate = input("Forward rate term:")
forwardRateCurve = []

for i in range(0,len(terms)):
    if i - 1 >= 0:
        forwardRateCurve.append((zeroRates[i] * terms[i] - zeroRates[i-1] * terms[i-1]) / (terms[i] - terms[i-1]))

print(forwardRateCurve)
