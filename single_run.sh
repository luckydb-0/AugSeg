tport=53907
ngpu=1
ROOT=/content/AugSeg

CUDA_VISIBLE_DEVICES=0,1 \
torchrun \
    --nproc_per_node=${ngpu} \
    --node_rank=0 \
    --master_port=${tport} \
    $ROOT/train_semi.py \
    --config=$ROOT/exps/zrun_vocs_u2pl/voc_semi662/config_semi.yaml --seed 2 --port ${tport}
