#!/bin/bash
H=`pwd`
echo $H

# generate csv
for d in test dev train;
do
  cd $d
  echo deal with $d
  echo 'wav_filename,wav_filesize,transcript' > ../thchs30-$d.csv
  for f in `ls *wav`;
  do
    echo $H/$d/$f,`du -b $f | awk '{print $1}'`,`head -n 1 ../data/$f.trn` >> ../thchs30-$d.csv
  done
  head -n 3 ../thchs30-$d.csv > ../$d.csv
  cd ..
done

# easy way to get vocabulary
ls data/*.trn | xargs -x head -n 1 | grep -v '==' | awk NF > thchs30-vocabulary.txt


# easy way to get alphabet
awk -F "" '{for(i=1;i<=NF;++i) print $i}' thchs30-vocabulary.txt | uniq | sort | uniq > thchs30-alphabet.txt
