dim a(5,2)
dim b$(5,2)

for i = 1 to 5
  read a(i,1)
next a

for i = 1 to 5
  read b$(i,2)
next i

for i = 1 to 5
  print a(i,1),b$(i,2)
next i

data 3,6,9,12,15
data "Aa","Bb","Cc","Dd","Ee"
