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

# TI/TV CODING NOVEL
# Changed /dev/stdin to - ...will see if that will help with the random null file creation

START_TITV_CODING_NOVEL=`date '+%s'`

$SAMTOOLS_DIR/bcftools/vcfutils.pl qstats $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".QC.Coding.Novel.TiTv.vcf" \
>| $CORE_PATH/$OUT_PROJECT/REPORTS/TI_TV_MS/CODING/$SM_TAG"_Coding_Novel_titv.txt"

END_TITV_CODING_NOVEL=`date '+%s'`

HOSTNAME=`hostname`

echo $SM_TAG"_"$IN_PROJECT",L.01,TITV_CODING_NOVEL,"$HOSTNAME","$START_TITV_CODING_NOVEL","$END_TITV_CODING_NOVEL \
>> $CORE_PATH/$IN_PROJECT/REPORTS/$IN_PROJECT".WALL.CLOCK.TIMES.csv"

# something is wrong with the echo here...

# echo zcat $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".QC.Coding.Novel.TiTv.vcf.gz" \
# | $SAMTOOLS_DIR/bcftools/vcfutils.pl qstats /dev/stdin \
# \>\| $CORE_PATH/$OUT_PROJECT/REPORTS/TI_TV_MS/CODING/$SM_TAG"_Coding_Novel_titv.txt" \
# >> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"

echo >> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"
