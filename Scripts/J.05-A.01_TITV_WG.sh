# ---qsub parameter settings---
# --these can be overrode at qsub invocation--

# tell sge to execute in bash
#$ -S /bin/bash

# tell sge to submit any of these queue when available
#$ -q rnd.q,prod.q,test.q,bigdata.q

# tell sge that you are in the users current working directory
#$ -cwd

# tell sge to export the users environment variables
#$ -V

# tell sge to submit at this priority setting
#$ -p -1020

# tell sge to output both stderr and stdout to the same file
#$ -j y

# export all variables, useful to find out what compute node the program was executed on
# redirecting stderr/stdout to file as a log.

set

echo

SAMTOOLS_DIR=$1
CORE_PATH=$2

IN_PROJECT=$3
OUT_PROJECT=$4
SM_TAG=$5

# TI/TV WHOLE GENOME ALL

START_TITV_WG_ALL=`date '+%s'`

zcat $CORE_PATH/$OUT_PROJECT/SNV/MULTI/WHOLE_GENOME/PASS_VARIANT/$SM_TAG".WHOLE.GENOME.SNV.VARIANT.PASS.vcf.gz" \
| $SAMTOOLS_DIR/bcftools/vcfutils.pl qstats /dev/stdin \
>| $CORE_PATH/$OUT_PROJECT/REPORTS/TI_TV/WHOLE_GENOME/$SM_TAG"_WG_All_titv.txt"

END_TITV_WG_ALL=`date '+%s'`

HOSTNAME=`hostname`

echo $SM_TAG"_"$IN_PROJECT",K.01,TITV_WG_ALL,"$HOSTNAME","$START_TITV_WG_ALL","$END_TITV_WG_ALL \
>> $CORE_PATH/$IN_PROJECT/REPORTS/$IN_PROJECT".WALL.CLOCK.TIMES.csv"

# echo zcat $CORE_PATH/$OUT_PROJECT/SNV/MULTI/WHOLE_GENOME/PASS_VARIANT/$SM_TAG".WHOLE.GENOME.SNV.VARIANT.PASS.vcf.gz" \
# | $SAMTOOLS_DIR/bcftools/vcfutils.pl qstats /dev/stdin \
# \>\| $CORE_PATH/$OUT_PROJECT/REPORTS/TI_TV/WHOLE_GENOME/$SM_TAG"_WG_All_titv.txt" \
# >> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"

echo >> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"
