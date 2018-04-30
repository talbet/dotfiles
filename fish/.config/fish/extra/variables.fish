# add /usr/local/sbin to your PATH Variable
set extrapaths\
  /usr/local/sbin\
  /usr/local/opt/python/libexec/bin

for val in $extrapaths
  test -d "$val"; and set PATH $PATH $val
end