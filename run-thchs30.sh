#!/bin/bash

mode="debug"
if [ $# -gt 0 ]; then
  mode=$1
fi
echo $mode

ALPHABET=data_thchs30/thchs30-alphabet.txt
LM_BINARY=data_thchs30/thchs30-lm.binary
LM_TRIE=data_thchs30/thchs30-trie

TRAIN_CSV=data_thchs30/thchs30-train.csv
DEV_CSV=data_thchs30/thchs30-dev.csv
TEST_CSV=data_thchs30/thchs30-test.csv

if [ $mode == "debug" ]; then
  TRAIN_CSV=data_thchs30/train.csv
  DEV_CSV=data_thchs30/dev.csv
  TEST_CSV=data_thchs30/test.csv
fi

BATCH_SIZE=1
checkpoint_dir=./thchs30_checkpoint_dir
DATA_DIR=./thchs30_models

python -u DeepSpeech.py \
  --alphabet_config_path $ALPHABET \
  --lm_binary_path $LM_BINARY \
  --lm_trie_path $LM_TRIE \
  --train_files $TRAIN_CSV \
  --dev_files $DEV_CSV \
  --test_files $TEST_CSV \
  --train_batch_size $BATCH_SIZE \
  --dev_batch_size $BATCH_SIZE \
  --test_batch_size $BATCH_SIZE \
  --n_hidden 512 \
  --learning_rate 0.001 \
  --epoch 75 \
  --checkpoint_dir "$checkpoint_dir" \
  --export_dir "$DATA_DIR" \
  --log_level 0 \
  --summary_secs 30 \
  "$@"
