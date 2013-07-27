10 dim a(2)
20 dim b(2,10)
30 dim c(2,3,4)
40 dim d$(2)
50 dim e$(2,3)
60 dim f$(2,3,4)
100 for j = 1 to 2:for i = 1 to 10:b(j,i)=i*2+j:next:next
110 for j = 1 to 2:for i = 1 to 10:print b(j,i):next:next
