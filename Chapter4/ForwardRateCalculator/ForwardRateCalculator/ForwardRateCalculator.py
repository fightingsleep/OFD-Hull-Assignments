# Example input: [1,2,3,4,5]
terms = eval(input('Input a list of terms: '))
# Example input: [3,4,4.6,5,5.3]
zeroRates = eval(input('Input a list of continuously compounded zero rates: '))

forwardRateCurve = []

for i in range(0,len(terms)):
    if i - 1 >= 0:
        forwardRateCurve.append(round((zeroRates[i] * terms[i] - zeroRates[i-1] * terms[i-1]) / (terms[i] - terms[i-1]), 4))

print('Implied forward rates: ', forwardRateCurve)
