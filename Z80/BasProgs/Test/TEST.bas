10 print "Hello"
20 print "World!":print
25 input "Enter number: ",a
30 for i = 1 to 10
40 print i,i*a
50 next i:goto 80
60 a$ = "Test!":b$ = " :-)":c$ = a$+b$
70 print c$:print:print
80 for i = 0 to 2 step 0.04
90 print tab(int(sin(i*PI)*39)+39);"*"
100 next i
